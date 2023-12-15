FROM openjdk:8

ENV SEATUNNEL_VERSION="2.3.2"
COPY ./apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz /opt/apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz
COPY ./env.sh /opt/seatunel/env.sh
WORKDIR /opt
RUN tar -xzvf apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz
RUN mv apache-seatunnel-${SEATUNNEL_VERSION} seatunnel
RUN rm -f /opt/apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz
WORKDIR /opt/seatunnel
RUN mkdir -p /opt/seatunnel/logs
RUN chmod +x /opt/seatunel/env.sh
RUN sh /opt/seatunel/env.sh
ENTRYPOINT ["sh","-c","bin/seatunnel-cluster.sh -d"]

