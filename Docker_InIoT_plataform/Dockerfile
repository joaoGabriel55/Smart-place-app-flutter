#
# Ubuntu Dockerfile
#

# Pull base image.
FROM parrotstream/ubuntu-java:xenial-8

RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 && \
  echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list && \
  apt-get update && \
  apt-get install mongodb-org -y && \
  mkdir -p /data/db

RUN \
  wget https://bitbucket.org/In-IoT/in.iot-device-api/downloads/InIoT-REST.jar

RUN \
  wget https://bitbucket.org/In-IoT/moquette-in.iot/downloads/moquette-InIoT.tar.gz && \
  mkdir moquette-InIoT && tar -xvzf moquette-InIoT.tar.gz -C moquette-InIoT

RUN \
  wget https://bitbucket.org/In-IoT/in.iot-dashboard/downloads/InIoT-Dashboard.jar

ADD entrypoint.sh .

RUN chmod +x entrypoint.sh

EXPOSE 8070
EXPOSE 1883
EXPOSE 8090

# Define default command.
CMD ["./entrypoint.sh"]
