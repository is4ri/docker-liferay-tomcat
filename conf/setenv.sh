CATALINA_OPTS="-Djava.locale.providers=JRE,COMPAT,CLDR"
CATALINA_OPTS="$CATALINA_OPTS -Djava.awt.headless=true -XX:+UseG1GC -Duser.timezone=Europe/Paris" # java base settings
CATALINA_OPTS="$CATALINA_OPTS -Xms2048M -Xmx2048M" # java-memory-settings
CATALINA_OPTS="$CATALINA_OPTS -Dfile.encoding=UTF8 -Djava.net.preferIPv4Stack=true  -Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false"
CATALINA_OPTS="$CATALINA_OPTS -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp/dump.hprof" # provide dump on OutOfMemoryError
CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.port=9901 -Dcom.sun.management.jmxremote.rmi.port=9901 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Djava.rmi.server.hostname=localhost" # JMX settings

# CATALINA_OPTS="-XX:MaxNewSize=1536m -XX:MaxMetaspaceSize=512m -XX:MetaspaceSize=512m -XX:NewSize=1536m -XX:SurvivorRatio=7"
