
;--------------------------------
; General Attributes

Name "InetLoad Post Test"
OutFile "post.exe"
;SilentInstall silent


;--------------------------------
;Interface Settings

  !include "MUI.nsh"
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_LANGUAGE "English"


;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy

; This was my LAN test, replace link and login/pwd

    InetLoad::load /post "login=ami&passwd=333" "http://p401/post.php?lg=iam&pw=44" "$EXEDIR\post.htm"
    Pop $0 # return value = exit code, "OK" if OK
    MessageBox MB_OK "Download Status: $0"

SectionEnd


