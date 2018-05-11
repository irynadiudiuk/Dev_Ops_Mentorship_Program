#!/usr/bin/bash

# this script creates a file to be uploaded to s3
dt=$(date +%F-%S)
#echo $dt
date | tee -a file.$dt
export FILE=$(ls file.*)
~/.local/bin/aws s3 cp $FILE $s3

