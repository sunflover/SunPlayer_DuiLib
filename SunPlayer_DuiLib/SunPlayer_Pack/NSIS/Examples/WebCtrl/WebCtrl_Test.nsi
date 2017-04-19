SetCompressor lzma

!ifdef NSIS_UNICODE
!define WEBCTRLDIR "..\Plugins\Unicode"
!else
!define WEBCTRLDIR "..\Plugins"
!endif
!addplugindir "${WEBCTRLDIR}"

!include "MUI.nsh"
!define MUI_PAGE_CUSTOMFUNCTION_SHOW WebCtrlShow
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_INSTFILES
!define MUI_PAGE_CUSTOMFUNCTION_SHOW WebCtrlShow
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "SimpChinese"

!define body `body scroll="no" oncontextmenu="return false" ondragstart="return false" onselectstart="return false" onselect="document.selection.empty()" oncopy="document.selection.empty()" onbeforecopy="return false" onmouseup="document.selection.empty()"`

Name "WebCtrl Test"
OutFile "WebCtrl_Test.exe"

Section
Sleep 1000
SectionEnd

Function WebCtrlShow
	GetDlgItem $0 $MUI_HWND 1202
	WebCtrl::ShowWebInCtrl $0 `<${body}><b>I'm a <u>HTML text</u></b></body>`
FunctionEnd
