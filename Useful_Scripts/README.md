This folder contains short scripts and their explanation.

# Replacearchive.sh
This script works with three files.
1. content.txt
2. names.txt
3. template.txt


The task is to take a line from content.txt and insert it instead of the string "toreplace" in the template file.
Then template file is after that renamed, saved and zipped. The zipped file is after that renamed with a help of names.txt

# Replacearvchive.py

This Python script works with two files.
1. content.txt
2. template.txt

It has the same task as Replacearchive.sh (to insert the line from content.txt and then insert in into template.txt, zip it 
and rename the zipped file).

# makedp.sh
This bash script works with two files.
1. content.txt
2. template.txt
It creates a new file and inserts a correct client name into the correct place, zips the file and renames it.


# cycle.sh
it makes a REST API call to Splunk management port and run the search query on the server.
this search looks for the output within the last 30 days.
The output is then redirected to a file final.res

# lowercase.py
This script takes a file with uppercase srtings and converts them to lowercase.
