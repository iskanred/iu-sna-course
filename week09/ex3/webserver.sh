#!/bin/bash

while true;
do
	dd if=/dev/zero of=/dev/null
done &

while true;
do
	echo -e "HTTP/1.1 200 OK\n\n$(./stat.sh)" | nc -lkp 8080 -q 1;
done
