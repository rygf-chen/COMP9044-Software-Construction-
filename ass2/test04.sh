#!/bin/dash

#subset3

start=$1
finish=$2

number=$start
if [ $start -le $finish ]
then
    while test $number -le $finish
    do
        echo $number
        number=`expr $number + 1`  # increment number
    done
else
        echo "start should not greater than finish"
        exit 0
fi