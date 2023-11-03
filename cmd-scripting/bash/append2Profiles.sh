#!/bin/bash

DATE=`date "+%Y%m%d%H%M"`

for dir in /export/home/*/
do
	dir=${dir}
	### exclude testharness user \
	echo "${dir}" | grep testharness > /dev/null
	if [ $? -eq 1 ]; then
	### /
		if [ -f "${dir}.profile" ]; then
			#cp "${dir}.profile" "${dir}.profile_$DATE.bak"
			(
				echo "export PATH="'$''JAVA_HOME'"/bin:"'$''PATH'
				echo "export PATH="'$''M2'"":'$''PATH'
			) >> "${dir}.profile"
		else
			continue
		fi
	fi
done