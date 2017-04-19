!ifdef NSIS_UNICODE
!define PLUGINSDIR "..\Plugins\Unicode"
!else
!define PLUGINSDIR "..\Plugins"
!endif
!addplugindir "${PLUGINSDIR}"

SetCompressor lzma

!include nsDialogs.nsh
!include MUI.nsh

!define MUI_PAGE_CUSTOMFUNCTION_SHOW Show
!insertmacro MUI_PAGE_WELCOME

!insertmacro MUI_PAGE_INSTFILES

!define MUI_PAGE_CUSTOMFUNCTION_SHOW Show
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "SimpChinese"

Name "nsWater Example"
OutFile "nsWater.exe"
;ReserveFile "${PLUGINSDIR}\nsWater.dll"

Section
SectionEnd

!define WM_SETBLOB 0x0470
; WM_SETBLOB为自定义消息，用于设置鼠标引起的水波大小
; wParam   水纹半径，会令到水纹看起来范围更广。
; lParam   水纹高度，会令到水纹看起来更深。

Function Show
	GetDlgItem $0 $MUI_HWND 1200
	System::Call 'User32::GetWindowLong(i r0, i ${GWL_STYLE})i.r1'
	System::Call 'User32::SetWindowLong(i r0, i ${GWL_STYLE}, i $1|${SS_NOTIFY})'
	SendMessage $0 ${STM_GETIMAGE} 0 0 $1
	nsWater::Set $0 $1
	SendMessage $0 ${WM_SETBLOB} 10 1000
	SendMessage $0 ${WM_MOUSEMOVE} 0 0x00960052
	SendMessage $0 ${WM_SETBLOB} 3 50
FunctionEnd
