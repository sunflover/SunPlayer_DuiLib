
!define APP_NAME SelfDel

Name "${APP_NAME}"
OutFile "${APP_NAME}.exe"
;SilentInstall silent

!include "MUI.nsh"
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"


Section "Dummy Section" SecDummy
  

SectionEnd


Function .onInstSuccess

  SelfDel::del

FunctionEnd
