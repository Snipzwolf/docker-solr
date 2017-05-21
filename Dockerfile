FROM ubuntu:16.04

ENV DEBCONF_NONINTERACTIVE_SEEN="true" \
    DEBIAN_FRONTEND="noninteractive"

ENV REPLICATION_MASTER="true" \
    REPLICATION_SLAVE="false" \
    REPLICATION_HOST="127.0.0.1:8986" \
    JAVA_STACKSIZE="4m" \
    JAVA_HEAPSIZE="512m" \
    JAVA_PERMSIZE="24m"

COPY src/entrypoint.sh /entrypoint
COPY dists/apache-solr-3.6.2.tgz /opt/solr/
COPY dists/apache-tomcat-8.5.15.tar.gz /opt/tomcat/
COPY src/schema.xml /etc/solr/
COPY src/solr.xml /etc/solr/
COPY src/solrconfig.xml /etc/solr/example/
COPY src/logging.properties /etc/solr/
RUN chmod 0555 /entrypoint && \
    tar -xf /opt/solr/apache-solr-3.6.2.tgz -C /opt/solr/ --strip 1 && \
    tar -xf /opt/tomcat/apache-tomcat-8.5.15.tar.gz -C /opt/tomcat/ --strip 1 && \
    rm /opt/tomcat/apache-tomcat-8.5.15.tar.gz /opt/solr/apache-solr-3.6.2.tgz && \
    mv /opt/solr/dist/apache-solr-3.6.2.war /opt/tomcat/webapps/solr.war && \
    mkdir -pv /etc/solr/ /var/solr/ /opt/solr/lib/ && \
    addgroup --system --gid 501 solr && \
    useradd -u 501 -r -g 501 -s /bin/false -M solr && \
    chmod -R 0555 /entrypoint && \
    /bin/bash -c "chmod -R 0664 {/etc/solr/,/var/solr/,/opt/} && find {/etc/solr/,/var/solr/,/opt/} -type d -exec chmod 775 {} \;" && \
    chown -R solr:solr /etc/solr/ /var/solr/ /opt/solr/ /opt/tomcat/

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y autoremove && \
    apt-get clean

RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y openjdk-7-jdk && \
    setcap 'cap_net_bind_service=+ep' /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN rm -rf /var/lib/apt/lists/*

VOLUME ["/var/log/solr"]

ENTRYPOINT /entrypoint
