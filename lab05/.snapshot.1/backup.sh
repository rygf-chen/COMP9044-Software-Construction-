#!/bin/sh

filename=$1
if ! [ -e ".$filename.0" ]
then
	cpname=".$filename.0"
	cp "$filename" "$cpname"
	#cat "$filename" >".$filename.0"
	echo 'Backup of '\'$filename\'' saved as '\'$cpname\'''
	exit 0
else 
	num=`ls .$filename.*|wc -l`
	#echo $num
	cp "$filename" ".$filename.$num"
	echo 'Backup of '\'$filename\'' saved as '\'.$filename.$num\'''
	
fi
