function listIPs(){
	ips=$(awk '{print $1}' $logfile)
	singleips=""

	for i in $ips
	do
		if [[ !($singleips = *"$i"*) ]]
		then
			singleips+=$i"\n"
		fi
	done
	printf $singleips > "clientIPs.txt"
}

function visitorCount(){
	iplist=$(cat "clientIPs.txt")
	ips=$(awk '{print $1}' $logfile)
	datelist=$(awk '{print $4}' $logfile)
	IFS=" " read -a dates <<< $datelist
	date=$(date +"%d/%b/%Y")
	
	count=0
	for i in $iplist
	do
		for j in $ips
		do
			[[ $i = $j ]] && $(echo $dates[$count] | grep -q $date) && (( count++ ))
		done
		echo "$count $i"
		count=0
	done
}

function badClients(){
	iplist=$(cat "clientIPs.txt")
	#get time in minutes since the start of the day (easier to calculate with)
	time=$(( $(date +"%H") * 60 + 10#$(date +"%M") ))
	badIPs=""
	ip=""
	date=""
		
	count=0
	IFS=$'\n'
	for i in $iplist
	do
		for j in $log
		do
			#get the ip and date of the log entry
			ip=$(echo $j | awk '{print $1}')
			date=$(echo $j | awk '{print $4}')
			pingtime=$(( $(echo $date | awk -F ":" '{print $2}') * 60 + 10#$(echo $date | awk -F ":" '{print $3}') ))
			#check if the ip and date match and if it resulted in an error code of 400, 403, or 404
			[[ $i = $ip && $(($time - $pingtime < 11)) && $(echo $j | grep -c "400\|403\|404") > 0 ]] && (( count++ ))
		done
		
		[[ $count > 3 ]] && badIPs+=$i"\n"
		
		count=0
	done
	[[ $badIPs != "" ]] && printf $badIPs > blacklisted.txt
}

function block(){
	badIPs=$(cat "blacklisted.txt")
	for i in $badIPs
	do
		iptables -A INPUT -s $i -j DROP
	done
	iptables -L INPUT -v -n
}

function resetBlocks(){
	iptables -F
	iptables -L INPUT -v -n
}

function histogram(){
	date=""
	prevdate=""
	count=0
	
	IFS=$'\n'
	for i in $log
	do
		#check if the log entry was a valid connection
		if [[ $(echo $i | grep -c '" 200') > 0 ]]
		then
			date=$(echo $i | awk '{print $4}')
			date=${date#*[}
			date=${date%%:*}
			
			if [[ $date = $prevdate ]]
			then
				(( count++ ))
			else
				[[ $count = 0 ]] || echo $count" visits on "$date
				count=0
			fi
		fi
		
		#set the previous date to check if the date changes on next iteration
		prevdate=$date
	done
	
	#print out the last date
	echo $count" visits on "$date
}


#Start of menu code
logfile="${1:-"/var/log/apache2/access.log"}"
log=$(cat $logfile)
#echo $log

input=0
while [[ $input != 7 ]]
do
	echo "[1] Number of Visitors
[2] Display Visitors
[3] Show Bad Visits
[4] Block Bad Visits
[5] Reset Block Rules
[6] Show Visit Histogram
[7] Quit"
	read input
	
	case $input in
	 1)
 	 	listIPs
		;;

	 2)
 	 	visitorCount
		;;

	 3)
 	 	badClients
		;;
	 
	 4)
 	 	block
		;;
	 
	 5)
 	 	resetBlocks
		;;
	 
	 6)
 	 	histogram
		;;
	 
	 7)
		;;
	 
	 *)
	 	echo "Invalid input"
		;;
	esac
done
