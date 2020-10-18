#!/bin/sh
while read string
do
	echo $string|
	tr '[0-4]' '<'|
	tr '[6-9]' '>'
done
