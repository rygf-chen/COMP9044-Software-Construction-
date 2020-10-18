#!/bin/dash

a=$1

for word in 1 12 135  4 561 11235 465  12 6 112
do
    b=`expr $word % $a`
    echo $word mod $a is $b
done