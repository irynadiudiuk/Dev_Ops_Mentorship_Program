#!/bin/bash

cat content.txt|sort|uniq|while read clin;do
  if [[ $clin = *"prod"* ]];then
    continue
  fi
  echo "Line1" > result.txt
  echo "Line2" >> result.txt
  echo "Line3 $clin Line3" >> result.txt
  echo "Line4" >> result.txt
  #zip jgklf
  updn=`echo $clin|sed "s/\//_/g"`
  #mv fkgjk.zip deployment.conf_${updn}.zip
done
