
;--------------------------------
; General Attributes

Name "InetLoad ftp Test"
OutFile "ftppwd.exe"
;SilentInstall silent


;--------------------------------
;Interface Settings

  !include "MUI.nsh"
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_LANGUAGE "English"


;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy

; Use your own URL and login:pwd

    InetLoad::load /popup "Service pack ftp download" "ftp://takhir:password@p401/hard/arch_disk/tar.gz/W2Ksp3.exe" "$EXEDIR\sp3.exe"
    Pop $0 # return value = exit code, "OK" if OK
    MessageBox MB_OK "Download Status: $0"

SectionEnd

