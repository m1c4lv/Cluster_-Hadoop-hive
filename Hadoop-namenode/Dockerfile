FROM hadoop-base

RUN mkdir -p /hadoop/dfs/name
VOLUME /hadoop/dfs/name

ADD script_name.sh /script_name.sh
RUN chmod a+x /script_name.sh

EXPOSE 9870

CMD ["/script_name.sh"]
