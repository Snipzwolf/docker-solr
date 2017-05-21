#!/usr/bin/env bash

java -server -verbose -classpath /opt/tomcat/bin/bootstrap.jar:/opt/tomcat/bin/tomcat-juli.jar -Dcatalina.home=/opt/tomcat -Djava.endorsed.dirs=/opt/tomcat/endorsed \
  -Dsolr.solr.home=/etc/solr/ -Dcatalina.logs=/var/logs/solr/ \
  -Djava.util.logging.config.file=/etx/solr/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager \
  -Xmx$JAVA_HEAPSIZE -Xms$JAVA_HEAPSIZE -Xss$JAVA_STACKSIZE -XX:PermSize=$JAVA_PERMSIZE \
  -Dreplication.slave=$REPLICATION_SLAVE -Dreplication.master=$REPLICATION_MASTER \
  -Dreplication.slave.masterHost=$REPLICATION_HOST \
  org.apache.catalina.startup.Bootstrap
