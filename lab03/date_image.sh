#!/bin/sh

file_name="$@"

#time="$(echo "$@" |ls -l |cut -d ' ' -f6-8)"
#echo "$(ls -l "$@"|cut -d ' ' -f6-8)"
convert -gravity south -pointsize 36 -draw "text 0,10 '$(ls -l $@|cut -d ' ' -f6-8)'" "$@" "$@"
