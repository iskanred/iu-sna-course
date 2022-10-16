pids=$(ps -ef | awk '/fun[[:digit:]]+process infinity/ {print $2}')

if [ -z "$pids" ]
then
	echo "No such proccess was found"
	exit 0
fi

for pid in $pids
do
	echo "Process is found: $pid"
	kill -9 $pid
	echo "Process $pid was killed"
done
