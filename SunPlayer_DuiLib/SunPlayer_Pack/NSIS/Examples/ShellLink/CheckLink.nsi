!addplugindir .

!include MUI2.nsh
!include WinCore.nsh

Name "CheckLink"
OutFile "Setup.exe"
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE SimpChinese

Section -FindShortcut
    SetShellVarContext current
    FindFirst $0 $1 "$DESKTOP\*.lnk"
cur_loop:
        StrCmp $1 "" cur_done
        ShellLink::GetShortCutTarget "$DESKTOP\$1"
        Call PathGetFileName
        Pop $2
        DetailPrint "快捷方式：$DESKTOP\$1"
        DetailPrint "　　目标：$2"
        FindNext $0 $1
        Goto cur_loop
cur_done:
    FindClose $0

    SetShellVarContext all
    FindFirst $0 $1 "$DESKTOP\*.lnk"
all_loop:
        StrCmp $1 "" all_done
        ShellLink::GetShortCutTarget "$DESKTOP\$1"
        Call PathGetFileName
        Pop $2
        DetailPrint "快捷方式：$DESKTOP\$1"
        DetailPrint "　　目标：$2"
        FindNext $0 $1
        Goto all_loop
all_done:
    FindClose $0
SectionEnd

Function PathGetFileName
    Exch $0
    Push $1
    Push $2
    Push $3
    StrCpy $1 -1
lbl_loop4:
    StrCpy $2 $0 "" $1
    StrCpy $3 $2 1
    StrCmp $3 "\" lbl_ok4
    StrCmp $3 "" lbl_end4
    IntOp $1 $1 - 1
    Goto lbl_loop4
lbl_ok4:
    StrCpy $0 $2 "" 1
lbl_end4:
    Pop $3
    Pop $2
    Pop $1
    Exch $0
FunctionEnd