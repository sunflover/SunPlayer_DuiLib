/*
<超级按钮&链接&菜单的函数库 - ButtonLinkerLib.nsh>
Copyright (C) 2004 - 2006 by bluenet
Copyright (C) 2008 zhfi
*****************************************************************************************
*****************************************************************************************
*/


!ifndef BLLIB_FUNC
	!define BLLIB_FUNC `超级按钮&链接&菜单的函数头文件库`

!verbose push
!verbose 3
!include "LogicLib.nsh"

!ifdef define
	!undef define
!endif


!define define `!insertmacro FORCE_DEFINE_BLLIB`
!macro FORCE_DEFINE_BLLIB SYMBOL CONTENT
	!ifdef `${SYMBOL}`
		!undef `${SYMBOL}`
	!endif
	!define `${SYMBOL}` `${CONTENT}`
!macroend

!ifdef undef
	!undef undef
!endif

!define undef `!insertmacro UNDEF_IF_DEF_BLLIB`
!macro UNDEF_IF_DEF_BLLIB SYMBOL
	!ifdef `${SYMBOL}`
		!undef `${SYMBOL}`
	!endif
!macroend

!ifdef <定义>
!endif 

# begin of define
##############################
# 控件定义，用于获取控件位置 #
##############################

;/*
; * Dialog Box Command IDs
; */
!ifndef IDC_NEXT
!define IDC_NEXT                        1
!endif
!ifndef IDC_CANCEL
!define IDC_CANCEL                      2
!endif
!ifndef IDC_BACK
!define IDC_BACK                        3
!endif

;*********************************************
;WinGDI.h
;**********************************************

; Font Weights
${define} FW_DONTCARE         0
${define} FW_THIN             100
${define} FW_EXTRALIGHT       200
${define} FW_LIGHT            300
${define} FW_NORMAL           400
${define} FW_MEDIUM           500
${define} FW_SEMIBOLD         600
${define} FW_BOLD             700
${define} FW_EXTRABOLD        800
${define} FW_HEAVY            900

${define} FW_ULTRALIGHT       ${FW_EXTRALIGHT}
${define} FW_REGULAR          ${FW_NORMAL}
${define} FW_DEMIBOLD         ${FW_SEMIBOLD}
${define} FW_ULTRABOLD        ${FW_EXTRABOLD}
${define} FW_BLACK            ${FW_HEAVY}

;/*
; * Menu flags for Add/Check/EnableMenuItem()
; */
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

#if(WINVER >= 0x0400)
${define} MF_DEFAULT          0x00001000
#endif /* WINVER >= 0x0400 */
${define} MF_SYSMENU          0x00002000
${define} MF_HELP             0x00004000
#if(WINVER >= 0x0400)
${define} MF_RIGHTJUSTIFY     0x00004000
#endif /* WINVER >= 0x0400 */

${define} MF_MOUSESELECT      0x00008000
#if(WINVER >= 0x0400)
${define} MF_END              0x00000080  ;/* Obsolete -- only used by old RES files */
#endif /* WINVER >= 0x0400 */


#if(WINVER >= 0x0400)
${define} MFT_STRING          MF_STRING
${define} MFT_BITMAP          MF_BITMAP
${define} MFT_MENUBARBREAK    MF_MENUBARBREAK
${define} MFT_MENUBREAK       MF_MENUBREAK
${define} MFT_OWNERDRAW       MF_OWNERDRAW
${define} MFT_RADIOCHECK      0x00000200L
${define} MFT_SEPARATOR       MF_SEPARATOR
${define} MFT_RIGHTORDER      0x00002000L
${define} MFT_RIGHTJUSTIFY    MF_RIGHTJUSTIFY

/* Menu flags for Add/Check/EnableMenuItem() */
${define} MFS_GRAYED          0x00000003L
${define} MFS_DISABLED        MFS_GRAYED
${define} MFS_CHECKED         MF_CHECKED
${define} MFS_HILITE          MF_HILITE
${define} MFS_ENABLED         MF_ENABLED
${define} MFS_UNCHECKED       MF_UNCHECKED
${define} MFS_UNHILITE        MF_UNHILITE
${define} MFS_DEFAULT         MF_DEFAULT
#endif /* WINVER >= 0x0400 */

;*********************************************
;WinUser.h
;**********************************************

;/*
; * User Button Notification Codes
; */
${define} BN_CLICKED          0
${define} BN_PAINT            1
${define} BN_HILITE           2
${define} BN_UNHILITE         3
${define} BN_DISABLE          4
${define} BN_DOUBLECLICKED    5
#if(WINVER >= 0x0400)
${define} BN_PUSHED           ${BN_HILITE}
${define} BN_UNPUSHED         ${BN_UNHILITE}
${define} BN_DBLCLK           ${BN_DOUBLECLICKED}
${define} BN_SETFOCUS         6
${define} BN_KILLFOCUS        7
#endif /* WINVER >= 0x0400 */

;/*
; * Button Control Messages
; */
${define} BM_GETCHECK        0x00F0
${define} BM_SETCHECK        0x00F1
${define} BM_GETSTATE        0x00F2
${define} BM_SETSTATE        0x00F3
${define} BM_SETSTYLE        0x00F4
#if(WINVER >= 0x0400)
${define} BM_CLICK           0x00F5
${define} BM_GETIMAGE        0x00F6
${define} BM_SETIMAGE        0x00F7

${define} BST_UNCHECKED      0x0000
${define} BST_CHECKED        0x0001
${define} BST_INDETERMINATE  0x0002
${define} BST_PUSHED         0x0004
${define} BST_FOCUS          0x0008
#endif /* WINVER >= 0x0400 */

;*********************************************
;System.dll Function modules
;**********************************************

!ifdef <System.dll模块>
!endif


!macro DEFINE_FUNC_BLLIB NAME
	${define} `${NAME}` `!insertmacro INSERT_FUNC_${NAME} "${NAME}" ""`
	${define} `un.${NAME}` `!insertmacro INSERT_FUNC_${NAME} "${NAME}" un.`
!macroend

!macro DEFINE_CALL_BLLIB NAME UNFIX
	!undef `${UNFIX}${NAME}`
	!define `${UNFIX}${NAME}` `!insertmacro CALL_FUNC_${NAME} "${NAME}" "${UNFIX}"`
!macroend

!macro DEFINE_FUNC_BLLIB_LITE NAME
	${define} `${NAME}` `!insertmacro INSERT_FUNC_BLLIB_LITE_${NAME}`
!macroend

!ifdef <Macro>
!endif

!ifdef "<Window/Control Functions>"
!endif

###############################################################
# 函数: GetDlgItemText
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE GetDlgItemText

!macro INSERT_FUNC_BLLIB_LITE_GetDlgItemText OUT HWNDDLG CTLID
	System::Call "User32::GetDlgItemTextA(i, i, t, i) i (${HWNDDLG}, ${CTLID}, .s, ${NSIS_MAX_STRLEN})"
	Pop ${OUT}
!macroend

###############################################################
# 函数: SetDlgItemText
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE SetDlgItemText

!macro INSERT_FUNC_BLLIB_LITE_SetDlgItemText HWNDDLG CTLID TEXT
	Push `${TEXT}`
	System::Call "User32::SetDlgItemTextA(i, i, t) i (${HWNDDLG}, ${CTLID}, s)"
!macroend

###############################################################
# 函数: GetDlgCtrlID
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE GetDlgCtrlID

!macro INSERT_FUNC_BLLIB_LITE_GetDlgCtrlID OUT HWNDCTL
	System::Call "User32::GetDlgCtrlID(i) i (${HWNDCTL}) .s"
	Pop ${OUT}
!macroend

###############################################################
# 函数: GetDlgItemRect
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE GetDlgItemRect

!macro INSERT_FUNC_BLLIB_LITE_GetDlgItemRect OUT_LEFT OUT_TOP OUT_RIGHT OUT_BOTTOM HWNDDLG CTLID
    Push ${CTLID}
    Push ${HWNDDLG}
    Exch $R0 ;HWND
    Exch
    Exch $R1 ;control ID
    Push $R2

	GetDlgItem $R1 $R0 $R1
	System::Call /NOUNLOAD "*(i, i, i, i) i.s"
	Pop $R2
	System::Call /NOUNLOAD 'User32::GetWindowRect(i, i) i (R1, R2)'
	System::Call /NOUNLOAD 'User32::ScreenToClient(i, i) i (R0, R2)'
	IntOp $R1 $R2 + 8 ;sizeof(LPPOINT)*2 = 8
	System::Call /NOUNLOAD 'User32::ScreenToClient(i, i) i (R0, R1)'
	Exch 2
	Pop $R0
	Pop $R1
	System::Call /NOUNLOAD "*$R2(i .s, i .s, i .s, i .s)"
	System::Free $R2
	Exch 4
	Pop $R2

	Pop ${OUT_TOP}
	Pop ${OUT_RIGHT}
	Pop ${OUT_BOTTOM}
	Pop ${OUT_LEFT}
!macroend

###############################################################
# 函数: CreateLabel
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE CreateLabel

!macro INSERT_FUNC_BLLIB_LITE_CreateLabel TITLE LEFT TOP WIDTH HEIGHT HWNDPARENT CTLID
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    Push `${TITLE}`
	;Style = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS
	System::Call 'User32::CreateWindowEx(i,t,t,i,i,i,i,i,i,i,i,v) i (0,"STATIC",s,0x54000000,${LEFT},${TOP},${WIDTH},${HEIGHT},${HWNDPARENT},${CTLID},s,0) .s'
	Exch $R0
    Push $R1
	CreateFont $R1 $(^Font) $(^FontSize) ${FW_NORMAL}
	SendMessage $R0 ${WM_SETFONT} $R1 0
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: CreateButton
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE CreateButton

!macro INSERT_FUNC_BLLIB_LITE_CreateButton TITLE LEFT TOP WIDTH HEIGHT HWNDPARENT CTLID FUNADD
!ifdef NSIS_SUPPORT_CREATEBUTTON
	CreateButton ${TEXT} ${LEFT} ${TOP} ${WIDTH} ${HEIGHT} ${HWNDPARENT} ${CTLID} ${FUNADD}
!endif
!ifndef NSIS_SUPPORT_CREATEBUTTON
!echo '警告: 您所用的NSIS不支持创建超级按钮，请使用函数"CreateButton2"与插件"ButtonLinker.dll"来实现'
!endif
!macroend

###############################################################
# 函数: CreateLinker
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE CreateLinker

!macro INSERT_FUNC_BLLIB_LITE_CreateLinker TEXT LEFT TOP WIDTH HEIGHT HWNDPARENT TARGET LINKADD
!ifdef NSIS_SUPPORT_CREATELINKER
	CreateLinker ${TEXT} ${LEFT} ${TOP} ${WIDTH} ${HEIGHT} ${HWNDPARENT} ${CTLID} ${LINKADD}
!endif
!ifndef NSIS_SUPPORT_CREATELINKER
!echo '警告: 您所用的 NSIS 不支持创建超级链接，请使用函数"CreateLinker2"与插件"ButtonLinker.dll"来实现'
!endif
!macroend

###############################################################
# 函数: CreateMenu
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE CreateMenu

!macro INSERT_FUNC_BLLIB_LITE_CreateMenu LPNEWITEM UFLAGS HWNDDLG UIDNEWITEM MenuADD MenuIndex
!ifdef NSIS_SUPPORT_CREATEMenu
	CreateMenu ${LPNEWITEM} ${UFLAGS} ${HWNDDLG} ${UIDNEWITEM} ${MenuADD} ${MenuIndex}
!endif
!ifndef NSIS_SUPPORT_CREATEMenu
!echo '警告: 您所用的 NSIS 不支持创建超级菜单，请使用函数"CreateMenu2"与插件"ButtonLinker.dll"来实现'
!endif
!macroend

###############################################################
# 函数: CreateCheckbox
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE CreateCheckbox

!macro INSERT_FUNC_BLLIB_LITE_CreateCheckbox TITLE LEFT TOP WIDTH HEIGHT HWNDPARENT CTLID
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    Push `${TITLE}`
	;Style = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_TABSTOP | BS_TEXT | BS_VCENTER | BS_AUTOCHECKBOX | BS_MULTILINE
	System::Call 'User32::CreateWindowEx(i,t,t,i,i,i,i,i,i,i,i,v) i (0,"BUTTON",s,0x54012C03,${LEFT},${TOP},${WIDTH},${HEIGHT},${HWNDPARENT},${CTLID},s,0) .s'
	Exch $R0
	Push $R1
	CreateFont $R1 $(^Font) $(^FontSize) ${FW_NORMAL}
	SendMessage $R0 ${WM_SETFONT} $R1 0
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: CreateCheckbox2
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE CreateCheckbox2

!macro INSERT_FUNC_BLLIB_LITE_CreateCheckbox2 TITLE LEFT TOP WIDTH HEIGHT HWNDPARENT CTLID STATE
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    Push `${TITLE}`
	;Style = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_TABSTOP | BS_TEXT | BS_VCENTER | BS_AUTOCHECKBOX | BS_MULTILINE
	System::Call 'User32::CreateWindowEx(i,t,t,i,i,i,i,i,i,i,i,v) i (0,"BUTTON",s,0x54012C03,${LEFT},${TOP},${WIDTH},${HEIGHT},${HWNDPARENT},${CTLID},s,0) .s'
	Exch $R0
	Push $R1
	CreateFont $R1 $(^Font) $(^FontSize) ${FW_NORMAL}
	SendMessage $R0 ${WM_SETFONT} $R1 0
	SendMessage $R0 ${BM_SETCHECK} ${STATE} 0
;	SendMessage $R0 ${BM_SETSTATE} ${STATE} 0
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: CreateCheckbox3
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE CreateCheckbox3

!macro INSERT_FUNC_BLLIB_LITE_CreateCheckbox3 TITLE LEFT TOP WIDTH HEIGHT HWNDPARENT CTLID STATE CHECKADD
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    Push `${TITLE}`
	;Style = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_TABSTOP | BS_TEXT | BS_VCENTER | BS_AUTOCHECKBOX | BS_MULTILINE
	System::Call 'User32::CreateWindowEx(i,t,t,i,i,i,i,i,i,i,i,v) i (0,"BUTTON",s,0x54012C03,${LEFT},${TOP},${WIDTH},${HEIGHT},${HWNDPARENT},${CTLID},s,0) .s'
	Exch $R0
	Push $R1
	CreateFont $R1 $(^Font) $(^FontSize) ${FW_NORMAL}
	SendMessage $R0 ${WM_SETFONT} $R1 0
	SendMessage $R0 ${BM_SETCHECK} ${STATE} 0
;	SendMessage $R0 ${BM_SETSTATE} ${STATE} 0
	GetFunctionAddress $R2 ${CHECKADD}
	ButtonLinker::AddEventHandler /NOUNLOAD ${CTLID} $R2
	Pop $R2
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: GetBoxState
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE GetBoxState

!macro INSERT_FUNC_BLLIB_LITE_GetBoxState OUT HWNDDLG CTLID
  GetDlgItem $R0 ${HWNDDLG} ${CTLID}
	SendMessage $R0 ${BM_GETSTATE} 0 0 ${OUT}
	Pop $R0
StrCpy ${OUT} ${OUT} "" -1
${if} ${OUT} != 0
${andif} ${OUT} != 1
  StrCpy ${OUT} "error"
${endif}
	Pop ${OUT}
!macroend

###############################################################
# 函数: SetBoxState
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE SetBoxState

!macro INSERT_FUNC_BLLIB_LITE_SetBoxState STATE HWNDDLG CTLID
  GetDlgItem $R0 ${HWNDDLG} ${CTLID}
	SendMessage $R0 ${BM_SETCHECK} ${STATE} 0
	SendMessage $R0 ${BM_SETSTATE} ${STATE} 0
	Pop $R0
!macroend

###############################################################
# 函数: CreateButton2
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE CreateButton2

!macro INSERT_FUNC_BLLIB_LITE_CreateButton2 TEXT LEFT TOP WIDTH HEIGHT HWNDPARENT CTLID ButtonADD
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    Push `${TEXT}`
	;Style = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_TABSTOP
	System::Call 'User32::CreateWindowEx(i,t,t,i,i,i,i,i,i,i,i,v) i (0,"BUTTON",s,0x54010000,${LEFT},${TOP},${WIDTH},${HEIGHT},${HWNDPARENT},${CTLID},s,0) .s'
	Exch $R0
	Push $R1
	CreateFont $R1 $(^Font) $(^FontSize) ${FW_NORMAL}
	SendMessage $R0 ${WM_SETFONT} $R1 0

	GetFunctionAddress $R2 ${ButtonADD}
	ButtonLinker::AddEventHandler /NOUNLOAD ${CTLID} $R2
	Pop $R2
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: CreateLinker2
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE CreateLinker2

!macro INSERT_FUNC_BLLIB_LITE_CreateLinker2 TEXT LEFT TOP WIDTH HEIGHT HWNDPARENT CTLID LINKADD
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    Push `${TEXT}`
	;Style = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS
	System::Call 'User32::CreateWindowEx(i,t,t,i,i,i,i,i,i,i,i,v) i (0,"STATIC",s,0x54000000,${LEFT},${TOP},${WIDTH},${HEIGHT},${HWNDPARENT},${CTLID},s,0) .s'
	Exch $R0
    Push $R1
	CreateFont $R1 $(^Font) $(^FontSize) ${FW_NORMAL}
	SendMessage $R0 ${WM_SETFONT} $R1 0

	GetDlgItem $R2 $HWNDPARENT ${CTLID}
	ButtonLinker::CreateLinker /NOUNLOAD $R2 ${LINKADD}
	Pop $R2
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: CreateMenu2
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE CreateMenu2

!macro INSERT_FUNC_BLLIB_LITE_CreateMenu2 LPNEWITEM UFLAGS HWNDDLG UIDNEWITEM MenuADD
	System::Call 'User32::GetSystemMenu(i, i) i (${HWNDDLG}, 0) .s'
	Pop $R0
	Push `${LPNEWITEM}`
	System::Call 'User32::AppendMenu(i, i, i, t) i ($R0, ${UFLAGS}, ${UIDNEWITEM}, s)'
	GetFunctionAddress $R1 ${MenuADD}
  ButtonLinker::AddEventHandler /NOUNLOAD ${UIDNEWITEM} $R1
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: GetSystemMenu
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE GetSystemMenu

!macro INSERT_FUNC_BLLIB_LITE_GetSystemMenu OUTPUT HWNDDLG
	System::Call 'User32::GetSystemMenu(i, i) i (${HWNDDLG}, 0) .s'
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: AppendMenu
###############################################################
!insertmacro DEFINE_FUNC_BLLIB_LITE AppendMenu

!macro INSERT_FUNC_BLLIB_LITE_AppendMenu HMENU UFLAGS UIDNEWITEM LPNEWITEM
	Push `${LPNEWITEM}`
	System::Call 'User32::AppendMenu(i, i, i, t) i (${HMENU}, ${UFLAGS}, ${UIDNEWITEM}, s)'
!macroend

!verbose pop
!endif ;end of USEFULLLIB define

