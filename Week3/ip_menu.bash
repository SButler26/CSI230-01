input=0

while [[ $input != 6 ]]
do
	echo "1: Get ip address
2: Get ip address in binary
3: Get network mask in binary
4: Get network address in binary
5: Convert an ip address from binary to decimal
6: Quit"
	read input
	
	case $input in
	 1)
	 bash no_prefix_ip.bash
	 ;;
	 
	 2)
	 echo $address | bash ip_to_binary.bash
	 ;;
	 
	 3)
	 bash subnet_mask.bash
	 ;;
	 
	 4)
	 bash network_address.bash
	 ;;
	 
	 5)
	 echo "Input binary address to convert:"
	 read address
	 echo $address | bash binary_to_ip.bash
	 ;;
	 6)
	 ;;
	 *)
	 echo "Invalid input"
	 ;;
	esac
done
