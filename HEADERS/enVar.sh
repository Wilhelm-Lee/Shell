#!/bin/sh

# PERM: rwxrwxrwx(777)

# This file contains BAS_enVar, SYS_enVar, USR_enVar
# and usr_cos_var right below

# Tips: Compare strings with '==';
#       Compare values with '-eq'

# var
# Colors
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

# Styles
export      RESET=0
export       BOLD=1
export        DIM=2
export     ITALIC=3
export      UNDER=4
export     SBLINK=5
export     FBLINK=6
export    REVERSE=7
export    CONCEAL=8
export      CROSS=9
export    DEFFONT=10
export   ALTFONT1=11
export   ALTFONT2=12
export   ALTFONT3=13
export   ALTFONT4=14
export   ALTFONT5=15
export   ALTFONT6=16
export   ALTFONT7=17
export   ALTFONT8=18
export   ALTFONT8=19
export    FRAKTUR=20
export     NOBOLD=21
export      NODIM=22
export   NOITALIC=23
export    NOUNDER=24
export    NOBLINK=25
# NO 26
export  NOREVERSE=27
export  NOCONCEAL=28
export    NOCROSS=29
export    DEFTEXT=39
export    DEFBACK=49
# NO 50
export      FRAME=51
export   ENCIRCLE=52
export   OVERLINE=53
export    NOFRAME=54
export NOOVERLINE=55

export endl="\n"

export NULL="NULL"

# func
function ENDL
{
    printf $endl
}
export -f ENDL

function dye()
{
		# Help
		if [[ $1 == "help" || $1 == "-h" || $1 == "--help" ]]; then
				echo "dye help|-h|--help for this help
dye [fore_style] [fore_color] [back_style] [back_color] [content]

fore_color: When NOT NULL, from 30 to 37;
back_color: When NOT NULL, from 40 to 47;
style:      When NOT NULL, from  0 to 10;
content:    A Non-Null string(Quotes are optional)

Example:
    dye \$BOLD \$FCYA \$ITALIC \$BRED \"Text\" # Different styles will apply all

    dye NULL  \$FCYA \$ITALIC \$BRED \"Text\" # Compare to above one, no Bold

    dye \$BOLD \$FCYA NULL    \$BRED \"Text\" # No any styles(NULL on second
                                             style(aka back_style) would
                                             reset all styles!)

    dye NULL  \$FCYA NULL    \$BRED \"Text\" # Same to above one

    dye \$BOLD NULL  \$ITALIC \$BRED \"Text\" # Comapre to the first one,
                                             styles would be the same,
                                             but text color(aka fore_color)
                                             is the default color

    dye \$BOLD \$FCYA \$ITALIC NULL  \"Text\" # Similar to the above one, but
                                             background color(aka back_color)
                                             is the default color"
				return 0
		fi

		# dye [fore_style] [fore_color] [back_style] [back_color] [content]
		local fore_style=$1
		local fore_color=$2
		local back_style=$3
		local back_color=$4
		local    content=$5
		
		if [[ $fore_style == $NULL ]]; then
				fore_style=$RESET
		fi

		if [[ $fore_color == $NULL ]]; then
				fore_color=$DEFTEXT
		fi
		
		if [[ $back_style == $NULL ]]; then
				if [[ $(($fore_style >= $BOLD)) && $(($fore_style <= $CROSS)) ]]; then
						back_style=$(($fore_style+20))
				else
						back_style=$RESET
				fi
		fi

		if [[ $back_color == $NULL ]]; then
				back_color=$DEFBACK
		fi
		
		printf "\e["$fore_style";"$fore_color";"$back_style";"$back_color"m"$content

		# Resume
		printf "\e["$RESET"m"
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

export QT_QPA_PLATFORMTHEME=qt5ct

#################
#   USR_enVar   #
#################

export    E="/usr/bin/emacs"

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

export AUTO="$S/auto_start.sh"

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

