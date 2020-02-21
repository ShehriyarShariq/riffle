#!/bin/sh

serverid=$1
client=$2

for id in $(seq 1 $client); do
  rm -f client${serverid}_${id}.log
  nohup ./client -i ${id} -s ./servers -m m > client${serverid}_${id}.log 2>&1 &
done