
Name "AnimateWindow Center test"
OutFile "center_rnr.exe"


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



; blend sample, 1 sec default animation time
    animate::show /NOUNLOAD /SFG /BORDER /FLAGS=${AW_CENTER} "$EXEDIR\${IMG_NAME}"
    Pop $0 ; "show", "error" - for debug purposes

FunctionEnd

Function MUIGUIInit

; 2 sec wait for user click, if not - 2 sec rock-n-roll animate on close
    IntOp $R0 ${AW_VER_NEGATIVE} | ${AW_HOR_POSITIVE}
    IntOp $R0 $R0 | ${AW_SLIDE}
    animate::wait /FLAGS=$R0 /ATIME=2000 2000
    Pop $1 ; reason to exit - "click", "wait", "error", "terminate"
    ShowWindow $HWNDPARENT ${SW_RESTORE} ; set installer foreground
;    MessageBox MB_OK "show=$0 wait=$1"

FunctionEnd


Section
SectionEnd