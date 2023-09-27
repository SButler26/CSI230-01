iplist=$(cat "possibleips.txt")
active=""
count=1

for i in $iplist
do	
	if [[ !($(ping -c 1 $i | grep -c "Unreachable") -gt 0) ]]
	then
		active+=$i"\n"
		echo $i
	fi
	echo $count
	((count++))
done

printf $active > activehosts.txt
