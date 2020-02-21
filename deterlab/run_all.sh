#!/bin/sh


client=100
clientpermachine=20


for i in 1 2 3 4 5 6 7 8 9 0
do
  rm -f *.log
  . ./killall.sh

  echo "Running on server 0  ./run_server.sh 0 ${client}"
  ssh dtrustee-0.lb-ldd-diss.safer.isi.deterlab.net "cd riffle/deterlab && ./run_server.sh 0 ${client}"
  echo "Running on server 1"
  ssh dtrustee-1.lb-ldd-diss.safer.isi.deterlab.net "cd riffle/deterlab && ./run_server.sh 1 ${client}"
  echo "Running on server 2"
  ssh dtrustee-2.lb-ldd-diss.safer.isi.deterlab.net "cd riffle/deterlab && ./run_server.sh 2 ${client}"

  sleep 10

  echo "Running on client 0 ./run_client.sh 0 ${clientpermachine}"
  ssh dclient-0.lb-ldd-diss.safer.isi.deterlab.net "cd riffle/deterlab && ./run_client.sh 0 ${clientpermachine}"
  echo "Running on client 1"
  ssh dclient-1.lb-ldd-diss.safer.isi.deterlab.net "cd riffle/deterlab && ./run_client.sh 1 ${clientpermachine}"
  echo "Running on client 2"
  ssh dclient-2.lb-ldd-diss.safer.isi.deterlab.net "cd riffle/deterlab && ./run_client.sh 2 ${clientpermachine}"
  echo "Running on client 3"
  ssh dclient-3.lb-ldd-diss.safer.isi.deterlab.net "cd riffle/deterlab && ./run_client.sh 3 ${clientpermachine}"
  echo "Running on client 4"
  ssh dclient-4.lb-ldd-diss.safer.isi.deterlab.net "cd riffle/deterlab && ./run_client.sh 4 ${clientpermachine}"

  echo "Sleeping 90"
  sleep 90

  cat client0.log
  cp client0.log out_${client}_${i}.log
done