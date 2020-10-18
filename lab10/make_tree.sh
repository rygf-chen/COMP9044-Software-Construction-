#!/bin/sh

path=$1
current=`pwd`
check="Makefile"
for file in `find $path`
do
    makef=`basename $file`
    if [ $makef = $check ]
    then
        dir=`dirname $file`
        echo "Running make in $dir"
        cd "$current/$dir"
        make
    fi
done