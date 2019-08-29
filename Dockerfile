FROM openjdk:7
LABEL maintainer="Emertyl <lremy@is4ri.com>"

WORKDIR /usr/local

ENV LIFERAY_HOME=/usr/local/liferay-portal
ENV LIFERAY_BUNDLE=liferay-portal-tomcat.tar.gz
ENV CATALINA_HOME=$LIFERAY_HOME/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH
ENV LIFERAY_TOMCAT_URL=https://cdn.lfrs.sl/releases.liferay.com/portal/7.2.0-ga1/liferay-ce-portal-tomcat-7.2.0-ga1-20190531153709761.tar.gz

RUN apt-get -qq update && \
	apt-get -qq install telnet && \
	apt-get -qq clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	useradd -ms /bin/bash liferay && \
	set -x && \
	curl -fSL "$LIFERAY_TOMCAT_URL" -o "$LIFERAY_BUNDLE" && \
	tar xvzf "$LIFERAY_BUNDLE" && \
	rm "$LIFERAY_BUNDLE" && \
	mv /usr/local/liferay-portal-7.2.0-ga1 $LIFERAY_HOME && \
	mv $LIFERAY_HOME/tomcat-9.0.17 $CATALINA_HOME && \
	rm -rf $CATALINA_HOME/work/* && \
	mkdir -p $LIFERAY_HOME/data/document_library && \
	mkdir -p $LIFERAY_HOME/data/lucene && \
	mkdir -p $LIFERAY_HOME/deploy && \
	mkdir -p $LIFERAY_HOME/logs && \
	mkdir -p $LIFERAY_HOME/is4ri && \
	echo "liferay.home=$LIFERAY_HOME" >> $CATALINA_HOME/webapps/ROOT/WEB-INF/classes/portal-ext.properties && \
	echo "include-and-override=\${liferay.home}/is4ri/portal-is4ri.properties" >> $CATALINA_HOME/webapps/ROOT/WEB-INF/classes/portal-ext.properties

COPY ./conf/setenv.sh $CATALINA_HOME/bin/setenv.sh

RUN chown -R liferay:liferay $LIFERAY_HOME

USER liferay

EXPOSE 8080/tcp
EXPOSE 9901/tcp

HEALTHCHECK \
	--interval=1m \
	--start-period=1m \
	--timeout=1m \
	CMD curl -fsS "http://localhost:8080/c/portal/layout" || exit 1

CMD $CATALINA_HOME/bin/startup.sh && tail -f $CATALINA_HOME/logs/catalina.out
