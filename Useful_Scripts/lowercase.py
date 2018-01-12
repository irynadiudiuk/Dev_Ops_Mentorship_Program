import os


filefolder = open('./filewithcaps').read()

output_file = open('output.txt', 'w')

output_file.write(filefolder.lower())

output_file.close


