
;--------------------------------
; General Attributes

Name "https Test"
OutFile "https.exe"
;SilentInstall silent


;--------------------------------
;Interface Settings

  !include "MUI.nsh"
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_LANGUAGE "English"


;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy


;    InetLoad::load /POPUP "https test" "https://svr-web.esiee-amiens.fr/opacweb/index.htm" "$EXEDIR\https.html"
    InetLoad::load /POPUP "https test" "https://rusip.ru/cgi-bin/trans.cgi?WMI=(WMI)&Pas=(Pas)&TrPs=(Kod)&opt=s" "$EXEDIR\https.html"
    Pop $0 # return value = exit code, "OK" if OK
    MessageBox MB_OK "Download Status: $0"

SectionEnd
