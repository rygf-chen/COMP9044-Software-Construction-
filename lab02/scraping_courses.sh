#!/bin/sh

#set -x
course="$1"

urlu="http://legacy.handbook.unsw.edu.au/vbook2018/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=ALL"
urlp="http://legacy.handbook.unsw.edu.au/vbook2018/brCoursesByAtoZ.jsp?StudyLevel=Postgraduate&descr=ALL"

curl -s "$urlu" |
egrep 'href=\"' | 
egrep '<TD' | 
cut -d '/' -f7 | 
tr '.><\"' ' ' | 
sed 's/html//'|
egrep -v "[B-Z] *$" |
egrep -v 'Part Time' > under


curl -s "$urlp" |
egrep 'href=\"' |
egrep '<TD' |
cut -d '/' -f7 | 
tr '.><\"' ' ' | 
sed 's/html//'|
egrep -v "[B-Z] *$" |
egrep -v 'Part Time' > post

cat under post >> whole

cat whole |
sort | 
uniq 

while true
do
	egrep "$course" whole 2> /dev/null
	rm under post whole
	exit

done
