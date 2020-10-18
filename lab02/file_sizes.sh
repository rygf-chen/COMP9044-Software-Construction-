#!/bin/sh

#set -x

for txt_file in *.txt
do 
	files="$(echo "$txt_file"| ls -l | cut -d ':' -f2 | cut -d ' ' -f2 | egrep -v [0-9] )"
	#echo $files
	for filename in $files
	do
		if test $(cat $filename | wc -l ) -lt 10
		then
			echo $filename >>small
		elif test $(cat $filename | wc -l) -lt 100
		then
			echo $filename >>med
		else
			echo $filename >>large
		fi
	done
	echo "Small files: $(cat small 2> /dev/null| sort | tr '\n' ' ')"
	echo "Medium-sized files: $(cat med 2> /dev/null| sort| tr '\n' ' ')"
	echo "Large files: $(cat large 2> /dev/null| sort| tr '\n' ' ')"
	rm small med large 2> /dev/null
	
done
