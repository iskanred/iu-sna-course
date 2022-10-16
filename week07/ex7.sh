# run with sudo

while :
do
	timestamp=`date`
	mem=`free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }'`
	disk=`df -h | awk '$NF=="/"{printf "%s", $5}'`
	cpu=`top -bn1 | awk '/load/{printf "%.2f%%", $(NF-2)}'`
	
	output="[$timestamp]\t\tmemory usage = $mem\t\tdisk usage = $disk\t\tcpu usage=$cpu"
  	echo -e "$output"
	echo -e "$output" >> /var/log/system_utilization.log
  
	sleep 15
done

