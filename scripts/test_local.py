import sys
import os
import threading
import time
import shlex, subprocess
import signal
import sys

def signal_handler(sig, frame):
    print "Killing everything"
    os.system('killall -9 server')
    os.system('killall -9 client')
    sys.exit(0)
signal.signal(signal.SIGINT, signal_handler)


m = int(sys.argv[1])
n = int(sys.argv[2])
mode = sys.argv[3]
file_dir = sys.argv[4]

gopath = os.environ['GOPATH']

server_cmd = "%s/bin/server -i %d -n %d -s %s/src/github.com/lbarman/riffle/servers -m %s -p1 %d"
command = "%s/bin/client -i %d -s %s/src/github.com/lbarman/riffle/servers -m %s -w %s -f %s"

server_file = open('%s/src/github.com/lbarman/riffle/servers' % gopath, 'w')
for i in range(m):
    server_file.write('localhost:' + str(8000+i) + '\n')
server_file.close()
print("Wrote", server_file)

def spawn(c):
    os.system(c)

ss = []
for i in range(m):
    c = server_cmd % (gopath, i, n, gopath, mode, 8000 + i)
    args = shlex.split(c)
    print "Spawning", args
    p = subprocess.Popen(args)
    ss.append(p)

time.sleep(5)

ts = []
for i in range(0, n):
    c = command % (gopath, i%m, gopath, mode, file_dir + '/file' + str(i) + '.torrent', file_dir + '/file' + str(i))
    args = shlex.split(c)
    print "Spawning", args
    p = subprocess.Popen(args)
    ss.append(p)

for t in ts:
    print("Waiting on all threads")
    t.join()

print('Press Ctrl+C')
while True:
    time.sleep(1000)
signal_handler()