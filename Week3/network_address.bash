ip=$(bash binary_ip.bash)
masklength=$(bash ip_prefix.bash)
network=""

for i in {0..31}
do
	network+="$(( ($i+1 > $masklength) && ${ip:$i:1} ))"
done

echo $network
