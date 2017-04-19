!ifndef NSIS_UNICODE
!AddPluginDir .\Plugins
!else
!AddPluginDir .\Unicode
!endif

!include "nsDialogs.nsh"

Name Example
OutFile setup.exe
Icon "${NSISDIR}\Contrib\Graphics\Icons\arrow-install.ico"
InstallDir $TEMP

Page directory
Page custom Custom.Create
Page components
Page instfiles

XPStyle on
InstallColors /windows
ShowInstDetails show

Function .onInit
    InitPluginsDir
    File /oname=$PLUGINSDIR\button1.png button1.png
    File /oname=$PLUGINSDIR\button2.png button2.png
FunctionEnd

Function .onGUIInit
	GetDlgItem $0 $HWNDPARENT 1
	SkinButton::SetSkin $0 $PLUGINSDIR\button1.png
	GetDlgItem $0 $HWNDPARENT 2
	SkinButton::SetSkin $0 $PLUGINSDIR\button2.png
	SetCtlColors $0 0x0000FF
	GetDlgItem $0 $HWNDPARENT 3
	SkinButton::SetSkin $0 $PLUGINSDIR\button2.png
	SetCtlColors $0 0xFF0000
FunctionEnd

Function Custom.Create
    nsDialogs::Create 1018
    Pop $0
    StrCmp $0 error 0 createPage
    Abort
checkClick:
    Exch $0
    SendMessage $0 ${BM_GETCHECK} 0 0 $0
    EnableWindow $1 $0
    Pop $0
    Return
createPage:
    ${NSD_CreateButton} 0u 0u 100u 40u "Button"
    Pop $1
    SetCtlColors $1 0xEFEFEF
    SkinButton::SetSkin $1 $PLUGINSDIR\button1.png

    ${NSD_CreateCheckBox} 0u 50u 100u 8u "Enable"
    Pop $2
    GetLabelAddress $0 checkClick
    nsDialogs::onClick $2 $0
    SendMessage $2 ${BM_CLICK} 0 0

    nsDialogs::Show
FunctionEnd

Section Main

SectionEnd