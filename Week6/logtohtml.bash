row="\n\t\t\t"
accesses=$(cat "/var/log/apache2/access.log")
file="<html>\n<body>\n\t<table>"
#add the header row
file+="\n\t\t<tr>$row<td>IP</td>$row<td>Time</td>$row<td>RequestedPage</td>$row<td>UserAgent</td>"

IFS=$'\n'
for i in $accesses
do
	file+="\n\t\t</tr>\n\t\t<tr>"
	
	data=$(echo $i | awk '{print $1"\n"$4"\n"$7"\n"$12}')
	for j in $data
	do
		j=${j#[}
		j=${j#'"'}
		j=${j%'"'}
		file+="$row<td>$j</td>"
	done
done

file+="\n\t\t</tr>\n\t</table>\n</body>\n</html>"
printf $file > access.html
printf $file > /var/www/html/access.html
