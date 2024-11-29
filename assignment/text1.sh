#!/bin/bash

IFS=','

#col1=time
##col2=emailid
#col3=task
while read -r col1 col2 col3
do
	#ignoring first row as it contains the column name and not the data 
	if [ "$col2" == "emailIds" ];
	then
		continue
	fi

	
	file_saving_time=$(date -d "$col1 today - 30 minutes" +"%H:%M")
	
	#checking in terminal whether our code reads the file or not
	echo "$col1"
	echo "$mail_sending_time"
	echo "$col2"
	echo "$col3"
at "$file_saving_time" <<EOF
	# Define the string
	input_string="$col2"

	# Define the delimiter
	delimiter="@"

	# Extract the first part
	name_of_person=$(echo "$input_string" | cut -d "$delimiter" -f 1)

	# Print the first part
	echo "The first part is: $name_of_person"

	parent_dir="$name_of_person"
        mkdir "$parent_dir"
	
	size_of_dir= ls "$parent_dir" | wc -l
	count=$((size_of_dir+1))
	
	filename="notification${count}.txt"
	
	echo "$col3 at $col1" > "$filename"

	mv "$filename" "$parent_dir"	
EOF
    #sending the mail in the specified format and the specified time 
    #echo "echo 'Hello, this is a scheduled email.' | mail -s 'Scheduled Email' recipient@example.com" | at 15:30
    #echo "$col3 at $col1" | mail -s "Task at $col1" "$col2" | "$mail_sending_time"

done<sample.csv


