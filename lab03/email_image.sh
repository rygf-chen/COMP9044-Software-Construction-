#!/bin/sh

#images="$*"
#for i in $(seq $(expr $#))
#do
#	display "$i"
#	sleep 1
#done
#
for i in "$@"
do
	display "$i"
	echo -n "Address to e-mail this image to?"
read email
if [ ! "$email" ]
then
        echo "You didn't input an email."
        exit
else
        echo -n "Message to accompany image?"
        read message
	echo "$message"|mutt -s "$i" -e 'set copy=no' -a "$i" -- "$email"
	echo "$i sent to $email"
fi
sleep 2
done

