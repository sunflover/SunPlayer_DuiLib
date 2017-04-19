Name                 "Delay"
OutFile              "demo.exe"
Caption              "Delay the next button"
SetCompressor        lzma
ShowInstDetails      show

;!AddPluginDir        ".\"
!include             MUI.nsh

!define MUI_CUSTOMFUNCTION_ABORT OnUserAbort

!insertmacro MUI_PAGE_WELCOME
!define MUI_PAGE_CUSTOMFUNCTION_SHOW LicensePage
!insertmacro MUI_PAGE_LICENSE "delay2.nsi"
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE English

Section
	DetailPrint "Do nothing..."
SectionEnd


Function LicensePage
  GetDlgItem $0 $HWNDPARENT 1
	Delay::DelayButton /NOUNLOAD $0 2 "A|B|C|D|E|F|G|H|I|J|K|L"
	Pop $1
FunctionEnd

Function .onGUIEnd
  Delay::Free
FunctionEnd

Function OnUserAbort
	Delay::Free
FunctionEnd


