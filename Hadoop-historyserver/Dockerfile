FROM hadoop-base

ENV MAPREDUCE_JOBHISTORY_DONE-DIR=/hadoop/yarn/timeline
ENV MAPREDUCE_JOBHISTORY_INTERMEDIATE-DONE-DIR=/hadoop/yarn/timeline


RUN mkdir -p /hadoop/yarn/timeline
VOLUME /hadoop/yarn/timeline

ADD script_history.sh /script_history.sh
RUN chmod a+x /script_history.sh

EXPOSE 8188

CMD ["/script_history.sh"]

