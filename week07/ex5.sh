function log_interrupt() {
	echo "Interrput received"
	exit
}

trap log_interrupt SIGUSR1

while :
do
	echo "Hello, World!"
	sleep 10
done

