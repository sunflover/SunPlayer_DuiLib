SetCompressor lzma

!AddPluginDir .
!include MUI.nsh

!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstShow
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "SimpChinese"

OutFile "Test.exe"
Name "SkinProgressBar"

Section
DetailPrint "正在演示进度条效果..."
Sleep 500
Sleep 500
Sleep 500
Sleep 500
Sleep 500
Sleep 500
Sleep 500
Sleep 500
Sleep 500
Sleep 500
SectionEnd

Function InstShow
	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $1 $0 1004
	SkinProgress::Set $1 "$PLUGINSDIR\Progress.bmp" "$PLUGINSDIR\ProgressBar.bmp"
FunctionEnd

Function .onInit
	InitPluginsDir
	File /oname=$PLUGINSDIR\Progress.bmp Progress.bmp
	File /oname=$PLUGINSDIR\ProgressBar.bmp ProgressBar.bmp
FunctionEnd
