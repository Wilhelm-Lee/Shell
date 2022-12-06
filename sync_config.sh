#!/bin/sh

WARN="Do you really want to proceed? Operation is not reversable!"

function ask()
{
  content=$1
  #printf "%s [y/N] " "$content"
  echo $content" [y/N] "
  read ans

  case $ans in
    [yY][eE][sS]|[yY])
      return true
      break # ???
    ;;
    [nN][oO]|[nN])
      return false
      break
    ;;
    *)
      echo "I guess you meant NO"
      sleep 0.75s
      return false
    ;;
  esac
}

# This file choose a user to synconize configuration with.

# Special cases
if [[ "`whoami`" == "root" ]]; then
    echo -e "\e[35mInfo: You are currently run this script with identity of \"root\".
Please aware inputting full path to target user, e.g. \"/home/johndoe\" is corrention restricted\e[37m.
Press ENTER to proceed"
    read
#else
#    echo -e "\e[35mInfo: Please input target user name \e[32m[[EXCEPT TO \"root\"]]\e[35m e.g. \"johndoe\"\e[37m.
#Press ENTER to proceed"
#    read
fi

echo -e "\e[37mPlease input target user name(case sensitive)
Your config files would be copied towards the target user."

read tarusr

# Variables setup
PIVOT_PATH="$HOME/Documents/Shell/"
PIVOT_FILE="$PIVOT_PATH/sync_config.sh"
THIS_CONFIG_PATH="$HOME/.config"

if [[ "$tarusr" == "root" || "$tarusr" == "/root" ]]; then
  THAT_CONFIG_PATH="/root"
else
  THAT_CONFIG_PATH=$tarusr
fi

ANNOUNCE_PATH="\e[31mWe need your permission to create a directory: $PIVOT_PATH
please enter the password.\e[37m"
ANNOUNCE_FILE="\e[31mWe need your permission to create a file: $PIVOT_FILE
please enter the password.\e[37m"

# Initialisations
if [[ ! -d $PIVOT_PATH ]]; then
  echo -e $ANNOUNCE_PATH
  if [[ ! $((`sudo mkdir -p $PIVOT_PATH`)) -eq 0 ]]; then
    echo "Operation aborted"
    exit 1
  fi
fi
if [[ ! -f $PIVOT_FILE ]]; then
  echo -e $ANNOUNCE_FILE
  if [[ ! $((`sudo touch $PIVOT_FILE`)) -eq 0 ]]; then
    echo "Operation aborted"
    exit 1
  fi
fi

# Invalid input of target user(path does not exist)
if [[ ! -d $THAT_CONFIG_PATH ]]; then
  echo "Err: Target user path does not exist! Operation aborted."
  exit 1
fi

## Ask for confirmation
#rtncode=[[ ask "$WARN" ]]
#
#if [[ $rtncode -eq false ]]; then
#  echo "Operation aborted!"
#  exit 0
#else
  if [[ $((`sudo cp -prf --remove-destination $THIS_CONFIG_PATH $THAT_CONFIG_PATH`)) == 0 ]]; then
      echo -e "\e[32mScript exited successfully\e[37m"
  else
      Echo -e "\e[31mScript exited with failure return code "$?
  fi
#fi

exit 0

