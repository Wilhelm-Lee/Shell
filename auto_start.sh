#!/bin/sh

# This file would be given a command to execute,
# script would not stop untill command exited
# successfully.

NULL="NULL"

# Help
if [[ $1 == "help" ]]; then
		echo "
Par1 is the program you want to execute your command(\"NULL\" for nil);
Par2 is the command you want to execute(Non-Empty);
Par3 is sleep time between two failed attempts(\"NULL\" for default: 0s);
Par4 is alternatived times to stop this script once exceeded(\"NULL\" for default: 256).

Example:
    auto_start.sh ../executor fetch_img 1m 12"
		exit 0
fi

prog=$1

cmd=$2

# `wait $gap`
gap=$3
# Alternatively, this script would stop
# from executing $giveup times or more
giveup=$4

# Input check
if [[ $cmd == $NULL ]]; then
		prog=""
fi

if [[ $gap == $NULL ]]; then
		gap="0s"
fi

if [[ $giveup == $NULL ]]; then
		giveup=256
fi

# Initiate for no Null Pointers
rtncode=1

counter=0
while [ 1 ]; do
		# Alternatived stoped
		if [[ $counter -eq $giveup || $counter -gt $giveup ]]; then
				notify-send -u critical "Command forced to stop! Last Code: $rtncode" "<$cmd> is not finished executing, but had tried too much times. Given up."
				exit 1
		fi

		dye $FCYA "Try NO.$(($counter+1)):\n"

		# Execute
		$prog $cmd
		rtncode=$?
		((counter+=1))

		# rtncode must be 0 to exit this script
		if [[ $rtncode != 0 ]]; then
				# Failed
				dye $FYEL "Failed! Sleeping for $gap\n"
   			sleep $gap
		else
				# Succeeded
				notify-send -u normal "Command execution was a success!" "$cmd had exited with return code $rtncode after $counter times of trying."
				exit 0
		fi
done		


