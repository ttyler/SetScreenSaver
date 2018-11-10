# SetScreenSaver.sh
Set the screen Saver for a Mac to a folder with Client Images

A quick an d dirty way of configuring a group of Macs for accessing a directory containing corporate images for use within a screensaver.

Usually deployed with or after a package of images. If using Jamf PRO, a smart group checking for the folder path, or even an extension Attribute. Something like the following;

#!/bin/bash
if [ -d "<mydirectory> ];then<br>
echo "\<result\>yes\</result\>"<br>
else<br>
echo "\<result\>no\</result\>"<br>
fi<br>

If you are not using Jamf PRo the script may still be useful, but may prevent the script from running if your computer does not have the folder.

