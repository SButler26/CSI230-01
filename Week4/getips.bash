log=$(echo "/var/log/apache2/access.log")
date=$(date)
date=$(printf "%s/%s/%s" $(echo $date | awk '{print $3}') $(echo $date | awk '{print $2}') $(echo $date | awk '{print $7}'))
datelist=$(awk '{print $4}' $log)
IFS=" " read -a dates <<< $datelist
ips=$(awk '{print $1}' $log)
singleips=""
ipcount=""

count=1
for i in $ips
do
	if [[ !($singleips = *"$i"*) ]]
	then
		if $(echo $dates[$count] | grep -q "$date")
		then
			echo $i
			singleips+="$i "
		fi
	fi
	(( count++ ))
done

count=0
for i in $singleips
do
	for j in $ips
	do
		if [[ $i = $j ]]
		then
			(( count++ ))
		fi
	done
	echo "$i $count"
done
