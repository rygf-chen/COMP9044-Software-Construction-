#!/bin/sh

for link in "$@"
do
    server=`curl -sI $link|egrep -i 'server:' | cut -d ':' -f2`
    echo "$link$server"
done