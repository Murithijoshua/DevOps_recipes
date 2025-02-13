#!/bin/bash



# check cpu usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
# echo "CPU: $cpu_usage%"


#check disk usage
disk_usage_percentage=$(df -h | awk '$NF=="/"{printf "%d", $5}')
actual_usage=$(df -h | awk '$NF=="/"{printf "%d", $3}')
total_disk=$(df -h | awk '$NF=="/"{printf "%d", $2}')


#check memory usage
memory_usage_percentae=$(free | awk 'NR==2{printf "%.2f", $3*100/$2}')
actual_memory=$(free | awk 'NR==2{printf "%d", $3}')    
swap_memory=$(free | awk 'NR==3{printf "%d", $3}')

# echo "Memory: $memory_usage_percentae%"


#checking load average
uptime=$(uptime | awk '{print $3,$4}' | sed 's/,//')
load_average=$(uptime | awk -F'load average:' '{print $2}')
# echo "Load Average: $load_average"
#check last 5 failed login attempts
failed_login=$(lastb | head -5)
# echo "Failed Login Attempts: $failed_login"

logged_in_users=$(last | head -5)
# echo "Logged In Users: $logged_in_users"

#top 5 processes consuming high memory
top_processes=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6)
# echo "Top Processes: $top_processes"

#top 5 processes consuming high cpu
top_cpu_processes=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6)

# echo "Disk Usage: $disk_usage_percentage% ($actual_usage/$total_disk)"

# network percentage stats
 network_percentage=$(netstat -i | awk '{if(NR>2)print $1,$4,$8}')

#visualize the data
echo "+++++++++++++++Server Stats+++++++++++++++++++"
echo "CPU Usage: $cpu_usage%"  
echo "Memory Usage: $memory_usage_percentae%"
echo "Swap Memory: $swap_memory"
echo "Uptime: $uptime"  
echo "Load Average: $load_average"
echo "Failed Login Attempts: $failed_login"
echo "Logged In Users: $logged_in_users"
echo "Top Processes: $top_processes"
echo "Top CPU Processes: $top_cpu_processes"
echo "Disk Usage: $disk_usage_percentage% ($actual_usage/$total_disk)"
echo "Network Percentage: $network_percentage"

echo "+++++++++++++++End server Stats+++++++++++++++++++"
