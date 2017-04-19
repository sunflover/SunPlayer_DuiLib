## General settings
Name "ToggleInstFiles Test"
OutFile "ToggleInstFiles.exe"
AutoCloseWindow false

## Page settings
Page InstFiles

## Main section
Section "A section"

 # Load plugin
 ToggleInstFiles::Set /NOUNLOAD

 # A general task
 DetailPrint "Doing something..."
 Sleep 5000

SectionEnd

## Unload plugin
Function .onInstSuccess
 ToggleInstFiles::Unload
FunctionEnd

Function .onInstFailed
 ToggleInstFiles::Unload
FunctionEnd