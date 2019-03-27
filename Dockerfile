FROM openjdk:7
LABEL maintainer="Emertyl <lremy@is4ri.com>"

WORKDIR /usr/local

ENV LIFERAY_HOME=/usr/local/liferay-portal
ENV CATALINA_HOME=$LIFERAY_HOME/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH
ENV LIFERAY_TOMCAT_URL=https://cdn.lfrs.sl/releases.liferay.com/portal/6.2.3-ga4/liferay-portal-tomcat-6.2-ce-ga4-20150416163831865.zip

RUN apt-get -qq update && \
	apt-get -qq install telnet && \
	apt-get -qq clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	useradd -ms /bin/bash liferay && \
	set -x && \
	curl -fSL "$LIFERAY_TOMCAT_URL" -o liferay-portal-tomcat.zip && \
	unzip liferay-portal-tomcat.zip && \
	rm liferay-portal-tomcat.zip && \
	mv /usr/local/liferay-portal-6.2-ce-ga4 $LIFERAY_HOME && \
	mv $LIFERAY_HOME/tomcat-7.0.42 $CATALINA_HOME && \
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

CMD $CATALINA_HOME/bin/startup.sh && tail -f $CATALINA_HOME/logs/catalina.out
