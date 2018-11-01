#!/bin/bash



if [ ! -d "/Library/Screen Savers/Default Collections/<my folder>/" ];then
	echo "ERROR: Directory does not exists. Exiting"
	exit 1
fi

	currentUser=`ls -l /dev/console | cut -d " " -f 4`

	# grab the system's uuid
	if [[ `ioreg -rd1 -c IOPlatformExpertDevice | grep -i "UUID" | cut -c27-50` != "00000000-0000-1000-8000-" ]]; then
		macUUID=`ioreg -rd1 -c IOPlatformExpertDevice | grep -i "UUID" | cut -c27-62`
	fi

	#jamf displayMessage -message $currentUser

	defaults write /Users/$currentUser/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist CleanExit "YES"
	defaults write /Users/$currentUser/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist PrefsVersion -int 100
	defaults write /Users/$currentUser/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist idleTime -int 600
	defaults write /Users/$currentUser/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist moduleDict -dict moduleName "iLifeSlideshows" path "/System/Library/Frameworks/ScreenSaver.framework/Resources/iLifeSlideshows.saver" type -int 0
	defaults write /Users/$currentUser/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist tokenRemovalAction -int 0
	defaults write /Users/$currentUser/Library/Preferences/ByHost/com.apple.ScreenSaverPhotoChooser.$macUUID.plist LastViewedPhotoPath ""
	defaults write /Users/$currentUser/Library/Preferences/ByHost/com.apple.ScreenSaverPhotoChooser.$macUUID.plist SelectedFolderPath "/Library/Screen Savers/Default Collections/<my folder>"
	defaults write /Users/$currentUser/Library/Preferences/ByHost/com.apple.ScreenSaverPhotoChooser.$macUUID.plist SelectedSource -int 3
	defaults write /Users/$currentUser/Library/Preferences/ByHost/com.apple.ScreenSaver.iLifeSlideShows.$macUUID styleKey "KenBurns"

	chown $currentUser /Users/$currentUser/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist
	chown $currentUser /Users/$currentUser/Library/Preferences/ByHost/com.apple.ScreenSaverPhotoChooser.$macUUID.plist
	chmod 700 /Users/$currentUser/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist
	chmod 700 /Users/$currentUser/Library/Preferences/ByHost/com.apple.ScreenSaverPhotoChooser.$macUUID.plist


	killall cfprefsd
