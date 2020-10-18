#!/bin/dash

number=$start
if [ $start -ge $finish ]
then
    while test $number -ge $finish
    do
        echo $number
        number=$((number - 1))  # decrement number
    done
else
        echo "start should greater than finish"
        exit 0
fi