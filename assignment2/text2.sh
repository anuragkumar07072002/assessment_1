#!/bin/bash
memory=$(free -h)
echo "$memory"

total_memory=$(echo "$memory" | awk '/^Mem:/ {print $2}')
used_memory=$(echo "$memory" | awk '/^Mem:/ {print $3}')
free_memory=$(echo "$memory" | awk '/^Mem:/ {print $4}')

echo "free memory : $free_memory"
echo "used memory : $used_memory"

disk_space=$(df -h /)

echo "$disk_space"

used_disk=$(echo "$disk_space" | awk 'NR==2 {print $5}')

echo "used disk percentage : $used_disk"

	# Define the string
        input_string="$used_disk"

        # Define the delimiter
        delimiter="%"

        # Extract the first part
        digit_of_percentage=$(echo "$input_string" | cut -d "$delimiter" -f 1)


    if [[ "10#$digit_of_percentage" -ge "10#50" ]]; then
        filename="notification.txt"
	mkdir alerts
	echo "more than 50% disk is occupied" > "$filename"
	mv "$filename" "/alerts"

   fi

   echo "Top 10 largest files in the file system"
du -a -x /var | sort -n -r | head -n 10







