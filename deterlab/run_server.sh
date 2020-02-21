#!/bin/sh

id=$1
nclient=$2

rm -f server${id}.log
nohup ./server -i ${id} -n ${nclient} -s ./servers -m m -p1 8000 > server${id}.log 2>&1 &