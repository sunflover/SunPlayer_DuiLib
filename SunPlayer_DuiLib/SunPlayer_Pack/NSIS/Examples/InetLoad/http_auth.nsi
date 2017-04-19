
;--------------------------------
; General Attributes

Name "http auth Test"
OutFile "http auth.exe"
;SilentInstall silent


;--------------------------------
;Interface Settings

  !include "MUI.nsh"
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_LANGUAGE "English"


;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy

; Displays IE auth dialog.
; Please test this with your own link

    InetLoad::load /POPUP "http auth test" "http://www.cnt.ru/personal" "$EXEDIR\auth.html"
    Pop $0 # return value = exit code, "OK" if OK
    MessageBox MB_OK "Download Status: $0"

SectionEnd
