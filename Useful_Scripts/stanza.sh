cat stanza.sh
#!/usr/bin/bash

 cat content.txt | while read str; do
 echo >> result.txt
 echo "# 20180116 Diudiuk, Iryna. Contact(s): Allem, Michael" >> result.txt
 echo "# `echo $str | cut -d"/" -f4- | sed -e 's/\// /g' | sed -r 's/\s+\S+$//'` (PCI)" >> result.txt
 echo "[serverClass:`echo $str | cut -d"/" -f2- | sed -e 's/\//_/g'`]" >> result.txt
 echo "whitelist.0 = *`echo $str |cut -d"/" -f2-`" >> result.txt
 echo "[serverClass:`echo $str | cut -d"/" -f2- | sed -e 's/\//_/g'`:app:inputs_`echo $str | cut -d"/" -f2- | sed -e 's/\//_/g'`" >> result.txt
 echo "restartSplunkd = true" >> result.txt

 done
