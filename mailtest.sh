#!/bin/bash 

#Script for seaching Unison log for conflicts and emailing notification to administrator
unison=/home/john/.unison/unison.log
#Search the log and tally the conflicts
count=$(grep -c CONFLICT $unison)

if [ "$count" == 0 ];
then
	echo No conflicts detected.
elif [ "$count" -lt 20 ] && [ "$count" != 0 ];
then
	#Mail the error message
	cat $unison |grep CONFLICT | mail -s "Unison Conflict Detected" john@test.com

#To avoid large messages, just state Multiple conflicts and mail an alert
elif [ "$count" -gt 20 ]; 
then
	echo "Multiple conflicts detected. Please see log file for details" | mail -s "Unison Conflict Detected" john@test.com
fi

