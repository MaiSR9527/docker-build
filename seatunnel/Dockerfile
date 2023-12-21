FROM openjdk:8

ARG version
RUN mkdir -p /opt/seatunnel && mkdir -p /opt/jobs
ADD ./apache-seatunnel-${version} /opt/seatunnel/
ENV SEATUNNEL_HOME=/opt/seatunnel
EXPOSE 5801
WORKDIR /opt/seatunnel
# cluster-mode 方式运行
ENTRYPOINT ["/bin/sh", "-c", " ${SEATUNNEL_HOME}/bin/seatunnel-cluster.sh"]