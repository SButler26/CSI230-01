echo $(ip addr) | awk 'NR==1 {print $55}'
