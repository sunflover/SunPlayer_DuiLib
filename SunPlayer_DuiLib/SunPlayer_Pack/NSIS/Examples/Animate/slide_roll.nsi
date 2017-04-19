
Name "AnimateWindow Slide and Roll test"
OutFile "slide_roll.exe"


!include "MUI.nsh"
!define MUI_CUSTOMFUNCTION_GUIINIT MUIGUIInit
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_LANGUAGE "English"

!define IMG_NAME animate.jpg

!ifndef AW_HOR_POSITIVE
!define AW_HOR_POSITIVE             0x00000001
!define AW_HOR_NEGATIVE             0x00000002
!define AW_VER_POSITIVE             0x00000004
!define AW_VER_NEGATIVE             0x00000008
!define AW_CENTER                   0x00000010
!define AW_HIDE                     0x00010000
!define AW_ACTIVATE                 0x00020000
!define AW_SLIDE                    0x00040000
!define AW_BLEND                    0x00080000
!endif

Function .onInit

;  bottom to top in the right bottom corner slide sample
    IntOp $R0 ${AW_VER_NEGATIVE} | ${AW_SLIDE}
    animate::show /NOUNLOAD /SFG /ATIME=2000 /FLAGS=$R0 /X=-10 /Y=-10 "$EXEDIR\${IMG_NAME}"
    Pop $0 ; "show", "error"
; plug-in waits animation to finish (ATIME 2 sec) and returns after this only

FunctionEnd

Function MUIGUIInit

; time to wait ms, but user can close window with left click during this time (/NOCANCEL not set)
    animate::wait /FLAGS=${AW_VER_NEGATIVE} 2000
    Pop $1 ; reason to exit - "click", "wait", "error", "terminate"
    ShowWindow $HWNDPARENT ${SW_RESTORE} ; set installer window foreground
;    MessageBox MB_OK "show=$0 wait=$1"

FunctionEnd


Section
SectionEnd