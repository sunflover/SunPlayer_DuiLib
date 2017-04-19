!ifndef DLGPROC_INCLUDED
!define DLGPROC_INCLUDED
!verbose push
!verbose 3

!include "nsDialogs.nsh"
!include "Util.nsh"

!macro _DEFINE_PUSH SYMBOL
	!verbose push
	!verbose ${LOGICLIB_VERBOSITY}
	!insertmacro _PushLogic
	!ifdef `${SYMBOL}`
		!define ${_Logic}TEMP_DEFINE `${${SYMBOL}}`
		!undef `${SYMBOL}`
	!endif
!macroend

!macro _DEFINE_POP SYMBOL
	!ifdef `${SYMBOL}`
		!undef `${SYMBOL}`
	!endif
	!ifdef ${_Logic}TEMP_DEFINE
	  !define `${SYMBOL}` ${${_Logic}TEMP_DEFINE}
	  !undef ${_Logic}TEMP_DEFINE
	!endif
  !insertmacro _PopLogic
  !verbose pop
!macroend

!ifdef define
	!undef define
!endif

!define define `!insertmacro DLGPROC_DEFINE`
!macro DLGPROC_DEFINE SYMBOL CONTENT
	!ifdef `${SYMBOL}`
		!undef `${SYMBOL}`
	!endif
	!define `${SYMBOL}` `${CONTENT}`
!macroend

!macro DLGPROC_DefineControl NAME

	${define} Create${NAME} "${CreateDlgCtrl} ${__NSD_${Name}_CLASS} ${__NSD_${Name}_STYLE} ${__NSD_${Name}_EXSTYLE}"
	${define} Create${NAME}P "${CreateCtrlP} ${__NSD_${Name}_CLASS} ${__NSD_${Name}_STYLE} ${__NSD_${Name}_EXSTYLE}"

!macroend

!insertmacro DLGPROC_DefineControl HLine
!insertmacro DLGPROC_DefineControl VLine
!insertmacro DLGPROC_DefineControl Label
!insertmacro DLGPROC_DefineControl Icon
!insertmacro DLGPROC_DefineControl Bitmap
!insertmacro DLGPROC_DefineControl BrowseButton
!insertmacro DLGPROC_DefineControl Link
!insertmacro DLGPROC_DefineControl Button
!insertmacro DLGPROC_DefineControl GroupBox
!insertmacro DLGPROC_DefineControl CheckBox
!insertmacro DLGPROC_DefineControl RadioButton
!insertmacro DLGPROC_DefineControl Text
!insertmacro DLGPROC_DefineControl Password
!insertmacro DLGPROC_DefineControl Number
!insertmacro DLGPROC_DefineControl FileRequest
!insertmacro DLGPROC_DefineControl DirRequest
!insertmacro DLGPROC_DefineControl ComboBox
!insertmacro DLGPROC_DefineControl DropList
!insertmacro DLGPROC_DefineControl ListBox
!insertmacro DLGPROC_DefineControl ProgressBar

!macro ClassIsLinkPop
	!ifdef ClassIsLink
	  Exch $0
		DlgProc::SetLink $0 "" "" 96
		Exch $0
	!endif
	!insertmacro _DEFINE_POP ClassIsLink
!macroend

!macro ClassIsLinkPush
	!insertmacro _DEFINE_PUSH ClassIsLink
	!if ${_CLASS} = Link
	  !undef _CLASS
	  !define _CLASS Button
	  !define ClassIsLink
	!endif
!macroend

${define} CreateCtrlP `!insertmacro CreateCtrl_Pixels`
!macro CreateCtrl_Pixels _CLASS _STYLE _EXSTYLE _TEXT _LEFT _TOP _WIDTH _HEIGHT _HWNDDLG _CTLID
	!insertmacro ClassIsLinkPush
	System::Call 'User32::SendMessage(i$HWNDPARENT,i${WM_GETFONT},i0,i0)i.s'
	System::Call 'Kernel32::GetModuleHandle(i)i.s'    ;Windows 95/98
  System::Call 'User32::CreateWindowEx(i${_EXSTYLE},t"${_CLASS}",t"${t_TEXT}",i${_STYLE},i${_LEFT},i${_TOP},i${_WIDTH},i${_HEIGHT},i${_HWNDDLG},i${_CTLID},is,v)i.s'
  System::Call 'User32::SendMessage(iss,i${WM_SETFONT},is,i0)'
	!insertmacro ClassIsLinkPop
!macroend

!macro CreateDlgCtrlCall _CLASS _STYLE _EXSTYLE _TEXT _LEFT _TOP _WIDTH _HEIGHT _HWNDDLG _CTLID
	!insertmacro ClassIsLinkPush
	System::Call '*(i${_EXSTYLE},t"${_CLASS}",t"${_TEXT}",i${_STYLE},i${_HWNDDLG},i${_CTLID},i${_LEFT},i${_TOP},i${_WIDTH},i${_HEIGHT})i.s'
	${CallArtificialFunction} CreateDlgCtrl_
	!insertmacro ClassIsLinkPop
!macroend

${define} CreateDlgCtrl `!insertmacro CreateDlgCtrlCall`

!macro CreateDlgCtrl_
	Exch $0
	Push $1
	IntOp $1 $0 + 24
	System::Call 'User32::SendMessage(i$HWNDPARENT,i${WM_GETFONT},i0,i0)i.s'
	System::Call 'Kernel32::GetModuleHandle(i)i.s'
	System::Call '*$0(i,t,t,i,i.s,i.s)'
	System::Call 'User32::MapDialogRect(iss,ir1)'
	System::Call '*$0(i.s,t.s,t.s,i.s,i,i,i.s,i.s,i.s,i.s)'
	System::Free $0
  System::Call 'User32::CreateWindowEx(is,ts,ts,is,is,is,is,is,is,is,is,v)i.s'
  System::Call 'User32::SendMessage(isr0,i${WM_SETFONT},is,i0)'
  Pop $1
  Exch $0
!macroend

!macro GetWindowPosCall HWND
  Push ${HWND}
  ${CallArtificialFunction} GetWindowPos_
!macroend

!macro GetDlgItemPosCall HWNDDLG CTLID
  System::Call User32::GetDlgItem(i${HWNDDLG},i${CTLID})i.s
	${CallArtificialFunction} GetWindowPos_
!macroend

!macro GetWindowPos_
  System::Store "s r0"
  System::Call User32::GetParent(ir0)i.s
  System::Alloc 16
  System::Call User32::GetClientRect(ir0s,isr0)
  System::Call "*$0(i, i, i.r3, i.r4)"
  System::Call User32::MapWindowPoints(is,is,ir0,i2)
  System::Call "*$0(i.r1, i.r2)"
  System::Free $0
  System::Store "p4p3p2p1 l"
!macroend

${define} GetWindowPos `!insertmacro GetWindowPos`
!macro GetWindowPos HWND OUT_LEFT OUT_TOP OUT_WIDTH OUT_HEIGHT
  !insertmacro GetWindowPosCall ${HWND}
  Pop ${OUT_LEFT}
  Pop ${OUT_TOP}
  Pop ${OUT_WIDTH}
  Pop ${OUT_HEIGHT}
!macroend

${define} GetDlgItemPos `!insertmacro GetDlgItemPos`
!macro GetDlgItemPos OUT_LEFT OUT_TOP OUT_WIDTH OUT_HEIGHT HWNDDLG CTLID
  !insertmacro GetDlgItemPosCall ${HWNDDLG} ${CTLID}
  Pop ${OUT_LEFT}
  Pop ${OUT_TOP}
  Pop ${OUT_WIDTH}
  Pop ${OUT_HEIGHT}
!macroend

${define} SetDlgProc `!insertmacro SetDlgProc`
!macro SetDlgProc hWnd CallbackFunc
  Push $0
  GetFunctionAddress $0 ${CallbackFunc}
  Exch $0
  DlgProc::onCallback ${hWnd}
!macroend

!verbose pop
!endif
