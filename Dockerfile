#!usr/bin/env bash
FROM openkbs/jdk-mvn-py3
COPY YCSB /YCSB
#WORKDIR "/YCSB/distribution/target/ycsb-0.14.0-SNAPSHOT/bin"
#RUN sudo touch /home/jw2534/mongodb/result.txt
#CMD ["/YCSB/distribution/target/ycsb-0.16.0-SNAPSHOT/bin/ycsb","run","mongodb","-p", "operationcount=50","-p","mongodb.url=mongodb://localhost:27017/ycsb","-s","-P","/YCSB/workloads/workloadc", "-threads", "2", "-target", "5"]
