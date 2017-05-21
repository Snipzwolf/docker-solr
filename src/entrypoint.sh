#!/usr/bin/env bash

su -c "java -server -classpath /opt/tomcat/bin/bootstrap.jar:/opt/tomcat/bin/tomcat-juli.jar -Dcatalina.home=/opt/tomcat -Djava.endorsed.dirs=/opt/tomcat/endorsed"\
"   -Dsolr.solr.home=/etc/solr/ -Dcatalina.logs=/var/log/solr/"\
"   -Djava.util.logging.config.file=/etc/solr/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager"\
"   -Xmx$JAVA_HEAPSIZE -Xms$JAVA_HEAPSIZE -Xss$JAVA_STACKSIZE -XX:PermSize=$JAVA_PERMSIZE"\
"   -Dreplication.slave=$REPLICATION_SLAVE -Dreplication.master=$REPLICATION_MASTER"\
"   -Dreplication.slave.masterHost=$REPLICATION_HOST"\
"    org.apache.catalina.startup.Bootstrap" -s /bin/bash solr
