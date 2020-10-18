#!/bin/sh

#set -x

input="$@"
num=$1
string=$2
n=0

if test $(echo -n $input | wc -w) -eq 2 2> /dev/null
then	if test $num -eq 0 2> /dev/null
	then
		exit
	fi
	if test $n -lt $num 2> /dev/null
	then
	while test $n -lt $num
	do
		echo $string
		n=$((n + 1))
	
	done
	else
		echo "$0: argument 1 must be a non-negative integer"
                exit
	fi
else
	echo "Usage: $0 <number of lines> <string>"
	exit
fi
