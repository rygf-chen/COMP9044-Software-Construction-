#!/bin/sh

d1=$1
d2=$2

for i in $d1/*
do
	file=`basename "$i"`
	if [ ! -e "$d2"/"$file" ]
	then
		continue
	else
		if diff "$i" "$d2"/"$file"  >/dev/null
		then
			echo "$file"
		fi
	fi
done