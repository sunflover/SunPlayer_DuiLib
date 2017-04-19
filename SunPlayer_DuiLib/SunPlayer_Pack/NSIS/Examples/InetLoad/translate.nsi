
;--------------------------------
; General Attributes

Name "Translate Test"
OutFile "Translate.exe"
;SilentInstall silent


;--------------------------------
;Interface Settings

  !include "MUI.nsh"
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_LANGUAGE "English"


;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy

; This is 'fixed' russian variant. See Readme.txt for a list of parameters.
; Use LangStrings as TRANSLATE parameters for multilang options

    InetLoad::load /POPUP "Кемерон Диаз" /TRANSLATE "URL" "Загрузка" "Попытка соединения" "Имя файла" Получено "Размер" "Осталось" "Прошло" "http://www.dreamgirlswallpaper.co.uk/pheonixnightskicksass/wallpaper/Cameron_Diaz/camerond04big.JPG" "$EXEDIR\cd.jpg"
    Pop $0 # return value = exit code, "OK" if OK
    MessageBox MB_OK "Download Status: $0"

SectionEnd
