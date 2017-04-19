!addplugindir ".\release\"
!define APPNAME "HandleFileDragDrop"
NAME "${APPNAME}"
OutFile "${APPNAME}.exe"
ShowInstDetails show
RequestExecutionLevel user
CompletedText "Drop files on me..."
DirText "You can drop a folder on the text field!"
SpaceTexts none
InstallDir $temp

page directory "" dirShow
page InstFiles

Function dirShow
FindWindow $1 "#32770" "" $HWNDPARENT
GetDlgItem $0 $1 0x3E9
EnableWindow $0 0
GetDlgItem $0 $1 0x3FB
HandleFileDragDrop::MakeDropWindow $0 "" ;blank string means no callback, auto sets text of the window
FunctionEnd

Function InstPageDrop
DetailPrint Drop:$0
StrCpy $0 "" ;set to blank if you want the next file (if any)
FunctionEnd

Section
GetFunctionAddress $0 InstPageDrop
HandleFileDragDrop::MakeDropWindow $HWNDPARENT $0
;Error code is in $0, 0=success
SectionEnd

Function .OnGuiEnd
HandleFileDragDrop::NOP
FunctionEnd
