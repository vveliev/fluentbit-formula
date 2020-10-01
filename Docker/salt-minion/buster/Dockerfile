FROM debian:10

WORKDIR /app

RUN apt-get update && apt-get install -y salt-minion curl
COPY Docker/salt-minion/buster/setup.sh /opt/setup.sh

ENTRYPOINT ["sh","/opt/setup.sh"]