FROM hadoop-base

ENV HIVE_VERSION 3.1.2

ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH
ENV HADOOP_HOME /opt/hadoop-$HADOOP_VERSION
ENV HIVE_URL https://downloads.apache.org/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz
ENV POSTG_URL https://jdbc.postgresql.org/download/postgresql-9.4.1209.jre7.jar

WORKDIR /opt


#Instala Hive y PostgreSQL JDBC
RUN set -x \
    && curl -fSL "$HIVE_URL" -o /tmp/hive.tar.gz \
    && tar -xzvf /tmp/hive.tar.gz -C /opt \
    && mv apache-hive-$HIVE_VERSION-bin hive \
    && curl -fSL "$POSTG_URL" -o $HIVE_HOME/lib/postgresql-jdbc.jar \
    && rm /tmp/hive.tar.gz*


#Configuraciones por defecto
RUN cp $HIVE_HOME/conf/hive-default.xml.template $HIVE_HOME/conf/hive-site.xml
RUN cp $HIVE_HOME/conf/beeline-log4j2.properties.template $HIVE_HOME/conf/beeline-log4j2.properties # para conectar con hive_server
RUN cp $HIVE_HOME/conf/hive-env.sh.template $HIVE_HOME/conf/hive-env.sh
RUN cp $HIVE_HOME/conf/hive-exec-log4j2.properties.template $HIVE_HOME/conf/hive-exec-log4j2.properties
RUN cp $HIVE_HOME/conf/hive-log4j2.properties.template $HIVE_HOME/conf/hive-log4j2.properties
ADD ivysettings.xml $HIVE_HOME/conf
RUN cp $HIVE_HOME/conf/llap-daemon-log4j2.properties.template $HIVE_HOME/conf/llap-daemon-log4j2.properties

COPY script_hive.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/script_hive.sh

EXPOSE 10000
EXPOSE 10002

CMD ["/usr/local/bin/script_hive.sh"]
