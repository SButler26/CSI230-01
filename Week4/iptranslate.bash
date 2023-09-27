binarylist=$(cat "output.txt")
iplist=""

for i in $binarylist
do
	iplist+="$(echo $i | bash binary_to_ip.bash)\n"
done
printf $iplist > possibleips.txt
