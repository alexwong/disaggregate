#!/bin/bash

for ((FPS=40000; FPS<=80000; FPS+=10000)); do
	ops=$(expr "${FPS}" '*' 120)
	sudo docker run --cpus=14 -v /home/jw2534/dlwrapper:/host -u root ycsb /YCSB/distribution/target/ycsb-0.16.0-SNAPSHOT/bin/ycsb run mongodb -p operationcount=${ops} -p mongodb.url=mongodb://172.17.0.3:27017/ycsb -s -P /YCSB/workloads/workloadc -threads 50 -target ${FPS} > /home/jw2534/dlwrapper/result_6/${FPS}.txt

done
