FROM hadoop-base

ENV HIVE_VERSION 3.1.2

ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH
ENV HADOOP_HOME /opt/hadoop-$HADOOP_VERSION
ENV HIVE_URL https://downloads.apache.org/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz

WORKDIR /opt


#Instala Hive y SQL-server
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \ 
      libmysql-java \
    && rm -rf /var/lib/apt/lists/*

RUN set -x \
    && curl -fSL "$HIVE_URL" -o /tmp/hive.tar.gz \
    && tar -xzvf /tmp/hive.tar.gz -C /opt \
    && mv apache-hive-$HIVE_VERSION-bin hive \
    && ln -s /usr/share/java/mysql-connector-java.jar $HIVE_HOME/lib/mysql-connector-java.jar \
    && rm /tmp/hive.tar.gz*


#Configuraciones por defecto
#ADD hive-site.xml $HIVE_HOME/conf
ADD conf/* $HIVE_HOME/conf

COPY script_hive.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/script_hive.sh

EXPOSE 10000
EXPOSE 10002

CMD ["/usr/local/bin/script_hive.sh"]
