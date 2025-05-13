#!/usr/bin/env sh

if [[ "$OSTYPE" == "linux-gnu"* ]] then
	yay -S otf-geist-mono --noconfirm --needed
elif [[ "$OSTYPE" == "cygwin" ]] then
	touch $TEMP/font.zip
	FONT_URL=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/GeistMono.zip
	FONT_PATH=C:\\Users\\jando\\AppData\\Local\\Temp\\font
	wget $FONT_URL -O $FONT_PATH".zip"
	mkdir $FONT_PATH
	unzip $FONT_PATH".zip" -d $FONT_PATH
	explorer.exe /EXPAND, $FONT_PATH 
fi

