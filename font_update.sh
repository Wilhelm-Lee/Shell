#!/bin/sh

# This file is designed to automatically update your font
# include which new fonts added into libs.

FONT_PATH="/usr/share/fonts"
DNLD_FONT_PATH=$FONT_PATH"/downloaded"
FONT_LIST_PATH="$HOME/Documents"
FONT_LIST_FILE=$FONT_LIST_PATH"/font_list"

permi=777
echo "Changed permission with "$permi" in $DNLD_FONT_PATH"

sudo chmod $permi $DNLD_FONT_PATH
sudo mkfontscale
sudo mkfontdir
sudo fc-cache -fv

if [[ ! -d $FONT_LIST_PATH ]]; then
    echo "Warn: Target directory does not exist. Creating..."
    sudo mkdir -p $FONT_LIST_PATH
fi

if [[ ! -f $FONT_LIST_FONT ]]; then
    echo "Warn: Target file does not exist. Creating..."
    sudo touch $FONT_LIST_FILE
fi

if [[ $((`sudo fc-list > $FONT_LIST_PATH`)) == 0 ]]; then
    echo "Generating file "$FONT_LIST_FILE" succeeded."
    exit 0
else
    echo "Generating file "$FONT_LIST_FILE" failed."
    exit 1
fi

