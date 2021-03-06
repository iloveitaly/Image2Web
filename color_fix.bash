#!/bin/bash

if [ -z $1 ]; then
	echo "No directory specified"
	exit 1
fi

targetDir="$1"
targetDir=${targetDir%/} # remove trailing slash if there is one

find "$targetDir" -name "*.png" -or -name "*.jpg" -or -name "*.jpeg" | while read line; do
	echo "Optimizing $line"
	image2web "$line"
done

find "$targetDir" -name "*.png" | while read line; do
	optipng -o7 "$line"
done

exit 0
