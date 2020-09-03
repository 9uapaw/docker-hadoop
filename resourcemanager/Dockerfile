FROM bde2020/hadoop-base:self-dev

MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>

HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8088

RUN rm -rf /opt/hadoop-$HADOOP_VERSION/share/

CMD ["/run.sh"]
