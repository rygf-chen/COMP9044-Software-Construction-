#!/bin/dash

input=$1

if [ $input -lt 0 ]
then
    echo $input is negative
elif [ $input -eq 0 ]
then
    echo $input is 0
elif [ $input -gt 0 ]
then
    echo $input is positive
    output1=`expr $input \* $input`
    echo $input square is $output1
    output2=`expr $output1 \* $output1`
    echo $output1 square is $output2
    output3=`expr $output1 + $output2`
    echo $output1 + $output2 = $output3

fi