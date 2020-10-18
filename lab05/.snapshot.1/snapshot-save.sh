#!/bin/sh
num=0

while true
do
    cpname=".snapshot.$num"
    if ! [ -d "$cpname" ]
    then
        mkdir "$cpname"
        for file in *
        do
            if ((echo "f$file"| egrep -v 'snapshot-save.sh') && (echo "f$file"| egrep -v 'snapshot-load.sh'))>/dev/null
            then
                cp "$file" "$cpname/$file"
            fi
        done
        echo "Creating snapshot $num"
        exit 0
    fi
    num=`expr $num + 1`
done
