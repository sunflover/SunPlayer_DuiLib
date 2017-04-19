;--------------------------------
; General Attributes

!define APNAME FullBg

Name "${APNAME} plug-in test"
OutFile "${APNAME}.exe"
InstallDir "$PROGRAMFILES"
BGGradient 0xff0000 0xffffff

;--------------------------------
; Images not included!
; Use your own animated GIFs please
;--------------------------------

;--------------------------------
;Interface Settings

!include "MUI.nsh"
!define MUI_CUSTOMFUNCTION_GUIINIT MUIGUIInit
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"


Function MUIGUIInit

  FindWindow $0 '_Nb'
  EBanner::show /NOUNLOAD /FIT=BOTH /HWND=$0 "${NSISDIR}\Contrib\Graphics\Header\orange.bmp"

FunctionEnd


Function .onGUIEnd

  EBanner::stop

FunctionEnd


Section

; during file install
  DetailPrint "install file here :)"

SectionEnd