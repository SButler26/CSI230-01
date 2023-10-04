cd "/var/log/apache2/"
files=$(ls | grep -v ".gz" | grep "access.log.") 

for i in $files
do
		cat $i >> "access.log"
		rm $i
done
