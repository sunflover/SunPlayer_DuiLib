SetCompressor lzma
XPStyle on

!define TTM_NOICON 0
!define TTM_INFOICON 1
!define TTM_ALERTICON 2
!define TTM_ERRORICON 3

Page instfiles "" "inst_show" ""

Function "inst_show"
FindWindow $0 "#32770" "" $HWNDPARENT
GetDlgItem $1 $0 1016 # $1 will have the HWND of the Log window (AKA Detail Window)
GetDlgItem $5 $0 1004 # $5 will have the HWND of the progress bar
ToolTips::Classic $1 "Here you can view the installation details....!"
ToolTips::Modern $5 ${TTM_INFOICON} "NSIS Installer" "Progress of your installation"
FunctionEnd

Name "Lobo Lunar"
OutFile "ToolTips.exe"
BrandingText "Lobo Lunar"
InstallDir "$EXEDIR"
ShowInstDetails show

Section "-default"
; Nothing...
SectionEnd


