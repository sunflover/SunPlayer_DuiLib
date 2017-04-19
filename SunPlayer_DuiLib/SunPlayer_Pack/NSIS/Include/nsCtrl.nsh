/********************************************************************************

		< 头文件: nsCtrl.nsh >

		Copyright (C) 2011 by gfm688
		
说明：
1. 要创建的控件的父窗口句柄必须保存在$0
2. 控件创建或被修改后, 控件句柄保存在$1

*********************************************************************************/

!ifndef NSCTRL_INCLUDED
!define NSCTRL_INCLUDED
!verbose push
!verbose 3
!include Util.nsh
!include nsDialogs.nsh

!macro NSCTRL_DEFINE SYMBOL CONTENT
	!ifndef ${SYMBOL}
	  !define ${SYMBOL} `${CONTENT}`
	!endif
!macroend
!insertmacro NSCTRL_DEFINE define "!insertmacro NSCTRL_DEFINE"

; Dialog Box Command IDs
${define} IDOK											1
${define} IDCANCEL									2
${define} IDABORT             			3
${define} IDRETRY             			4
${define} IDIGNORE            			5
${define} IDYES               			6
${define} IDNO                			7
${define} IDC_STATIC    					 -1
${define} IDC_NEXT                	1
${define} IDC_CANCEL              	2
${define} IDC_BACK                	3
${define} IDD_LICENSE               102
${define} IDD_LICENSE_FSRB          108
${define} IDD_LICENSE_FSCB          109
${define} IDI_ICON2                 103
${define} IDD_DIR                   103
${define} IDD_SELCOM                104
${define} IDD_INST                  105
${define} IDD_INSTFILES             106
${define} IDD_UNINST                107
${define} IDD_VERIFY                111
${define} IDB_BITMAP1             	110
${define} IDC_EDIT1                 1000
${define} IDC_BROWSE                1001
${define} IDC_PROGRESS              1004
${define} IDC_INTROTEXT             1006
${define} IDC_CHECK1                1008
${define} IDC_LIST1                 1016
${define} IDC_COMBO1                1017
${define} IDC_CHILDRECT             1018
${define} IDC_DIR                   1019
${define} IDC_SELDIRTEXT           	1020
${define} IDC_TEXT1                 1021
${define} IDC_TEXT2                 1022
${define} IDC_SPACEREQUIRED         1023
${define} IDC_SPACEAVAILABLE        1024
${define} IDC_SHOWDETAILS           1027
${define} IDC_VERSTR                1028
${define} IDC_UNINSTFROM            1029
${define} IDC_STR                   1030
${define} IDC_ULICON                1031
${define} IDC_TREE1                 1032
${define} IDC_BRANDIMAGE            1033
${define} IDC_LICENSEAGREE          1034
${define} IDC_LICENSEDISAGREE       1035

; Menu flags for Add/Check/EnableMenuItem()
${define} MF_INSERT           0x00000000
${define} MF_CHANGE           0x00000080
${define} MF_APPEND           0x00000100
${define} MF_DELETE           0x00000200
${define} MF_REMOVE           0x00001000
${define} MF_BYCOMMAND        0x00000000
${define} MF_BYPOSITION       0x00000400
${define} MF_SEPARATOR        0x00000800
${define} MF_ENABLED          0x00000000
${define} MF_GRAYED           0x00000001
${define} MF_DISABLED         0x00000002
${define} MF_UNCHECKED        0x00000000
${define} MF_CHECKED          0x00000008
${define} MF_USECHECKBITMAPS  0x00000200
${define} MF_STRING           0x00000000
${define} MF_BITMAP           0x00000004
${define} MF_OWNERDRAW        0x00000100
${define} MF_POPUP            0x00000010
${define} MF_MENUBARBREAK     0x00000020
${define} MF_MENUBREAK        0x00000040
${define} MF_UNHILITE         0x00000000
${define} MF_HILITE           0x00000080
${define} MF_DEFAULT          0x00001000
${define} MF_SYSMENU          0x00002000
${define} MF_HELP             0x00004000
${define} MF_RIGHTJUSTIFY     0x00004000
${define} MF_MOUSESELECT      0x00008000

!define LM_SETHOVERPARAM  		0x04F0  ; nsLink窗口类自定义消息

!define ConvertPlacement `!insertmacro ConvertPlacementCall`
!macro ConvertPlacementCall _PLACE _ISYH _OUTPUT
	!verbose push
	!verbose 3
	Push ${_ISYH}
	Push ${_PLACE}
	${CallArtificialFunction2} ConvertPlacement_
	Pop ${_OUTPUT}
	!verbose pop
!macroend

!macro ConvertPlacement_
	Exch $0
	Exch
	Exch $1
	Push $2
	StrCpy $2 $0 "" -1
	StrCmp $2 "u" 0 __End
	StrCpy $0 $0 -1
	System::Call '*(ir0, ir0, i0, i0)i.r2'
  System::Call 'User32::MapDialogRect(i$HWNDPARENT,ir2)'
  ${If} $1 = 1
  	System::Call '*$2(i, i.r0)'
  ${Else}
  	System::Call '*$2(i.r0)'
  ${EndIf}
	System::Free $2
__End:
	Pop $2
	Pop $1
	Exch $0
!macroend

!define CreateControl `!insertmacro CreateControlCall`
!macro CreateControlCall _CLASS _STYLE _EXSTYLE _LEFT _TOP _WIDTH _HEIGHT _TEXT _CTLID
	!verbose push
	!verbose 3
	!if ${_CLASS} == LINK
	  !undef _CLASS
	  !define _CLASS nsLink
	!endif
	StrCpy $1 `${_EXSTYLE},$\`${_CLASS}$\`,$\`${_TEXT}$\`,${_STYLE},$\`${_LEFT}$\`,$\`${_TOP}$\`,$\`${_WIDTH}$\`,$\`${_HEIGHT}$\`,${_CTLID}`
  ${CallArtificialFunction} CreateControl_
  !verbose pop
!macroend

!macro CreateControl_
  Push $2
  Push $3
  Push $4
  Push $5
  System::Call 'User32::SendMessage(i$HWNDPARENT,i${WM_GETFONT},i0,i0)i.s'
  System::Call 'Kernel32::GetModuleHandle(i)i.s'
  System::Call '*(i,&t32,&t260,i,&t10,&t10,&t10,&t10,i)i($1).r1'
	System::Call '*$1(i.s,&t32.s,&t260.s,i.s,&t10.r2,&t10.r3,&t10.r4,&t10.r5,i.s)'
	System::Free $1
	${ConvertPlacement} $2 0 $2
	${ConvertPlacement} $3 1 $3
	${ConvertPlacement} $4 0 $4
	${ConvertPlacement} $5 1 $5
  System::Call 'User32::CreateWindowEx(is,ts,ts,is,ir2,ir3,ir4,ir5,ir0,is,is,i)i.r1'
  System::Call 'User32::SendMessage(ir1,i${WM_SETFONT},is,i0)'
	Pop $5
	Pop $4
	Pop $3
	Pop $2
!macroend

!macro DefineControl NAME
	!ifdef Create${NAME}
		!undef Create${NAME}
	!endif
	!define Create${NAME} "${CreateControl} ${__NSD_${NAME}_CLASS} ${__NSD_${NAME}_STYLE} ${__NSD_${NAME}_EXSTYLE}"
!macroend

!insertmacro DefineControl HLine
!insertmacro DefineControl VLine
!insertmacro DefineControl Label
!insertmacro DefineControl Icon
!insertmacro DefineControl Bitmap
!insertmacro DefineControl BrowseButton
!insertmacro DefineControl Link
!insertmacro DefineControl Button
!insertmacro DefineControl GroupBox
!insertmacro DefineControl CheckBox
!insertmacro DefineControl RadioButton
!insertmacro DefineControl Text
!insertmacro DefineControl Password
!insertmacro DefineControl Number
!insertmacro DefineControl FileRequest
!insertmacro DefineControl DirRequest
!insertmacro DefineControl ComboBox
!insertmacro DefineControl DropList
!insertmacro DefineControl ListBox
!insertmacro DefineControl ProgressBar

!define DestroyControl `!insertmacro DestroyControl`
!macro DestroyControl HWND
	SendMessage ${HWND} ${WM_CLOSE} 0 0
!macroend

!define MoveDlgItem `!insertmacro MoveDlgItemCall`
!macro MoveDlgItemCall _HWNDDLG _CTLID _RECT
	!verbose push
	!verbose 3
	GetDlgItem $1 ${_HWNDDLG} ${_CTLID}
	Push "${_RECT}"
	${CallArtificialFunction} MoveDlgItem_
	!verbose pop
!macroend

!macro MoveDlgItem_
	Exch $2
	System::Call '*(i, i, i, i) i ($2).r2'
  System::Call 'User32::MapDialogRect(i$HWNDPARENT,ir2)'
	System::Call '*$2(i.s, i.s, i.s, i.s)'
	System::Free $2
	System::Call 'User32::MoveWindow(ir1,is,is,is,is,i1)'
	Pop $2
!macroend

!define ShowDlgItem `!insertmacro ShowDlgItem`
!macro ShowDlgItem _HWNDDLG _CTLID _STATE
	GetDlgItem $1 ${_HWNDDLG} ${_CTLID}
	ShowWindow $1 ${_STATE}
!macroend

!verbose pop
!endif
