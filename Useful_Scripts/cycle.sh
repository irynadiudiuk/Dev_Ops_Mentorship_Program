
#!/bin/bash

#echo > output.csv
>final.res

cat uniqlist | while read host; do

  echo "Working with $host:"
  curl -ku 'user:password' https://.........8089//servicesNS/admin/search/search/jobs/export -d 'search=tstats values(source) as sources WHERE earliest=-29d latest=now index=* host='${host}' by host' -d output_mode=csv > output.csv
  if [ -s output.csv ];then
    echo "----------"
    cat output.csv|grep -v "host,sources" |tr -d "\""|tr ' ' '\n'|tr ',' '\n' >> final.res
  else
    echo "Request is empty :("
    echo "$host" >> final.res
  fi
  sleep 2
done

