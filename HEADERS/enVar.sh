#!/bin/sh

# PERM: rwxrwxrwx(777)

# This file contains BAS_enVar, SYS_enVar, USR_enVar
# and usr_cos_var right below

# var
export RESUME=00
export FBLA=30
export FRED=31
export FGRE=32
export FYEL=33
export FBLU=34
export FMAG=35
export FCYA=36
export FWHI=37

export BBLA=40
export BRED=41
export BGRE=42
export BYEL=43
export BBLU=44
export BMAG=45
export BCYA=46
export BWHI=47

export endl="\n"

# func
function ENDL
{
    printf $endl
}
export -f ENDL

function dye()
{
    local style=$1
    local content=$2
    
    printf "\e["$style"m"$content

    # Resume
.    printf "\e["$RESUME"m"
}
export -f dye

#################
#   BAS_enVar   #
#################

### File Types
## Image
# var
img=("tif", "tiff", "jpeg", "jpg", "gif", "png", "bmp", "eps")
# func
function isimage()
{
    local match=$1
    
    local len=${#img[*]}
    for (( i=0; i<$len; i++ )); do
	if [[ $match == ${#img[$i]} ]]; then
	    return 1
	fi
    done

    return 0
}
export -f isimage
## Audio

## Video

## Executable

## Unicode-Text (super set of ASCII)

### Data Types
## Commons
false=0
true=1

## Returning code
EXIT_SUCCESS=0
EXIT_FAILURE=1
EXIT_UNKNOWN=-1

#################
#   SYS_enVar   #
#################

#################
#   USR_enVar   #
#################

export  DOC="$HOME/Documents"
export  DOW="$HOME/Downloads"
export  MUS="$HOME/Music"
export  PIC="$HOME/Pictures"
export  VID="$HOME/Videos"
export  CFG="$HOME/.config"

export    C="$DOC/C"
export  CPP="$DOC/Cpp"
export    J="$DOC/Java"
export    P="$DOC/Python"
export    A="$DOC/Assembly"
export  PRO="$DOC/Projects"
export    S="$DOC/Shell"

export    H="$S/HEADERS"

export  ALL=("$DOC", "$DOW", "$MUS", "$PIC", "$VID", "$CFG")

export THIS="$H/enVar.sh"

function ask()
{
  content=$1
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
export -f ask

