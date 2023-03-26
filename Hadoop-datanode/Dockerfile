FROM hadoop-base

HEALTHCHECK CMD curl -f http://localhost:9864/ || exit 1

RUN mkdir -p /hadoop/dfsdata/datanode
VOLUME /hadoop/dfsdata/datanode

ADD script_data.sh /script_data.sh
RUN chmod a+x /script_data.sh

EXPOSE 9864

CMD ["/script_data.sh"]