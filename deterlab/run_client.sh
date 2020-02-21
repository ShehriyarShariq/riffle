#!/bin/sh

n_client=$1

for id in $(seq 1 $n_client); do
  rm -f client${id}.log
  nohup ./client -i $1 -n $client -s ./servers -m m > client${id}.log 2>&1 &
done