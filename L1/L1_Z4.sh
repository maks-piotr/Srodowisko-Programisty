#!/bin/bash
file_array=($(find $1 -type f | tr ' ' '\n'))
declare -A word_count
for i in "${file_array[@]}"
do
   if [[ -f $i ]]; then
   	word_string=$(cat $i)
   	word_array=($(echo "$word_string" | tr ' ' '\n'))
   	u_word_array=($(for words in "${word_array[@]}"; do echo "${words}"; done | sort -u))
   	for j in "${u_word_array[@]}"
	do
		#echo $j
		word_count[$j]="${word_count[$j]}"$'\n'"lines in file $i:"
		input="$i"
		while IFS= read -r k
		do
			#echo $k
			if [[ $k == *"$j"* ]]; then
			  word_count[$j]="${word_count[$j]}"$'\n'"$k"
			fi
		done < "$input"
		
	done
   fi
done
for i in "${!word_count[@]}"
do
  echo "$i: ${word_count[$i]}"
  echo " "
done

