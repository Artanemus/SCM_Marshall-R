Set-Location C:\PROJECTS\SCM_TEMP\SCM_Marshall\ASSETS\
# $MasterSCM_Icons = "C:\Users\Ben\OneDrive\Documents\SCM_ASSETS\GIMP\SCM_Icons.xcf[3-7,15]"
$MasterSCM_Icons = "SCM_Icons.xcf[3-7,19]"

# note : to find the layer number in the GIMP project 
# easiest method is to dump thumbnail bmp out using ...
# magick convert GimpFilename.xcf -resize 256x256 SCM_Help.bmp

# This will create a multi-sized icon file - shorthand method. GIMP image canvas must be SQUARE

# OK
# NOTE: set location must be correct else use full pathnames
# TODO: Extract layers from master GIMP project in ONEDRIVE\Documents\SCM_ASSETS\GIMP\SCM_Icons.xcf
# Layers 3-7 are the SCM background, Layer 15 is question mark 
magick convert SCM_Icons.xcf[3-7,19] -flatten -resize 256x256 -alpha off -background white -define icon:auto-resize="256,128,96,64,48,32,16" SCM_Marshall.ico

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