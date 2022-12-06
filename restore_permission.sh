#!/bin/sh

# PERM: rwxrwxr-x(775)

#                          rwx
# r (read)       = 4 <-> 0b100
# w (write)      = 2 <-> 0b010
# x (execute)    = 1 <-> 0b001
# no permissions = 0 <-> 0b000

# This file restores permission from input user
# whthin all possible directories and files

# enVar
./HEADERS/enVar.sh

# var

# PERM vars: These are based on asume chown has been set to $thisusr
  STD_PERM=755

MEDIA_PERM=$STD_PERM # ~/Music, ~/Videos
#OTHER_PERM=$STD_PERM # ~/(dirs), ~/Pictures, ~/Downloads, ~/(files)
  USR_PERM=$STD_PERM # /home/JOHN_DOE
  CFG_PERM=774       # ~/.config
  DOC_PERM=$STD_PERM # ~/Documents
   PRIVATE=700       # Private level of permission
 PROTECTED=770       # Protected level of permission
    PUBLIC=777       # Public level of permission

function get_perm()
{
    local tar=$1
    local perm=0

    local r=1
    local w=2
    local x=4

    if [[ -r $tar ]]; then
	perm = $perm + $r
    fi

    if [[ -w $tar ]]; then
	perm = $perm + $w
    fi

    if [[ -x $tar ]]; then
	perm = $perm + $x
    fi

    return $perm
}

function restore_permission()
{   
    local thisusr=`whoami`
    sudo chown $thisusr:$thisusr $HOME

    # -I means local var
    declare -I ORDER

    local order=(     "$DOC",      "$DOW",      "$MUS",        "$PIC",      "$VID",        "$CFG")
    local order_perm=("$DOC_PERM", "$STD_PERM", "$MEDIA_PERM", "$STD_PERM", "$MEDIA_PERM", "$CFG_PERM")

    # Set general permission for whole directory
    sudo chmod -R $USR_PERM $HOME

    # Then we start set specific dir/file indvidually
    # The time complexity is unfortunate
    for (( i=0; i<${#order[*]}; i++ )); do
	if [[ `get_perm ${order[$i]}` != ${order[$i]} ]]; then
	    sudo chmod -R ${order_perm[$i]} ${order[$i]}
	fi
    done
}

