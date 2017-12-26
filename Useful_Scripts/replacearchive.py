#!/usr/bin/python

import os

os.chdir('pythonresults')
template = open('../template.txt').read()
# print template


for line in open('../content.txt'):
    replacement = line.strip()
    directory_name = 'deploymentclient.conf_' + replacement.replace('/', '_')
    zip_name = directory_name + '.zip'
    # print directory_name
    try:
        os.mkdir(directory_name)
        with open(directory_name + '/deploymentclient.conf', 'w') as output_file:
            output_file.write(template.replace('toreplace', replacement))
        command = 'zip -r %s %s' % (zip_name, directory_name)
        # print command
        os.system(command)
    except OSError:
        print directory_name, 'already exists'

