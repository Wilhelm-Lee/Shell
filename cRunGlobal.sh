#!/bin/sh

# Global enVar (GenVar)
COLOUR_END="\e[0m"
EXIT_SUCCESS=0
EXIT_FAILED=1

# Local vars (LV)
OUTPUT_PATH=$HOME/Documents/CompiledExecutables/C
TMP_PATH=$OUTPUT_PATH/tmp
TMP_FILE=$TMP_PATH/.history
HISTORY_FILE_REMAINS="Your previous history file remains.
Do you wish to inherit(keep using) it? [y/N] "
RM_TMP_FILE="rm -f $TMP_FILE"
RM_TMP_PATH="rmdir --ignore-fail-on-non-empty $TMP_PATH"

# Initiation
if [[ -f $TMP_FILE ]]
then
	echo $HISTORY_FILE_REMAINS
	read
	if [[ ! -z $REPLY ]]
	then
		case $REPLY in
			"y" | "Y" | "yes" | "Yes" | "YES")
				break
			;;
			"n" | "N" | "no" | "No" | "NO")
				$RM_TMP_FILE
			;;
			*)
				echo "I think you meant NO."
				sleep 0.7s
				$RM_TMP_FILE
		esac
	else
		$RM_TMP_FILE
	fi
fi

# Set background colour as ${RESET} (once only)
echo -e "\e[48m$COLOUR_END"

clear -x

while :
do

	[[ ! -d $OUTPUT_PATH ]] && mkdir -p $OUTPUT_PATH
	[[ ! -d $TMP_PATH ]] && mkdir -p $TMP_PATH
	[[ ! -f $TMP_FILE ]] && touch $TMP_FILE

	# Set background colour as ${RESET} (non-once only)
	echo -e "\e[48mC Global$COLOUR_END"
	echo "Input absolute dir to file: (With Extension)"
	read

	# Input was empty
	if [[ -z $REPLY ]]
	then
		continue
	else
		echo $REPLY >> $TMP_FILE
		if [[ $REPLY == "exit" ]]
		then
			$RM_TMP_FILE
			$RM_TMP_PATH
			exit $EXIT_SUCCESS
		fi
	fi

	TARGET_FILE=$REPLY
	dateMark=`date +"%A_%d_%b_%Y_%H%m%s"`
	OUTPUT_FILE=$OUTPUT_PATH/$dateMark
	

	# Return 0 for normal exit(g++)
	gcc $TARGET_FILE -o $OUTPUT_FILE
	if [[ $? -eq 0 ]]
	then
		echo -e "\e[37m$COLOUR_END" # Set foreground colour as #{grey}
		clear -x
		echo -e "\e[44m====== FILE COMPILED ======$COLOUR_END"
		# execute
		$OUTPUT_FILE
		clear -x
		echo -e "\e[44m====== PROGRAMME EXITED ======$COLOUR_END"
	else
		clear -x
		echo -e "\e[41mXXXXXX FAILED COMPILING XXXXXX$COLOUR_END"
	fi

done
