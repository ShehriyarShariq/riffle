#!/bin/bash

serverid=$1
client=$2

startId=$(($serverid * $client))
end=$(($startId + $client -1))

for id in $(seq $startId $end); do
  rm -f client${serverid}_${id}.log
  echo "Running ./client -i ${id} -s ./servers -m m > client${serverid}_${id}.log"
  nohup ./client -i ${id} -s ./servers -m m > client${serverid}_${id}.log 2>&1 &
done