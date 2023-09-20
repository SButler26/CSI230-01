read ip_binary
ip=""

for i in {0..3}
do
	ip+=$((2#${ip_binary:$i*8:8}))
	[[ $i < 3 ]] && ip+="."
done

echo $ip
