masklength=$(bash ip_prefix.bash)
mask=""

for i in {0..31}
do
	mask+=$(( $i < $masklength ))
done

echo $mask
