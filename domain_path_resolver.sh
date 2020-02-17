#!/bin/bash

start_time=$(date +%s)

echo -n "Please provide domain list: "
read domain

if [[ (-z $domain) || (! -f $domain) ]];then
	echo "You did not provide a domain list or the location of file is invalid!"
	exit
fi

echo -n "Please provide path list: "
read path

if [[ (-z $path) || (! -f $path) ]];then
	echo "You did not provide path list or the location of file is invalid!"
	exit
fi

for i in $( cat $path);do
	for j in $( cat $domain);do
		curl  --write-out "%{http_code} %{url_effective}\n" --connect-timeout 5 --max-time 5 --silent --insecure --location $j/$i --output /dev/null https://$j/$i --output /dev/null
	done
done

end_time=$(date +%s)
time_diff=$(( $end_time - $start_time ))
echo "Total time taken by script $time_diff seconds"
