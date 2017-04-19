!include MUI.nsh

## General settings
Name "ToggleInstFiles MUI Test"
OutFile "ToggleInstFilesMUI.exe"

## Page settings
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_NOAUTOCLOSE
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE English

## Main section
Section "A section"

 # Load plugin
 ToggleInstFiles::Set /NOUNLOAD /RIGHT /SHOWTEXT "Show me!" /HIDETEXT "Hide me!"

 # A general task
 DetailPrint "Doing something..."
 Sleep 5000

SectionEnd

## Unload plugin
Function .onGUIEnd
 ToggleInstFiles::Unload
FunctionEnd