Set-Location C:\Users\Ben\Documents\GitHub\SCM_Marshall\DEPLOY\INNO\

<#
Master GIMP file for flatten INNO left panel is store on microsoft's ONEDRIVE
(NOTE: ImageMagick doesn't know how to use the opacity of a layer.)
To build icons - canvas must be square .. Height = Width.
Not necessary, but I've expliciently fully qualified the output.
#>
$inpath = 'C:\Users\Ben\OneDrive\Documents\SCM_ASSETS\GIMP\'
$infile = $inpath + 'InnoLeftPanel_scmMarshall_FLATTEN.xcf'

$outpath = 'C:\Users\Ben\Documents\GitHub\SCM_Marshall\DEPLOY\INNO\'
$outfileA = $outpath + 'WizardImage_SCM_*.bmp'
$outfileB = $outpath + 'WizardSmall_SCM_*.bmp'
$file = $outpath + 'SCM_800x800_Splash.bmp'
$param2 = $inpath + 'SCM_Icons.xcf[3-7,16-19]'


if (Test-Path -Path $outfileA) {
    Remove-Item $outfileA
}
magick convert $infile -flatten -resize 410x797 WizardImage_SCM_410x797.bmp
magick convert $infile -flatten -resize 355x700 WizardImage_SCM_355x700.bmp
magick convert $infile -flatten -resize 328x604 WizardImage_SCM_328x604.bmp
magick convert $infile -flatten -resize 273x556 WizardImage_SCM_273x556.bmp
magick convert $infile -flatten -resize 246x459 WizardImage_SCM_246x459.bmp
magick convert $infile -flatten -resize 192x386 WizardImage_SCM_192x386.bmp
magick convert $infile -flatten -resize 164x314 WizardImage_SCM_164x314.bmp


if (Test-Path -Path $outfileB) {
    Remove-Item $outfileB
}
<#
 This GIMP project has many layers - just grab what we want
 Layer 0-1 hidden (orginal source) 2-3 WhiteBkgrd and water gradient, 
        4-5 BaseWave+Alpha, 6 HeroWave, 7 Swimmer
#>
magick convert $param2 -flatten -resize 55x55 WizardSmall_SCM_55x55.bmp
magick convert $param2 -flatten -resize 64x68 WizardSmall_SCM_64x68.bmp
magick convert $param2 -flatten -resize 83x80 WizardSmall_SCM_83x80.bmp
magick convert $param2 -flatten -resize 92x97 WizardSmall_SCM_92x97.bmp
magick convert $param2 -flatten -resize 110x106 WizardSmall_SCM_110x106.bmp
magick convert $param2 -flatten -resize 119x123 WizardSmall_SCM_119x123.bmp
magick convert $param2 -flatten -resize 138x140 WizardSmall_SCM_138x140.bmp


# A large 800x800 used by RAD as a 'Splash' screen
# If the file exist, remove it.
#
if (Test-Path -Path $file -PathType Leaf) {
    Remove-Item $file
}
magick convert $param2 -flatten -resize 800x800 $file