#!/bin/bash

for f in "$@"
do
	exiftool -CreateDate $f &> /dev/null
	if [ $? -gt 0 ]; then
		echo "[ERR] file $f doesn't have EXIF data."
	else
		year=$(exiftool -CreateDate $f | cut -d ':' -f2 | tr -d ' ')
		month=$(exiftool -CreateDate $f | cut -d ':' -f3 | tr -d ' ') 
		day=$(exiftool -CreateDate $f | cut -d ':' -f4 | tr -d ' ' | cut -c1,2)

		foldername="${year}-${month}-${day}" 
	
		if [ -e $foldername ]; then
			echo "${foldername} is exist."
		else
			mkdir $foldername
		fi
		mv $f ./$foldername/$f
	fi
done
