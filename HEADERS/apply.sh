#!/bin/sh

# This file applies ./enVar.sh to bashrc file

bashrc="$HOME/.bashrc"
bashrc_cp="$HOME/.bashrc_cp"
bashrc_default="$HOME/.bashrc_default"
enVar="$HOME/Documents/Shell/HEADERS/enVar.sh"

if [[ ! -f $bashrc ]]; then
    touch $bashrc
fi

# Shift origenal bashrc file into copy one.
# OVERWRITTEN
cp $bashrc -T $bashrc_cp

# Then, we output enVar.sh appends into origenal one to apply.
# OVERWRITTEN
# Even if $have is not set, system would return 0 as var_not_found
if [[ ! $have ]]; then
    cat $enVar > $bashrc
    export have=1
else
    cat $enVar >> $bashrc
    export have=1
fi

# Finally, we append on bashrc_default
cat $bashrc_default >> $bashrc

