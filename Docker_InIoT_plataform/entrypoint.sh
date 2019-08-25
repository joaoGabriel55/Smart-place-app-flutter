#!/bin/bash
mongod &
echo "RUN MONGO"
java -jar InIoT-REST.jar  &
echo "RUN REST"
./moquette-InIoT/bin/moquette.sh &
echo "RUN moquette"
java -jar InIoT-Dashboard.jar
