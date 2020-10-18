#!/bin/sh

#set -x
for i in *.jpg
do
if test -e "${i%.jpg}.png"
then
	echo "${i%.jpg}.png already exists"
	exit 
else
	convert "$i" "${i%.jpg}.png"
fi
#if test -e "${i%.jpg}.png"
#then
#	echo "${i%.jpg}.png already exists"
#fi
rm "$i"
done
