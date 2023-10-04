hosts=$(cat "activehosts.txt")
activehosts=""
junk=""

for i in $hosts
do
	echo $i
	[[ $(curl --head $i"/helloworld.html" | grep -c 200) > 0 ]] && activehosts+=$i"\n"
done
[[ $activehosts != "" ]] && printf $activehosts > webservers.txt
