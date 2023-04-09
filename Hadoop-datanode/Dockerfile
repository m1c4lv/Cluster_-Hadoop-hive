FROM hadoop-base

RUN mkdir -p /opt/volume/datanode
VOLUME /opt/volume/datanode

ADD conf/hdfs-site.xml /etc/hadoop/

ADD script_data.sh /script_data.sh
RUN chmod a+x /script_data.sh

EXPOSE 9864

CMD ["/script_data.sh"]
