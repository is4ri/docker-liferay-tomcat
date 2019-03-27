
JAVA_OPTS="-Djava.awt.headless=true -XX:+UseG1GC -Dfile.encoding=UTF8 -Duser.timezone=Europe/Paris $JAVA_OPTS " # java base settings
JAVA_OPTS="-XX:MaxPermSize=512M -Xms1024M -Xmx2048M $JAVA_OPTS " # java-memory-settings

CATALINA_OPTS="$CATALINA_OPTS -Dfile.encoding=UTF8 -Djava.net.preferIPv4Stack=true  -Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false"
CATALINA_OPTS="$CATALINA_OPTS -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp/dump.hprof" # provide dump on OutOfMemoryError
CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.port=9901 -Dcom.sun.management.jmxremote.rmi.port=9901 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Djava.rmi.server.hostname=localhost" # JMX settings


