FROM hadoop-base

RUN mkdir -p /hadoop/dfs/data
VOLUME /hadoop/dfs/data

ADD script_data.sh /script_data.sh
RUN chmod a+x /script_data.sh

EXPOSE 9864

CMD ["/script_data.sh"]
