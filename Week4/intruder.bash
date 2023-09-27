ip="184.171.148.139"
junk=""

for i in {1..20}
do
	junk=$(curl -s "$ip/helloworld.html")
	echo $i
done
