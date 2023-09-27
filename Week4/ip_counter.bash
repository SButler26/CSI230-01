#ip=$(bash ip_address.bash | bash ip_to_binary.bash)
#prefix=$(bash ip_prefix.bash)
ip=$(echo $1 | bash ip_to_binary.bash)
host=${ip:0:$2}

#get the total number of addresses
addresses=$((2**(32-$2)))

#get each possible ip
allIPs=""
for ((i=1; i<addresses-1; i++))
do 
	allIPs+=$host
	allIPs+=$(printf %08d $(echo "obase=2;$i" | bc))
	allIPs+="\n"
done

printf $allIPs > output.txt
echo "IPs output to output.txt"
