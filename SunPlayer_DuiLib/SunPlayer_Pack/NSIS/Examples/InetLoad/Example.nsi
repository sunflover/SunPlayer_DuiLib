
;--------------------------------
; General Attributes

Name "InetLoad Test"
OutFile "InetLoad.exe"
;SilentInstall silent


;--------------------------------
;Interface Settings

  !include "MUI.nsh"
  !define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install-colorful.ico"
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
  !insertmacro MUI_LANGUAGE "English"


;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy

# usage: InetLoad::load [/PROXY IP:PORT] [/USERNAME PROXY_LOGIN /PASSWORD PROXY_PASSWD] [/NOPROXY] [/NOCANCEL] [/POST TEXT2POST] [/TIMEOUT INT_MS] [/SILENT TEXT2DISPLAY] [/RESUME RETRY_QUESTION] [/POPUP PREFIX | /BANNER CAPTION TEXT] [/TRANSLATE LANG_PARAMS] URL1 local_file1 [URL2 local_file2 [...]] [/END]

    InetLoad::load /POPUP "Cameron Diaz" "http://www.dreamgirlswallpaper.co.uk/pheonixnightskicksass/wallpaper/Cameron_Diaz/camerond04big.JPG" "$EXEDIR\cd.jpg" "ftp://ftp.microsoft.com/MISC/ReadMe1.txt" "$EXEDIR\rm.txt"
    Pop $0 # return value = exit code, "OK" if OK
    MessageBox MB_OK "Download Status: $0"

SectionEnd


;--------------------------------
;Installer Functions

Function .onInit

    ;InetLoad::load /BANNER "" "mp3 file download in progress, please wait ;)$\nSecond line" /RESUME "Network error. Retry?" "http://dl.zvuki.ru/6306/mp3/12.mp3" "$EXEDIR\12.mp3"
    ;Pop $0
    ;MessageBox MB_OK "Download Status: $0"

FunctionEnd