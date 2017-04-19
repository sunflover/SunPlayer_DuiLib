;--------------------------------
; General Attributes

Name "AnimGif plug-in test"
OutFile "AnimGif.exe"
InstallDir "$PROGRAMFILES"


;--------------------------------
;Interface Settings

!include "MUI.nsh"
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

; to paint on upper dialog window
;  AnimGif::play /NOUNLOAD /HWND=$HWNDPARENT "$EXEDIR\felix_new.gif"

!define COLOR_WINDOW 5
!define COLOR_BTNFACE 15 ; default for hidden windows - INSTFILES page color

Section

  Sleep 100
  DetailPrint "sunrise or sunset?"
  AnimGif::play /NOUNLOAD "$EXEDIR\8m6.gif"
  Sleep 2000
  Sleep 2000
  AnimGif::stop ; you can comment this line

SectionEnd
