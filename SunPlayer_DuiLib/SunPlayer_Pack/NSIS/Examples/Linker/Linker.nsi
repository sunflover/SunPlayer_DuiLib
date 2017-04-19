!addplugindir .

Name "Linker Test"
OutFile "Linker Test.exe"

XPStyle on

Page license "" LicenseShowFunc
Page instfiles

Function LicenseShowFunc

FindWindow $0 "#32770" "" $HWNDPARENT
GetDlgItem $0 $0 1006
Linker::link /NOUNLOAD $0 "http://www.google.com/"

FunctionEnd

Function .onGUIEnd

Linker::unload

FunctionEnd

Section
SectionEnd