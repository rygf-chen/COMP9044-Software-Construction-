#!/bin/dash

start=$1
finish=$2

number=$start
if [ $start -ge $finish ]
then
    while test $number -ge $finish
    do
        echo $number
        number=`expr $number - 1`  # decrement number
    done
else
        echo "start should greater than finish"
        exit 0
fi