#!/bin/sh

id=$1
client=$2

rm -f server${id}.log
nohup ./server -i $id -n $client -s ./servers -m m -p1 8000 > server${id}.log 2>&1 &