help(){
echo "------------------------------------
Syntax: bash ./$0 [- c/d]
Options: -c/-d
-c print login count of main user
-d print all disabled accounts
------------------------------------"
}
if [[ $# = 0 ]]
then
	help
else
	while getopts ":cd" option
	do
		case $option in
		c)
			user=$(cat "usr.txt")
			echo $(last $user | grep -c $user) 
		;;
		d)
			awk -F':' '/:\*:/ {print $1,$2}' "/etc/shadow"
		;;
		*)
			help
		;;
		esac
	done
fi
