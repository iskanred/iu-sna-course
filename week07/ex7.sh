while :
do
	mem=`free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }'`
	disk=`df -h | awk '$NF=="/"{printf "%s\t\t", $5}'`
	cpu=`top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}'`
	
	output="$(date) memory usage = $mem\ndisk usage = $disk\ncpu usage=$cpu"
  printf $output
	printf $output >> /var/log/system_utilization.log
  
	sleep 15
done

