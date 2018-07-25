#!/bin/bash
#remove files older than 1 year old

#store old value and change bash Internal Field Sepearator (IFS) to New Line
old_IFS=$IFS
IFS=$'\n'

#text file with list of directories separated by new lines
file=/home/john/scripts/1year.txt

#create an array and fill it with the vaules from the text doc
array=($(cat $file))

#iterate through the array and remove files older than 365 days from each directory
for i in ${array[@]} ; 
do
find $i -type f -mtime +365 -exec rm {} \;
done

#restore IFS value
IFS=$old_IFS

