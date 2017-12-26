#/bin/bash

# set -e

RESULT="$?"
CONTENT="content.txt"
TEMPLATE="template.txt"
NAMES="names.txt"
ioput="ioput.txt"
# DC="deployment.conf"
done=doneconfigs

while [ $(ls | grep content | wc -l) -gt 0 ]
do
DC="deployment.conf"
replacecn=`head -n 1 content.txt` 2> /dev/null
escaped="$replacecn"
escaped="${escaped//\//\\/}"  2> /dev/null
export $escaped       2> /dev/null
replacefn=`head -n 1 names.txt`
C=`wc -l < $CONTENT`
N=`wc -l < $NAMES`


#Replace the client name value with the client name from content file

cp $TEMPLATE $DC 
echo $(sed -n 2p ${DC}) >> $ioput
sed -i "s|toreplace|${escaped}|g" $DC  2> /dev/null
if [ $RESULT -eq 0 ]; then

  echo "successful replacement"  >> $ioput
  echo $(sed -n 2p ${DC}) >> $ioput
  sed -i -e "1d" $CONTENT 2> /dev/null

else

  echo "failed to delete a line...exiting"

fi

# Compressing and renaming the archive with the name of the client.

zip -r -9 $DC.zip $DC > /dev/null
mv $DC.zip $DC_$replacefn.zip
if [ $RESULT -eq 0 ]; then
  echo "successful renaming" >> fullnames.txt
  ls | grep ".zip" >> fullnames.txt 
  sed -i -e "1d" "$NAMES" 
  ls | grep ".zip" | xargs mv -t doneconfigs  > /dev/null

else
  echo "failed to rename an archive...exiting" 

fi

if
[[ ${C} == ${N} ]] ; then

echo "Line count correct $(date +%F)" >> linecheck.txt
else
echo "Something went wrong"
fi 

 if [[ -s ${CONTENT} ]] ; then
     echo " ${CONTENT} has data $(date +%F)"  >>  datacheck.txt
 else
   echo " ${CONTENT} is empty and will be deleted. The process completed successfully."
   rm -f ${CONTENT}
 fi 

done
exit 0

