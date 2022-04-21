#!/bin/bash
#KM_Follow_Me presets script v0.2.1

install_plist () {
    echo "⏳ Fetching and installing presets file..."
    #Download and install plist
    curl https://github.com/escarlson/KM_Follow_Me-Presets-for-Mac/raw/main/com.apple.print.custompresets.forprinter.KM_Follow_Me.plist -o ~/Library/Preferences/com.apple.print.custompresets.forprinter.KM_Follow_Me.plist
    #Check that the file was placed successfully, lest we needlessly reboot
    if [ -e ~/Library/Preferences/com.apple.print.custompresets.forprinter.KM_Follow_Me.plist ]
    then
        echo "✅ Presets installed sucessfully."
        #Set naturally occurring file permissions
        sudo chmod 600 ~/Library/Preferences/com.apple.print.custompresets.forprinter.KM_Follow_Me.plist
        #Prompt for reboot
        echo "A reboot is required for changes to take effect. Reboot now? (y/n)"
        read REBOOT_YN
        if [[ "y" == $REBOOT_YN ]]
        then
            echo "⚠ System going down right about now"
            #Reboot to apply changes
            sudo reboot now
        else
            echo "Reboot declined"
            #Exit without error
            exit 0
        fi
    else
        echo "❌ Error: plist not found after write attempt. Where would you be if you were a plist?"
        exit 2
    fi
}

#Check if plist exists, and if it does, ask if we want to overwrite it
echo "🕵️  Looking for existing presets..."
if [ -e ~/Library/Preferences/com.apple.print.custompresets.forprinter.KM_Follow_Me.plist ]
then
    echo "Presets for KM_Follow_Me already exist. Overwrite? (y/n)"
    read OVERWRITE_YN
    if [[ "y" == $OVERWRITE_YN ]]
    then
        echo "I see you like to live on the edge. Proceeding with overwrite..."
        install_plist
    else
        echo "Leaving presets unchanged and quitting..."
        #Exit without error
        exit 0
    fi
else
    echo "Installing presets where there were none..."
    install_plist
fi
