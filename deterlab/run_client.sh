#!/bin/bash

serverid=$1
client=$2

startId=$(($serverid * $client))
end=$(($startId + $client -1))

for id in $(seq $startId $end); do
  rm -f client${serverid}_${id}.log
  server=$((${id} % 3))
  echo "Running ./client -i ${server} -s ./servers -m m > client${id}.log"
  nohup ./client -i ${server} -s ./servers -m m > client${id}.log 2>&1 &
done