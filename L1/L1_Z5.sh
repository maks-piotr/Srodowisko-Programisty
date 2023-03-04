#!/bin/bash
file_array=($(find $1 -type f | tr ' ' '\n'))
for i in "${file_array[@]}"
do
   if [[ -f $i ]]; then
   	sed -i "s/a/A/g" $i
   fi
done
