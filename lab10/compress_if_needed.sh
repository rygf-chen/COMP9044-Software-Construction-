#!/bin/sh

for file in "$@"
do
    sizebefore=`ls -l $file| cut -d ' ' -f5`
    xz -fqk $file
    sizeafter=`ls -l "$file.xz"| cut -d ' ' -f5`
    if [ $sizeafter -lt $sizebefore ]
    then
        echo "$file $sizebefore bytes, compresses to $sizeafter bytes, compressed"
        rm "$file"
    else
        echo "$file $sizebefore bytes, compresses to $sizeafter bytes, left uncompressed"
        rm "$file.xz"
    fi
done