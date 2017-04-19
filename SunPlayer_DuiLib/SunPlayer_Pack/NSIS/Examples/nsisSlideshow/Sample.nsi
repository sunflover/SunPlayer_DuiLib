; nsisSlideshow - Sample script (automatic mode)

!ifndef TARGETDIR
!define TARGETDIR "..\bin"
!endif

!addplugindir "${TARGETDIR}"

Name "nsisSlideshow sample"
OutFile "Sample.exe"

;uncomment the following line to see how nsisSlideshow adapts to language in automatic mode
;LoadLanguageFile "${NSISDIR}\Contrib\Language Files\French.nlf"

Page license
LicenseData "Readme.txt"
Page instfiles
ShowInstDetails nevershow

Section Main
	InitPluginsDir
	SetDetailsPrint none
	SetOutPath "$PLUGINSDIR\Slides"
	File /r "Slides\*"
	SetOutPath "$INSTDIR"
	nsisSlideshow::show /NOUNLOAD "/auto=$PLUGINSDIR\Slides\Slides.dat"
	SetDetailsPrint both
	DetailPrint "Showing slideshow [$LANGUAGE]"
	Sleep 3000
	DetailPrint "Showing slideshow automatically"
	Sleep 3000
	DetailPrint "Showing slideshow automatically while"
	Sleep 3000
	DetailPrint "Showing slideshow automatically while performing"
	Sleep 3000
	DetailPrint "Showing slideshow automatically while performing installation"
	Sleep 5500
	nsisSlideshow::stop
	SetDetailsView show
SectionEnd
