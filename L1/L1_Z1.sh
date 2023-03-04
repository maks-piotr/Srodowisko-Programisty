file_array=($(find $1 -type f | tr ' ' '\n'))
echo $file_array
for i in "${file_array[@]}"
do
	echo $i
done
