FROM hadoop-base

RUN mkdir -p /opt/volume/namenode
VOLUME /opt/volume/namenode

ADD conf/hdfs-site.xml /etc/hadoop/

ADD script_name.sh /script_name.sh
RUN chmod a+x /script_name.sh

EXPOSE 9870

CMD ["/script_name.sh"]
