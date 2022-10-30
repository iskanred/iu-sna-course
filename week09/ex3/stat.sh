#!bin/bash

echo "System uptime: $(uptime)"
echo ""

echo "Inode usage: "
echo "$(df -i)"
echo ""

echo "Memory usage:"
echo "$(grep MemTotal /proc/meminfo)"
echo ""

echo "Disk usage:"
echo "$(df -H)"
echo ""

echo "System logs:"
echo "$(tail /var/log/syslog)"
echo ""

