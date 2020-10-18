#!/bin/sh

snapshot-save.sh

for i in .snapshot."$1"/*
do
	file=`echo "$i"|sed 's/\.snapshot\.'$1'\///g'`
	cp -f "$i" ./"$file"
done
echo 'Restoring snapshot '$1''