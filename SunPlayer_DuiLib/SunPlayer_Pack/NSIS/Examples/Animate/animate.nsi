
Name "AnimateWindow animgif test"
OutFile "animate.exe"


!include "MUI.nsh"
!define MUI_CUSTOMFUNCTION_GUIINIT MUIGUIInit
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_LANGUAGE "English"

!define IMG_NAME aist.gif

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



; blend sample
    animate::show /NOUNLOAD /SFG /COLOR=0x60a0ff /NOCANCEL "$EXEDIR\${IMG_NAME}"
    Pop $0 ; show, error
    animate::hwnd /NOUNLOAD
    Pop $1
    AnimGif::play /NOUNLOAD /HWND=$1 "$EXEDIR\aist.gif" ; by default takes left top point color

    Sleep 3000

FunctionEnd

Function MUIGUIInit

    AnimGif::stop
    animate::wait /FLAGS=0 /IFNC 0
    Pop $1 ; reason to finish: click, wait, error, terminated
    ShowWindow $HWNDPARENT ${SW_RESTORE} ; set installer foreground
;    MessageBox MB_OK "show=$0 wait=$1"

FunctionEnd


Section
SectionEnd