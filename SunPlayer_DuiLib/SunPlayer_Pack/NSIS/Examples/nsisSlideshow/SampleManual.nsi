; nsisSlideshow - Sample script (manual mode)

!ifndef TARGETDIR
!define TARGETDIR "..\bin"
!endif

!addplugindir "${TARGETDIR}"

Name "nsisSlideshow sample"
OutFile "SampleManual.exe"

Page license
LicenseData "Readme.txt"
Page instfiles
ShowInstDetails nevershow

!macro Banner jpgfile Caption duration
	SetDetailsPrint none
	File /oname=$PLUGINSDIR\banner.jpg "Slides\${jpgfile}.jpg"
	nsisSlideshow::show /NOUNLOAD /duration=${duration} "/caption=${Caption}" "$PLUGINSDIR\banner.jpg"
	SetDetailsPrint both
!macroend

!macro BannerStep index
	!insertmacro Banner "slide ${index}" "caption ${index}" 500
	DetailPrint "Showing slide ${index}"
	Sleep 500
	DetailPrint "Showing slide ${index} while performing"
	Sleep 500
	DetailPrint "Showing slide ${index} while performing some operations"
	Sleep 500
!macroend

Section Main
	InitPluginsDir
	!insertmacro BannerStep "01"
	!insertmacro BannerStep "02"
	!insertmacro BannerStep "03"
	!insertmacro BannerStep "04"
	nsisSlideshow::stop
	;SetDetailsView show	; uncomment this to display details at the end
SectionEnd
