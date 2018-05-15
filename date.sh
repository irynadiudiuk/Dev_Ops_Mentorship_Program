#!/usr/bin/bash

# this script creates a file to be uploaded to s3
dt=$(date +%F-%S)
#echo $dt
date | tee -a datefile
export FILE=$(ls datefile)


