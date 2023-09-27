read ip_addr
binaryip=""

for i in {1..4}
do
	binaryip+=$(printf %08d $(echo "obase=2;$(echo $ip_addr | cut -d. -f $i)" | bc))
done

echo $binaryip
