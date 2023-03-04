#!/bin/bash
file_array=($(find $1 -type f | tr ' ' '\n'))
declare -A word_count
for i in "${file_array[@]}"
do
   if [[ -f $i ]]; then
   	word_string=$(cat $i)
   	word_array=($(echo "$word_string" | tr ' ' '\n'))
   	u_word_array=($(for words in "${word_array[@]}"; do echo "${words}"; done | sort -u))
   	input="$i"
   	declare -a double_occured=() #words that occured twice in at least one line
   	for j in "${u_word_array[@]}"
	do
	   	while IFS= read -r k
		do
			if [[ " $k " == *" $j $j "* || " $k " == *" $j "*" $j "* ]]; then
			  if [[ ! " ${double_occured[*]} " =~ " ${j} " ]]; then
				double_occured[${#double_occured[@]}]="$j"
			  fi
			fi
		done < "$input"
	done
   	for j in "${double_occured[@]}"
	do
		#echo $j
		word_count[$j]="${word_count[$j]}"$'\n'"lines in file $i:"
		while IFS= read -r k
		do
			#echo $k
			if [[ " $k " == *" $j $j "* || " $k " == *" $j "*" $j "* ]]; then
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

