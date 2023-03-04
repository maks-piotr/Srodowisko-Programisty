#!/bin/bash
file_array=($(find $1 -type f | tr ' ' '\n'))
declare -A word_count
for i in "${file_array[@]}"
do
   if [[ -f $i ]]; then
   	word_string=$(cat $i)
   	word_array=($(echo "$word_string" | tr ' ' '\n'))
   	declare -a already_counted=() #already counted words in i-th file
   	for j in "${word_array[@]}"
	do
		if [[ ! " ${already_counted[*]} " =~ " ${j} " ]]; then
			word_count[$j]=$((word_count[$j] + 1))
			already_counted[${#already_counted[@]}]="$j"
		fi
	done
   fi
done
for i in "${!word_count[@]}"
do
  echo "$i: ${word_count[$i]}"
done |
sort -rn -k2

