Set-Location C:\Users\Ben\Documents\GitHub\SCM_Marshall\ASSETS
# $MasterSCM_Icons = "C:\Users\Ben\OneDrive\Documents\SCM_ASSETS\GIMP\SCM_Icons.xcf[3-7,15]"
$MasterSCM_Icons = "SCM_Icons.xcf[3-7,19]"

# note : to find the layer number in the GIMP project 
# easiest method is to dump thumbnail bmp out using ...
# If SET LOCATION not used then ... required a full pathname on the output side 
# ..\DEPLOY\SCM_Help.bmp wouldn't work

Remove-Item .\DUMP\*.bmp

magick convert SCM_Icons.xcf[3-7,16-19]  -resize 256x256 .\DUMP\SCM_Marshall.bmp
magick convert SCM_Icons.xcf[3-7,16-19] -flatten -resize 55x55 .\DUMP\SCM_Marshall_TEST_55x55.bmp


# This will create a multi-sized icon file - shorthand method. GIMP image canvas must be SQUARE

# Remove-Item "C:\Users\Ben\Documents\GitHub\SCM_TimeKeeper\DEPLOY\INNO\TestIcon.ico"
# linebreaks fail - don't use them - Must use full pathnames
# Not working -  Seems to be stuck on cached icon variant ?
# magick convert SCM_Icons.xcf[3-7][15] -flatten -resize 256x256 -alpha off -background white -define icon:auto-resize="256,128,96,64,48,32,16" .\SCM_Help.ico

<#
https://legacy.imagemagick.org/Usage/thumbnails/#favicon

The 'image.png' can be anything you like, but should be square. If it isn't that should also be the first step in the above.
You can also include larger resolutions such as 128 or 256 pixels, but few browsers would make use of them. 
The 16 and 32 pixel sizes are much more commonly used in such ICO files so special emphesis on those my be useful. 
Also remember that many browsers will color reduce the images so are to reduce the space used to store it in an users bookmarks file.

convert image.png -alpha off -resize 256x256 \
          -define icon:auto-resize="256,128,96,64,48,32,16" \
          favicon.ico

#>