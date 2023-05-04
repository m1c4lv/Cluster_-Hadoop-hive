FROM hadoop-base

ENV HIVE_VERSION 3.1.2

ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH
ENV HADOOP_HOME /opt/hadoop-$HADOOP_VERSION
ENV HIVE_URL https://downloads.apache.org/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz

WORKDIR /opt


#Instala Hive y SQL-server-conector
RUN curl -fSL "https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-j_8.0.32-1debian11_all.deb" -o ./conector.deb
RUN dpkg -i ./conector.deb
RUN rm ./conector.deb
RUN set -x \
    && curl -fSL "$HIVE_URL" -o /tmp/hive.tar.gz \
    && tar -xzvf /tmp/hive.tar.gz -C /opt \
    && mv apache-hive-$HIVE_VERSION-bin hive \
    && ln -s /usr/share/java/mysql-connector-j-8.0.32.jar $HIVE_HOME/lib/mysql-connector-j-8.0.32.jar \
    && rm /tmp/hive.tar.gz*


#Configuraciones por defecto
#ADD hive-site.xml $HIVE_HOME/conf
ADD conf/* $HIVE_HOME/conf

COPY script_hive.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/script_hive.sh

COPY script_schematool.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/script_schematool.sh

EXPOSE 10000
EXPOSE 10002

CMD ["/usr/local/bin/script_hive.sh"]
