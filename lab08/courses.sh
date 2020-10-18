#!/bin/sh 

coursename=$1
url="http://www.timetable.unsw.edu.au/current/"$coursename"KENS.html"

curl --location --silent $url|
egrep "$coursename"|
egrep -v ">$coursename.*"|
egrep -o "$coursename.*</a>"|
sed 's/\.html\">/ /g'|
sed 's/<\/a>//g'|
sort|
uniq

