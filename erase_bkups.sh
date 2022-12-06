#!/bin/sh

# This file will erase all backup files in target directory recursively

WILLIAM="/home/william"
WARN="Target dir is root! Are you sure to proceed?"

# Set up enVars
$WILLIAM/Documents/Shell/HEADERS/enVar.sh

bkup_files=(".bkz", ".abk", ".backup", "~")

echo "Please input target directory to erase backup files to.
The following files were meant to be removed"

for (( i=0; i<${#bkup_files[*]}; i++ )); do
    printf "dye $FYEL ${bkup_files[$i]} "

    # Wrap to a new line
    if [[ $(( $i % 8 )) == 0 ]]; then
	ENDL
    fi
done

ENDL

read tardir

if [[ $tardir == "/" ]]; then
    tmp=dye 1 "dye $FRED $WARN"
    if [[ `ask $tmp` == $false ]]; then
	return $EXIT_SUCCESS
    fi
# Input was empty
elif [[ ! -z $tardir ]]; then
    # Use default dir
    

if [[ `sudo rm -R $tardir` == $EXIT_SUCCESS ]]; then
    echo "Script exited successfully"
    exit $EXIT_SUCCESS
else
    echo "Script exited with code "$?
    exit $EXIT_FAILURE
fi

