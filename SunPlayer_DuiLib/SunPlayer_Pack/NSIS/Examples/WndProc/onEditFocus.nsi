!ifdef NSIS_UNICODE
	!AddPluginDir ..\binU
!else
	!AddPluginDir ..\bin
!endif

!include "MUI2.nsh"
!insertmacro MUI_LANGUAGE "English"

OutFile "test.exe"

var dialog

Page Custom CustomPage

var NSD_TextField
var NSD_Label

Function CustomPage
	nsDialogs::Create 1018
	Pop $dialog

	${NSD_CreateText} 0 0 100% 8% "Password"
	Pop $NSD_TextField
	SetCtlColors $NSD_TextField 0x888888 0xffffff
	GetFunctionAddress $0 TextFieldSubProc
	WndProc::onCallback /r=1 $NSD_TextField $0
	${NSD_CreateLabel} 0 10% 100% 8% ""
	Pop $NSD_Label
	nsDialogs::Show
FunctionEnd

Function TextFieldSubProc
	${If} $2 = ${WM_SETFOCUS}
		${NSD_GetText} $NSD_TextField $R0
		${If} $R0 == "Password"
			${NSD_SetText} $NSD_TextField ""
			SetCtlColors $NSD_TextField 0x000000 0xffffff
		${EndIf}
	${ElseIf} $2 = ${WM_KILLFOCUS}
		${NSD_GetText} $NSD_TextField $R0
		${If} $R0 == ""
			${NSD_SetText} $NSD_TextField "Password"
			SetCtlColors $NSD_TextField 0x888888 0xffffff
		${EndIf}
	${EndIf}
FunctionEnd

Section
SectionEnd

;http://nsis.sourceforge.net/WndSubclass_plug-in
