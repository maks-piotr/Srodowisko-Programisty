#!/bin/bash

svn export -r $1 $2 tempfolder > /dev/null

file_array=($(find tempfolder -type f | tr ' ' '\n'))
declare -A word_count
for i in "${file_array[@]}"
do
   if [[ -f $i ]]; then
   	word_string=$(cat $i)
   	word_array=($(echo "$word_string" | tr ' ' '\n'))
   	for j in "${word_array[@]}"
	do
		word_count[$j]=$((word_count[$j] + 1))
	done
   fi
done
for i in "${!word_count[@]}"
do
  echo "$i: ${word_count[$i]}"
done |
sort -rn -k2

rm -r tempfolder
