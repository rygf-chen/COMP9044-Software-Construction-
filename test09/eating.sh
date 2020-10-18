#!/bin/sh


cat $1|
egrep -o "\"name\": *\".*\""|
cut -d ":" -f2|
cut -d "\"" -f2|
sort|
uniq

