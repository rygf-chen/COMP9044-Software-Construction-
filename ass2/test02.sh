#!/bin/dash

for word in subset1: simple forloop check
do
    echo $word
done

for i in checkexit subset1 xxx
do
    echo $i
    exit 0
done