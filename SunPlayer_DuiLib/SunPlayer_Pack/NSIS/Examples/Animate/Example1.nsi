;--------------------------------
; General Attributes

Name "AnimGif plug-in test"
OutFile "AnimGif.exe"
InstallDir "$PROGRAMFILES"

;--------------------------------
; Images not included!
; Use your own animated GIFs please
;--------------------------------

;--------------------------------
;Interface Settings

!include "MUI.nsh"
!define MUI_HEADERIMAGE
; empty white placeholder for animated header GIF
!define MUI_HEADERIMAGE_BITMAP emptyh.bmp
!define MUI_WELCOMEFINISHPAGE_BITMAP emptyw.bmp
!define MUI_PAGE_CUSTOMFUNCTION_PRE pre
!define MUI_PAGE_CUSTOMFUNCTION_SHOW showWelcome
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE leaveWelcome
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

; for transparent images to be launched from 'show' function
!define COLOR_WINDOW 5
!define COLOR_BTNFACE 15 ; default for hidden windows - INSTFILES page color

Function pre

!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 1" "Text" ""

Functionend

Function showWelcome

; for Back button - dll reset
  AnimGif::stop
; left logo on the Welcome page
  AnimGif::play /NOUNLOAD /HALIGN=LEFT /VALIGN=CENTER /BGCOL=${COLOR_WINDOW} "$EXEDIR\tweety.gif"

FunctionEnd

Function leaveWelcome

  AnimGif::stop
; header image
  GetDlgItem $0 $HWNDPARENT 1034
  AnimGif::play /NOUNLOAD /HWND=$0 /HALIGN=LEFT /BGCOL=${COLOR_WINDOW} /FIT=HEIGHT "$EXEDIR\sonic.gif"

FunctionEnd

Function .onGUIEnd

  AnimGif::stop

FunctionEnd


Section


  Sleep 500
; during file install
  DetailPrint "Header logo"
  Sleep 2000
  Sleep 2000
  DetailPrint "That's all"
  Sleep 500

SectionEnd