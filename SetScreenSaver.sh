#!/bin/bash


	###############################################################
	#	Copyright (c) 2017, D8 Services Ltd.  All rights reserved.  
	#											
	#	
	#	THIS SOFTWARE IS PROVIDED BY D8 SERVICES LTD. "AS IS" AND ANY
	#	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
	#	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
	#	DISCLAIMED. IN NO EVENT SHALL D8 SERVICES LTD. BE LIABLE FOR ANY
	#	DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
	#	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
	#	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
	#	ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
	#	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
	#	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	#
	#
	###############################################################
	#

if [ ! -d "/Library/Screen Savers/Default Collections/OPPO/" ];then
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
	defaults write /Users/$currentUser/Library/Preferences/ByHost/com.apple.ScreenSaverPhotoChooser.$macUUID.plist SelectedFolderPath "/Library/Screen Savers/Default Collections/OPPO"
	defaults write /Users/$currentUser/Library/Preferences/ByHost/com.apple.ScreenSaverPhotoChooser.$macUUID.plist SelectedSource -int 3
	defaults write /Users/$currentUser/Library/Preferences/ByHost/com.apple.ScreenSaver.iLifeSlideShows.$macUUID styleKey "KenBurns"

	chown $currentUser /Users/$currentUser/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist
	chown $currentUser /Users/$currentUser/Library/Preferences/ByHost/com.apple.ScreenSaverPhotoChooser.$macUUID.plist
	chmod 700 /Users/$currentUser/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist
	chmod 700 /Users/$currentUser/Library/Preferences/ByHost/com.apple.ScreenSaverPhotoChooser.$macUUID.plist


	killall cfprefsd
