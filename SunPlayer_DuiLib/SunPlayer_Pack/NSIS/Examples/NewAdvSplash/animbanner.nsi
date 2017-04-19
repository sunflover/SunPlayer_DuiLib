;-----------------------------
; Requires AnimGif plug-in

Name "NewAdvSplash AnimBanner test"
OutFile "animbanner.exe"

!define IMG_NAME aist.gif

!include "MUI.nsh"
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE anb
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_INSTFILES
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE bna
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "English"


Function anb

    SetOutPath "$PLUGINSDIR"
    File ${IMG_NAME}

    newadvsplash::show /NOUNLOAD 2000 1000 500 -1 /BANNER "$PLUGINSDIR\${IMG_NAME}"
    newadvsplash::hwnd /NOUNLOAD
    Pop $0
    AnimGif::play /NOUNLOAD /hwnd=$0 /bgcol=0xffffff "$PLUGINSDIR\${IMG_NAME}"

FunctionEnd

Function bna

    newadvsplash::stop
    AnimGif::stop

    Delete "$PLUGINSDIR\${IMG_NAME}"
    SetOutPath "$EXEDIR"

FunctionEnd

Section

    newadvsplash::stop /wait
    AnimGif::stop
    Sleep 1000
    newadvsplash::show /NOUNLOAD 2000 1000 500 -1 /BANNER "$PLUGINSDIR\${IMG_NAME}"
    newadvsplash::hwnd /NOUNLOAD
    Pop $0
    AnimGif::play /NOUNLOAD /hwnd=$0 /bgcol=0xffffff "$PLUGINSDIR\${IMG_NAME}"
    Sleep 1000

SectionEnd
