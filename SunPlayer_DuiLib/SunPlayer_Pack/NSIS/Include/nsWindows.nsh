/*

nsWindows.nsh
Header file for creating custom installer pages with nsWindows

*/
!ifndef NSWINDOWS_INCLUDED
  !define NSWINDOWS_INCLUDED
!verbose push
!verbose 3

!include nsDialogs.nsh
!include Colors.nsh

!ifndef MF_BYPOSITION
  !define MF_BYPOSITION   0x400
!endif

!define AW_HOR_POSITIVE             0x00000001
!define AW_HOR_NEGATIVE             0x00000002
!define AW_VER_POSITIVE             0x00000004
!define AW_VER_NEGATIVE             0x00000008
!define AW_CENTER                   0x00000010
!define AW_HIDE                     0x00010000
!define AW_ACTIVATE                 0x00020000
!define AW_SLIDE                    0x00040000
!define AW_BLEND                    0x00080000

!define BS_GROUP 0x20000
;hWndInsertAfter:
!define HWND_TOP        0
!define HWND_BOTTOM     1
!define HWND_TOPMOST    -1
!define HWND_NOTOPMOST  -2

;uFlags :
!define SWP_NOSIZE          0x0001
!define SWP_NOMOVE          0x0002
!define SWP_NOZORDER        0x0004
!define SWP_NOREDRAW        0x0008
!define SWP_NOACTIVATE      0x0010
!define SWP_FRAMECHANGED    0x0020  /* The frame changed: send WM_NCCALCSIZE */
!define SWP_SHOWWINDOW      0x0040
!define SWP_HIDEWINDOW      0x0080
!define SWP_NOCOPYBITS      0x0100
!define SWP_NOOWNERZORDER   0x0200  /* Don't do owner Z ordering */
!define SWP_NOSENDCHANGING  0x0400  /* Don't send WM_WINDOWPOSCHANGING */

!define SWP_DRAWFRAME       ${SWP_FRAMECHANGED}
!define SWP_NOREPOSITION    ${SWP_NOOWNERZORDER}

!define SWP_DEFERERASE      0x2000
!define SWP_ASYNCWINDOWPOS  0x4000

/*
 * Window sTYLES
 */
;dwStyle:
!define WS_OVERLAPPED       0x00000000
!define WS_POPUP            0x80000000
!define WS_CAPTION          0x00C00000     /* WS_BORDER | WS_DLGFRAME  */
!define WS_MINIMIZE         0x20000000
;!define WS_VISIBLE          0x10000000
;!define WS_DISABLED         0x08000000
;!define WS_CLIPSIBLINGS     0x04000000
;!define WS_CLIPCHILDREN     0x02000000
;!define WS_MAXIMIZE         0x01000000
;!define WS_CHILD            0x40000000
!define WS_BORDER           0x00800000
!define WS_DLGFRAME         0x00400000
;!define WS_VSCROLL          0x00200000
;!define WS_HSCROLL          0x00100000
!define WS_SYSMENU          0x00080000
!define WS_THICKFRAME       0x00040000
;!define WS_GROUP            0x00020000
;!define WS_TABSTOP          0x00010000
!define WS_MINIMIZEBOX      0x00020000
!define WS_MAXIMIZEBOX      0x00010000
!define WS_TILED            ${WS_OVERLAPPED}
!define WS_ICONIC           ${WS_MINIMIZE}
!define WS_SIZEBOX          ${WS_THICKFRAME}
!define WS_TILEDWINDOW      ${WS_OVERLAPPEDWINDOW}


/*
 * Common Window Styles
 */
!define LWA_ALPHA 2

!define WS_OVERLAPPEDWINDOW ${WS_OVERLAPPED}|${WS_CAPTION}|${WS_SYSMENU}|${WS_THICKFRAME}|${WS_MINIMIZEBOX}|${WS_MAXIMIZEBOX}
!define WS_POPUPWINDOW      ${WS_POPUP}|${WS_BORDER}|${WS_SYSMENU}
!define WS_CHILDWINDOW      ${WS_CHILD}

!define WS_EX_OVERLAPPEDWINDOW  ${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE}
!define WS_EX_PALETTEWINDOW     ${WS_EX_WINDOWEDGE}|${WS_EX_TOOLWINDOW}|${WS_EX_TOPMOST}

; /* WINVER >= 0x0400 */

;(_WIN32_WINNT >= 0x0500)
!define WS_EX_LAYERED           0x00080000
!define WS_EX_NOINHERITLAYOUT   0x00100000 ; Disable inheritence of mirroring by children
!define WS_EX_LAYOUTRTL         0x00400000 ; Right to left mirroring


; /* WINVER >= 0x0500 */

;(_WIN32_WINNT >= 0x0501)
!define WS_EX_COMPOSITED        0x02000000
; /* _WIN32_WINNT >= 0x0501 */
;(_WIN32_WINNT >= 0x0500)
!define WS_EX_NOACTIVATE        0x08000000
; /* _WIN32_WINNT >= 0x0500 */

!define __NSW_HLine_CLASS STATIC
!define __NSW_HLine_STYLE ${DEFAULT_STYLES}|${SS_ETCHEDHORZ}|${SS_SUNKEN}
!define __NSW_HLine_EXSTYLE ${WS_EX_TRANSPARENT}

!define __NSW_VLine_CLASS STATIC
!define __NSW_VLine_STYLE ${DEFAULT_STYLES}|${SS_ETCHEDVERT}|${SS_SUNKEN}
!define __NSW_VLine_EXSTYLE ${WS_EX_TRANSPARENT}

!define __NSW_Label_CLASS STATIC
!define __NSW_Label_STYLE ${DEFAULT_STYLES}|${SS_NOTIFY}
!define __NSW_Label_EXSTYLE ${WS_EX_TRANSPARENT}

!define __NSW_Icon_CLASS STATIC
!define __NSW_Icon_STYLE ${DEFAULT_STYLES}|${SS_ICON}|${SS_NOTIFY}
!define __NSW_Icon_EXSTYLE 0

!define __NSW_Bitmap_CLASS STATIC
!define __NSW_Bitmap_STYLE ${DEFAULT_STYLES}|${SS_BITMAP}|${SS_NOTIFY}
!define __NSW_Bitmap_EXSTYLE 0

!define __NSW_BrowseButton_CLASS BUTTON
!define __NSW_BrowseButton_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}
!define __NSW_BrowseButton_EXSTYLE 0

!define __NSW_Link_CLASS LINK
!define __NSW_Link_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}|${BS_OWNERDRAW}
!define __NSW_Link_EXSTYLE 0

!define __NSW_Button_CLASS BUTTON
!define __NSW_Button_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}
!define __NSW_Button_EXSTYLE 0

!define __NSW_GroupBox_CLASS BUTTON
!define __NSW_GroupBox_STYLE ${DEFAULT_STYLES}|${BS_GROUPBOX}
!define __NSW_GroupBox_EXSTYLE ${WS_EX_TRANSPARENT}

!define __NSW_CheckBox_CLASS BUTTON
!define __NSW_CheckBox_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}|${BS_TEXT}|${BS_VCENTER}|${BS_AUTOCHECKBOX}|${BS_MULTILINE}
!define __NSW_CheckBox_EXSTYLE 0

!define __NSW_RadioButton_CLASS BUTTON
!define __NSW_RadioButton_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}|${BS_TEXT}|${BS_VCENTER}|${BS_AUTORADIOBUTTON}|${BS_MULTILINE}
!define __NSW_RadioButton_EXSTYLE 0

!define __NSW_RadioButtonGroup_CLASS BUTTON
!define __NSW_RadioButtonGroup_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}|${BS_TEXT}|${BS_VCENTER}|${BS_AUTORADIOBUTTON}|${BS_MULTILINE}|${BS_GROUP}
!define __NSW_RadioButtonGroup_EXSTYLE 0

!define __NSW_Text_CLASS EDIT
!define __NSW_Text_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}|${ES_AUTOHSCROLL}
!define __NSW_Text_EXSTYLE ${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE}

!define __NSW_ReadText_CLASS EDIT
!define __NSW_ReadText_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}|${ES_AUTOHSCROLL}|${ES_READONLY}
!define __NSW_ReadText_EXSTYLE ${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE}

!define __NSW_Memo_CLASS EDIT
!define __NSW_Memo_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}|${ES_AUTOVSCROLL}|${ES_MULTILINE}|${ES_WANTRETURN}|${WS_VSCROLL}
!define __NSW_Memo_EXSTYLE ${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE}

!define __NSW_Password_CLASS EDIT
!define __NSW_Password_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}|${ES_AUTOHSCROLL}|${ES_PASSWORD}
!define __NSW_Password_EXSTYLE ${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE}

!define __NSW_Number_CLASS EDIT
!define __NSW_Number_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}|${ES_AUTOHSCROLL}|${ES_NUMBER}
!define __NSW_Number_EXSTYLE ${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE}

!define __NSW_FileRequest_CLASS EDIT
!define __NSW_FileRequest_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}|${ES_AUTOHSCROLL}
!define __NSW_FileRequest_EXSTYLE ${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE}

!define __NSW_DirRequest_CLASS EDIT
!define __NSW_DirRequest_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}|${ES_AUTOHSCROLL}
!define __NSW_DirRequest_EXSTYLE ${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE}

!define __NSW_ComboBox_CLASS COMBOBOX
!define __NSW_ComboBox_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}|${WS_VSCROLL}|${WS_CLIPCHILDREN}|${CBS_AUTOHSCROLL}|${CBS_HASSTRINGS}|${CBS_DROPDOWN}
!define __NSW_ComboBox_EXSTYLE ${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE}

!define __NSW_DropList_CLASS COMBOBOX
!define __NSW_DropList_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}|${WS_VSCROLL}|${WS_CLIPCHILDREN}|${CBS_AUTOHSCROLL}|${CBS_HASSTRINGS}|${CBS_DROPDOWNLIST}
!define __NSW_DropList_EXSTYLE ${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE}

!define __NSW_ListBox_CLASS LISTBOX
!define __NSW_ListBox_STYLE ${DEFAULT_STYLES}|${WS_TABSTOP}|${WS_VSCROLL}|${LBS_DISABLENOSCROLL}|${LBS_HASSTRINGS}|${LBS_NOINTEGRALHEIGHT}|${LBS_NOTIFY}
!define __NSW_ListBox_EXSTYLE ${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE}

!define __NSW_ProgressBar_CLASS msctls_progress32
!define __NSW_ProgressBar_STYLE ${DEFAULT_STYLES}
!define __NSW_ProgressBar_EXSTYLE ${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE}

!macro _NSW_CenterWindow HWND HWPARENT

;  ${nsWindows}::CenterWindow ${HWND} ${HWPARENT}

  Push $R0
	System::Call /NOUNLOAD "*(i, i, i, i) i.s"
	Pop $R0
  ;Get placement
	System::Call /NOUNLOAD 'User32::GetWindowRect(i, i) i (${HWND}, R0)'
	System::Call /NOUNLOAD "*$R0(i .s, i .s, i .s, i .s)"

	Pop $0 ;left
	Pop $1 ;top
	Pop $2 ;right
	Pop $3 ;bottom
	
  IntOp $R1 $2 - $0 ;width
  IntOp $R2 $3 - $1 ;height

;Messagebox mb_ok "$$0:$0 $$1:$1 $$2:$2 $$3:$3"

  ;Get Parent's placement
	System::Call /NOUNLOAD 'User32::GetWindowRect(i, i) i (${HWPARENT}, R0)'
	System::Call /NOUNLOAD "*$R0(i .s, i .s, i .s, i .s)"
	System::Free $R0

	Pop $0 ;parentleft
	Pop $1 ;parenttop
	Pop $2 ;parentright
	Pop $3 ;parentbottom

;Messagebox mb_ok "$$0:$0 $$1:$1 $$2:$2 $$3:$3"

  IntOp $R3 $2 - $0 ;parentwidth
  IntOp $R4 $3 - $1 ;parentheight
  
  IntOp $R3 $R3 - $R1 ;width difference
  IntOp $R3 $R3 / 2 ;width difference / 2
  
  IntOp $R4 $R4 - $R2 ;height difference
  IntOp $R4 $R4 / 2 ;height difference / 2

  IntOp $R3 $0 + $R3 ;x /new
  IntOp $R4 $1 + $R4 ;y /new
  
  ;${NSW_SetWindowPos} ${HWND} $R3 $R4
	System::Call user32::SetWindowPos(i${HWND},i0,i$R3,i$R4,i0,i0,i${SWP_NOSIZE})
	Pop $R0
;Messagebox mb_ok "$$R3:$R3 $$R4:$R4"
!macroend

!define NSW_CenterWindow `!insertmacro _NSW_CenterWindow`

;add by zhfi
!ifndef dwExStyle
  !define dwExStyle ${WS_EX_WINDOWEDGE}
!endif
!ifndef dwStyle
  !define dwStyle ${WS_VISIBLE}|${WS_SYSMENU}|${WS_CAPTION}
!endif

var insWindows
var hnsWindows

!macro _NSW_Init
  !ifndef nsWindows
    !define nsWindows nsWindows
  !endif

  ${nsWindows}::Create $HWNDPARENT ${dwExStyle} ${dwStyle}
    Pop $R0
;    MessageBox MB_OK ${nsWindows}
    ${NSW_CloseWindow} $R0
!macroend

!define NSW_Init `!insertmacro _NSW_Init`

!macro _NSW_CreateWindow OUTVAR TITLE INTERVAL
  IsWindow ${OUTVAR} 0 +3
    ShowWindow ${OUTVAR} ${SW_SHOW}
    Abort
  !ifdef insWindows
    !undef insWindows
  !endif
  !ifdef nsWindows
    !undef nsWindows
  !endif
  IsWindow $hnsWindows 0 +2
    IntOp $insWindows $insWindows + 1
  !define insWindows $insWindows
  !define nsWindows nsWindows${insWindows}
  ;
  !echo "Generating nsWindows temp plugins..."
  !ifndef nsWindows_warning
    !warning "Note: nsWindows.dll must be put in NSIS's Plugins Directory!"
    !define nsWindows_warning
  !endif
    !ifdef nsWindows_produce
      !undef nsWindows_produce
    !endif
    !define nsWindows_produce
/*    !define nsWindows_produce "${NSISDIR}\Plugins\nsWindows_produce.bat"
    !appendfile "${nsWindows_produce}" '@echo off$\n'
    !appendfile "${nsWindows_produce}" 'del /q "${NSISDIR}\Plugins\nsWindows.tmp\nsWindows*.dll"$\n'
    !appendfile "${nsWindows_produce}" 'md "${NSISDIR}\Plugins\nsWindows.tmp\"$\n'
    !appendfile "${nsWindows_produce}" 'copy /B /-Y "${NSISDIR}\Plugins\nsWindows.dll" "${NSISDIR}\Plugins\nsWindows.tmp\${nsWindows}.dll"$\n'
    !appendfile "${nsWindows_produce}" 'exit$\n'
    !execute "${nsWindows_produce}"
    !delfile "${nsWindows_produce}"*/
	!system 'del /q "${NSISDIR}\Plugins\nsWindows.tmp\nsWindows*.dll"'   
	!system 'md "${NSISDIR}\Plugins\nsWindows.tmp\"'   
	!system 'copy /B /-Y "${NSISDIR}\Plugins\nsWindows.dll" "${NSISDIR}\Plugins\nsWindows.tmp\${nsWindows}.dll"'   
    !undef nsWindows_produce
  !echo "Generating finished!"
  ;
  !AddPluginDir "${NSISDIR}\Plugins\nsWindows.tmp\"
  ReserveFile "${NSISDIR}\Plugins\nsWindows.tmp\${nsWindows}.dll"

  ${nsWindows}::Create $HWNDPARENT ${dwExStyle} ${dwStyle} "${TITLE}" ${INTERVAL}
	Pop ${OUTVAR}
	StrCpy $hnsWindows ${OUTVAR}
  ShowWindow ${OUTVAR} ${SW_HIDE}
;
  System::Call "User32::GetSystemMenu(i ${OUTVAR}, i 0) i.s"
  Pop $R0
;  MessageBOx mb_ok  $R0
  System::Call "User32::DeleteMenu(i $R0, i 5, i ${MF_BYPOSITION}) .s"
  System::Call "User32::DeleteMenu(i $R0, i 4, i ${MF_BYPOSITION}) .s"
  System::Call "User32::DeleteMenu(i $R0, i 3, i ${MF_BYPOSITION}) .s"
  System::Call "User32::DeleteMenu(i $R0, i 2, i ${MF_BYPOSITION}) .s"
  System::Call "User32::DeleteMenu(i $R0, i 0, i ${MF_BYPOSITION}) .s"
!macroend

!define NSW_CreateWindow `!insertmacro _NSW_CreateWindow`

!macro _NSW_CreateWindowEx OUTVAR HWND ExStyle Style TITLE INTERVAL
  IsWindow ${OUTVAR} 0 +3
    ShowWindow ${OUTVAR} ${SW_SHOW}
    Abort
  !ifdef insWindows
    !undef insWindows
  !endif
  !ifdef nsWindows
    !undef nsWindows
  !endif
  IsWindow $hnsWindows 0 +2
    IntOp $insWindows $insWindows + 1
  !define insWindows $insWindows
  !define nsWindows nsWindows${insWindows}
  ;
  !echo "Generating nsWindows temp plugins..."
  !ifndef nsWindows_warning
    !warning "Note: nsWindows.dll must be put in NSIS's Plugins Directory!"
    !define nsWindows_warning
  !endif
    !ifdef nsWindows_produce
      !undef nsWindows_produce
    !endif
    !define nsWindows_produce
/*    !define nsWindows_produce "${NSISDIR}\Plugins\nsWindows_produce.bat"
    !appendfile "${nsWindows_produce}" '@echo off$\n'
    !appendfile "${nsWindows_produce}" 'del /q "${NSISDIR}\Plugins\nsWindows.tmp\nsWindows*.dll"$\n'
    !appendfile "${nsWindows_produce}" 'md "${NSISDIR}\Plugins\nsWindows.tmp\"$\n'
    !appendfile "${nsWindows_produce}" 'copy /B /-Y "${NSISDIR}\Plugins\nsWindows.dll" "${NSISDIR}\Plugins\nsWindows.tmp\${nsWindows}.dll"$\n'
    !appendfile "${nsWindows_produce}" 'exit$\n'
    !execute "${nsWindows_produce}"
    !delfile "${nsWindows_produce}"*/
	!system 'del /q "${NSISDIR}\Plugins\nsWindows.tmp\nsWindows*.dll"'   
	!system 'md "${NSISDIR}\Plugins\nsWindows.tmp\"'   
	!system 'copy /B /-Y "${NSISDIR}\Plugins\nsWindows.dll" "${NSISDIR}\Plugins\nsWindows.tmp\${nsWindows}.dll"'   
    !undef nsWindows_produce
  !echo "Generating finished!"
  ;
  !AddPluginDir "${NSISDIR}\Plugins\nsWindows.tmp\"
  ReserveFile "${NSISDIR}\Plugins\nsWindows.tmp\${nsWindows}.dll"

  ${nsWindows}::Create ${HWND} ${ExStyle} ${Style} "${TITLE}" ${INTERVAL}
	Pop ${OUTVAR}
	StrCpy $hnsWindows ${OUTVAR}
  ShowWindow ${OUTVAR} ${SW_HIDE}
!macroend

!define NSW_CreateWindowEx `!insertmacro _NSW_CreateWindowEx`

!macro _NSW_MessageBeep uType
  System::Call `User32::MessageBeep(i ${uType})`
!macroend

!define NSW_MessageBeep `!insertmacro _NSW_MessageBeep`

!macro _NSW_Show

  ${nsWindows}::Show
;  IsWindow $hnsWindows 0 +2
;    IntOp $insWindows $insWindows + 1
  !echo "Clearing nsWindows temp plugins..."
    !ifdef nsWindows_clear
      !undef nsWindows_clear
    !endif
    !define nsWindows_clear "${NSISDIR}\Plugins\nsWindows_clear.bat"
    /*!appendfile "${nsWindows_clear}" '@echo off$\n'
    !appendfile "${nsWindows_clear}" 'del /q "${NSISDIR}\Plugins\nsWindows.tmp\nsWindows*.dll"$\n'
    !appendfile "${nsWindows_clear}" 'rd /q "${NSISDIR}\Plugins\nsWindows.tmp\"$\n'
    !appendfile "${nsWindows_clear}" 'exit$\n'
    !execute "${nsWindows_clear}"
    !delfile "${nsWindows_clear}"*/
	!system 'del /q "${NSISDIR}\Plugins\nsWindows.tmp\nsWindows*.dll"'   
	!system 'rd /q "${NSISDIR}\Plugins\nsWindows.tmp\"'   
    !undef nsWindows_clear
  !echo "Clearing finished!"
!macroend

!define NSW_Show `!insertmacro _NSW_Show`

!macro __NSW_DefineControl NAME

	!define NSW_Create${NAME} "${nsWindows}::CreateControl ${__NSW_${Name}_CLASS} ${__NSW_${Name}_STYLE} ${__NSW_${Name}_EXSTYLE}"

!macroend

!insertmacro __NSW_DefineControl HLine
!insertmacro __NSW_DefineControl VLine
!insertmacro __NSW_DefineControl Label
!insertmacro __NSW_DefineControl Icon
!insertmacro __NSW_DefineControl Bitmap
!insertmacro __NSW_DefineControl BrowseButton
!insertmacro __NSW_DefineControl Link
!insertmacro __NSW_DefineControl Button
!insertmacro __NSW_DefineControl GroupBox
!insertmacro __NSW_DefineControl CheckBox
!insertmacro __NSW_DefineControl RadioButton
!insertmacro __NSW_DefineControl RadioButtonGroup
!insertmacro __NSW_DefineControl Text
!insertmacro __NSW_DefineControl ReadText
!insertmacro __NSW_DefineControl Memo
!insertmacro __NSW_DefineControl Password
!insertmacro __NSW_DefineControl Number
!insertmacro __NSW_DefineControl FileRequest
!insertmacro __NSW_DefineControl DirRequest
!insertmacro __NSW_DefineControl ComboBox
!insertmacro __NSW_DefineControl DropList
!insertmacro __NSW_DefineControl ListBox
!insertmacro __NSW_DefineControl ProgressBar

!macro __NSW_OnControlEvent EVENT HWND FUNCTION

	Push $0
	Push $1

	StrCpy $1 "${HWND}"

	GetFunctionAddress $0 "${FUNCTION}"
	${nsWindows}::On${EVENT} $1 $0

	Pop $1
	Pop $0

!macroend

!macro __NSW_DefineControlCallback EVENT

	!define NSW_On${EVENT} `!insertmacro __NSW_OnControlEvent ${EVENT}`

!macroend

!macro __NSW_OnDialogEvent EVENT FUNCTION

	Push $0

	GetFunctionAddress $0 "${FUNCTION}"
	${nsWindows}::On${EVENT} $0

	Pop $0

!macroend

!macro __NSW_DefineDialogCallback EVENT

	!define NSW_On${EVENT} `!insertmacro __NSW_OnDialogEvent ${EVENT}`

!macroend

!insertmacro __NSW_DefineControlCallback Click
!insertmacro __NSW_DefineControlCallback Change
!insertmacro __NSW_DefineControlCallback Notify
!insertmacro __NSW_DefineControlCallback DropFiles
!insertmacro __NSW_DefineDialogCallback Back

!macro _NSW_CreateTimer FUNCTION INTERVAL

	Push $0

	GetFunctionAddress $0 "${FUNCTION}"
	${nsWindows}::CreateTimer $0 "${INTERVAL}"

	Pop $0

!macroend

!define NSW_CreateTimer `!insertmacro _NSW_CreateTimer`

!macro _NSW_KillTimer FUNCTION

	Push $0

	GetFunctionAddress $0 "${FUNCTION}"
	${nsWindows}::KillTimer $0

	Pop $0

!macroend

!define NSW_KillTimer `!insertmacro _NSW_KillTimer`

!macro _NSW_AddStyle CONTROL STYLE

	Push $0

	System::Call "user32::GetWindowLong(i ${CONTROL}, i ${GWL_STYLE}) i .r0"
	System::Call "user32::SetWindowLong(i ${CONTROL}, i ${GWL_STYLE}, i $0|${STYLE})"

	Pop $0

!macroend

!define NSW_AddStyle "!insertmacro _NSW_AddStyle"

!macro _NSW_AddExStyle CONTROL EXSTYLE

	Push $0

	System::Call "user32::GetWindowLong(i ${CONTROL}, i ${GWL_EXSTYLE}) i .r0"
	System::Call "user32::SetWindowLong(i ${CONTROL}, i ${GWL_EXSTYLE}, i $0|${EXSTYLE})"

	Pop $0

!macroend

!define NSW_AddExStyle "!insertmacro _NSW_AddExStyle"

!macro __NSW_GetText CONTROL VAR

	System::Call user32::GetWindowText(i${CONTROL},t.s,i${NSIS_MAX_STRLEN})
	Pop ${VAR}

!macroend

!define NSW_GetText `!insertmacro __NSW_GetText`

!macro __NSW_SetWindowSize CONTROL Width Height

	System::Call user32::SetWindowPos(i${CONTROL},i0,i0,i0,i${Width},i${Height},i${SWP_NOMOVE})

!macroend

!define NSW_SetWindowSize `!insertmacro __NSW_SetWindowSize`

!macro __NSW_SetWindowPos CONTROL Left Top

	System::Call user32::SetWindowPos(i${CONTROL},i0,i${Left},i${Top},i0,i0,i${SWP_NOSIZE})

!macroend

!define NSW_SetWindowPos `!insertmacro __NSW_SetWindowPos`

!macro __NSW_SetWindowPosEx CONTROL hWndInsertAfter Left Top Width Height uFlags

	System::Call user32::SetWindowPos(i${CONTROL},i${hWndInsertAfter},i${Left},i${Top},i${Width},i${Height},i${uFlags})

!macroend

!define NSW_SetWindowPosEx `!insertmacro __NSW_SetWindowPosEx`

!macro _NSW_SetTransparent HWND PERCENT

;  ${nsWindows}::SetTransparent ${HWND} ${PERCENT}
Push $R2
Push $R1
  IntOp $R1 ${PERCENT} * 255
  IntOp $R1 $R1 / 100
  ${NSW_AddExStyle} ${HWND} ${WS_EX_LAYERED}
  system::call 'user32::SetLayeredWindowAttributes(i ${HWND}, i 0, i $R1, i ${LWA_ALPHA}) .iR2'
Pop $R2
Pop $R1

!macroend

!define NSW_SetTransparent `!insertmacro _NSW_SetTransparent`

!macro _NSW_AnimateWindow HWND TIMEOUT FLAGS

;	System::Call user32::SetWindowPos(i${HWND},i${HWND_TOPMOST},i0,i0,i0,i0,i${SWP_NOMOVE}|${SWP_NOSIZE})
	System::Call user32::AnimateWindow(i${HWND},i${TIMEOUT},i${FLAGS})

!macroend

!define NSW_AnimateWindow `!insertmacro _NSW_AnimateWindow`

!macro __NSW_SetParent CONTROL PARENT

	System::Call user32::SetParent(i${CONTROL},i${PARENT})

!macroend

!define NSW_SetParent `!insertmacro __NSW_SetParent`

!macro __NSW_DestroyWindow CONTROL

	System::Call user32::DestroyWindow(i${CONTROL})

!macroend

!define NSW_DestroyWindow `!insertmacro __NSW_DestroyWindow`
!define NSW_CloseWindow `!insertmacro __NSW_DestroyWindow`

!macro __NSW_MinimizeWindow CONTROL

  ShowWindow ${CONTROL} ${SW_MINIMIZE}
;	System::Call user32::CloseWindow(i${CONTROL})

!macroend

!define NSW_MinimizeWindow `!insertmacro __NSW_MinimizeWindow`


!macro __NSW_MaximizeWindow CONTROL

  ShowWindow ${CONTROL} ${SW_MAXIMIZE}

!macroend

!define NSW_MaximizeWindow `!insertmacro __NSW_MaximizeWindow`

!macro __NSW_RestoreWindow CONTROL

  ShowWindow ${CONTROL} ${SW_NORMAL}
;	System::Call user32::OpenIcon(i${CONTROL})

!macroend

!define NSW_RestoreWindow `!insertmacro __NSW_RestoreWindow`

!macro __NSW_SetCtlText HWND FileName
/*;用法：
;${NSW_SetCtlText} 控件句柄 文本文件名称
;此宏改自Restools的SetText函数
;链接：http://restools.hanzify.org/article.asp?id=29*/
# 如果你对程序设计不熟悉，那么你可以不用理解这个过程，把它复制到你的脚本中就可以了。
;  Exch $R0 ;${HWND}控件句柄
;  Exch
;  Exch $R1 ;${FileName}文件
  StrCpy $R0 ${HWND}
  StrCpy $R1 "${FileName}"

  Push $R2
  Push $R3
  Push $R4
  Push $R5

  ClearErrors
  FileOpen $R2 $R1 r ;$R2 = 文件句柄
  ${Unless} ${Errors} ;确保打开文件没有发生错误
    System::Call /NOUNLOAD "Kernel32::GetFileSize(i, i) i (R2, 0) .R3" ;$R3 = 文件大小
    IntOp $R3 $R3 + 1
    System::Alloc /NOUNLOAD $R3 ;分配内存
    Pop $R4 ;内存地址
      ${If} $R4 U> 0 ;确保分配了内存
          System::Call /NOUNLOAD "*(i 0) i .R5"
          System::Call /NOUNLOAD `Kernel32::ReadFile(i, i, i, i, i) i (R2, R4R4, R3, R5R5, 0)`
          System::Call /NOUNLOAD "*$R5(i .R1)"
          ${If} $R1 > 0
            System::Call /NOUNLOAD "User32::SendMessage(i, i, i, i) i (R0, ${WM_SETTEXT}, 0, R4)"
          ${EndIf}
          System::Free /NOUNLOAD $R5
        System::Free $R4 ;释放内存
    ${EndIf}
    FileClose $R2
  ${EndUnless}

  Pop $R5
  Pop $R4
  Pop $R3
  Pop $R2
  Pop $R1
  Pop $R0
!macroend

!define NSW_SetCtlText `!insertmacro __NSW_SetCtlText`

!macro __NSW_SetText CONTROL TEXT

	SendMessage ${CONTROL} ${WM_SETTEXT} 0 `STR:${TEXT}`

!macroend

!define NSW_SetText `!insertmacro __NSW_SetText`

!macro _NSW_SetTextLimit CONTROL LIMIT

	SendMessage ${CONTROL} ${EM_SETLIMITTEXT} ${LIMIT} 0

!macroend

!define NSW_SetTextLimit "!insertmacro _NSW_SetTextLimit"

!macro __NSW_GetState CONTROL VAR

	SendMessage ${CONTROL} ${BM_GETCHECK} 0 0 ${VAR}

!macroend

!define NSW_GetState `!insertmacro __NSW_GetState`

!macro __NSW_SetState CONTROL STATE

	SendMessage ${CONTROL} ${BM_SETCHECK} ${STATE} 0

!macroend

!define NSW_SetState `!insertmacro __NSW_SetState`

!macro __NSW_Check CONTROL

	${NSW_SetState} ${CONTROL} ${BST_CHECKED}

!macroend

!define NSW_Check `!insertmacro __NSW_Check`

!macro __NSW_Uncheck CONTROL

	${NSW_SetState} ${CONTROL} ${BST_UNCHECKED}

!macroend

!define NSW_Uncheck `!insertmacro __NSW_Uncheck`

!macro __NSW_SetFocus HWND

	System::Call "user32::SetFocus(i${HWND})"

!macroend

!define NSW_SetFocus `!insertmacro __NSW_SetFocus`

!macro _NSW_CB_AddString CONTROL STRING

	SendMessage ${CONTROL} ${CB_ADDSTRING} 0 `STR:${STRING}`

!macroend

!define NSW_CB_AddString "!insertmacro _NSW_CB_AddString"

!macro _NSW_CB_SelectString CONTROL STRING

	SendMessage ${CONTROL} ${CB_SELECTSTRING} -1 `STR:${STRING}`

!macroend

!define NSW_CB_SelectString "!insertmacro _NSW_CB_SelectString"

!macro __NSW_CB_GetSelection CONTROL VAR

	SendMessage ${CONTROL} ${CB_GETCURSEL} 0 0 ${VAR}
	System::Call 'user32::SendMessage(i ${CONTROL}, i ${CB_GETLBTEXT}, i ${VAR}, t .s)'
	Pop ${VAR}

!macroend

!define NSW_CB_GetSelection `!insertmacro __NSW_CB_GetSelection`

!macro __NSW_CB_GetCurIndex CONTROL VAR

	SendMessage ${CONTROL} ${CB_GETCURSEL} 0 0 ${VAR}

!macroend

!define NSW_CB_GetCurIndex `!insertmacro __NSW_CB_GetCurIndex`

!macro __NSW_CB_SetCurIndex CONTROL INDEX

	SendMessage ${CONTROL} ${CB_SETCURSEL} ${INDEX} 0

!macroend

!define NSW_CB_SetCurIndex `!insertmacro __NSW_CB_SetCurIndex`

!macro _NSW_LB_AddString CONTROL STRING

	SendMessage ${CONTROL} ${LB_ADDSTRING} 0 `STR:${STRING}`

!macroend

!define NSW_LB_AddString "!insertmacro _NSW_LB_AddString"

!macro __NSW_LB_DelString CONTROL STRING

	SendMessage ${CONTROL} ${LB_DELETESTRING} 0 `STR:${STRING}`

!macroend

!define NSW_LB_DelString `!insertmacro __NSW_LB_DelString`

!macro __NSW_LB_Clear CONTROL VAR

	SendMessage ${CONTROL} ${LB_RESETCONTENT} 0 0 ${VAR}

!macroend

!define NSW_LB_Clear `!insertmacro __NSW_LB_Clear`

!macro __NSW_LB_GetCount CONTROL VAR

	SendMessage ${CONTROL} ${LB_GETCOUNT} 0 0 ${VAR}

!macroend

!define NSW_LB_GetCount `!insertmacro __NSW_LB_GetCount`

!macro _NSW_LB_SelectString CONTROL STRING

	SendMessage ${CONTROL} ${LB_SELECTSTRING} -1 `STR:${STRING}`

!macroend

!define NSW_LB_SelectString "!insertmacro _NSW_LB_SelectString"

!macro __NSW_LB_GetSelection CONTROL VAR

	SendMessage ${CONTROL} ${LB_GETCURSEL} 0 0 ${VAR}
	System::Call 'user32::SendMessage(i ${CONTROL}, i ${LB_GETTEXT}, i ${VAR}, t .s)'
	Pop ${VAR}

!macroend

!define NSW_LB_GetSelection `!insertmacro __NSW_LB_GetSelection`


!macro __NSW_LoadAndSetImage _LIHINSTMODE _IMGTYPE _LIHINSTSRC _LIFLAGS CONTROL IMAGE HANDLE
	
	Push $0
	Push $R0

	StrCpy $R0 ${CONTROL} # in case ${CONTROL} is $0
	
	!if "${_LIHINSTMODE}" == "exeresource"
		System::Call 'kernel32::GetModuleHandle(i0) i.r0'
		!undef _LIHINSTSRC
		!define _LIHINSTSRC r0
	!endif
	
	System::Call 'user32::LoadImage(i ${_LIHINSTSRC}, ts, i ${_IMGTYPE}, i0, i0, i${_LIFLAGS}) i.r0' "${IMAGE}"
	SendMessage $R0 ${STM_SETIMAGE} ${_IMGTYPE} $0

	Pop $R0
	Exch $0

	Pop ${HANDLE}

!macroend

!macro __NSW_SetIconFromExeResource CONTROL IMAGE HANDLE
	!insertmacro __NSW_LoadAndSetImage exeresource ${IMAGE_ICON} 0 ${LR_DEFAULTSIZE} "${CONTROL}" "${IMAGE}" ${HANDLE}
!macroend

!macro __NSW_SetIconFromInstaller CONTROL HANDLE
	!insertmacro __NSW_SetIconFromExeResource "${CONTROL}" "#103" ${HANDLE}
!macroend

!define NSW_SetImage `!insertmacro __NSW_LoadAndSetImage file ${IMAGE_BITMAP} 0 "${LR_LOADFROMFILE}"`
!define NSW_SetBitmap `${NSW_SetImage}`

!ifndef IID_IPicture
  !define IID_IPicture {7BF80980-BF32-101A-8BBB-00AA00300CAB}
!endif
!macro __NSW_LoadAndSetJpg _LIHINSTMODE _IMGTYPE _LIHINSTSRC _LIFLAGS CONTROL IMAGE HANDLE

;var /GLOBAL pIPicture1 ;lets save it in a var so some other code does not overwrite it (I'm assuming you have a complicated page with lots of code)
	Push $0
	Push $1
  System::Call 'oleaut32::OleLoadPicturePath(w "${IMAGE}", i 0, i 0, i 0, g "${IID_IPicture}", *i .r0)i.r1'
  ${If} $1 == 0
  	StrCpy ${HANDLE} $0 ;save pointer for later, we can't release it now because the image handle needs to stay valid
  	System::Call "$0->3(*i.r0)i.r1" ;IPicture->get_Handle
  	;might want to check $1 here before setting image
  	SendMessage ${CONTROL} ${STM_SETIMAGE} ${IMAGE_BITMAP} $0
  ${Else}
  	StrCpy ${HANDLE} "error"
  ${EndIf}

	Pop $0
	Pop $1
/*	Push $0
	Push $R0

	StrCpy $R0 ${CONTROL} # in case ${CONTROL} is $0

	!if "${_LIHINSTMODE}" == "exeresource"
		System::Call 'kernel32::GetModuleHandle(i0) i.r0'
		!undef _LIHINSTSRC
		!define _LIHINSTSRC r0
	!endif

	System::Call 'user32::LoadImage(i ${_LIHINSTSRC}, ts, i ${_IMGTYPE}, i0, i0, i${_LIFLAGS}) i.r0' "${IMAGE}"
	SendMessage $R0 ${STM_SETIMAGE} ${_IMGTYPE} $0

	Pop $R0
	Exch $0

	Pop ${HANDLE}
*/
!macroend

!define NSW_SetJpg `!insertmacro __NSW_LoadAndSetJpg file ${IMAGE_BITMAP} 0 "${LR_LOADFROMFILE}"`

!macro __NSW_LoadJpg CONTROL IMAGE HANDLE

;var /GLOBAL pIPicture1 ;lets save it in a var so some other code does not overwrite it (I'm assuming you have a complicated page with lots of code)
	Push $0
	Push $1
  System::Call 'oleaut32::OleLoadPicturePath(w "${IMAGE}", i 0, i 0, i 0, g "${IID_IPicture}", *i .r0)i.r1'
  ${If} $1 == 0
  	System::Call "$0->3(*i.r0)i.r1" ;IPicture->get_Handle
  	StrCpy ${HANDLE} $0 ;save pointer for later, we can't release it now because the image handle needs to stay valid
  	;might want to check $1 here before setting image
;  	SendMessage ${CONTROL} ${STM_SETIMAGE} ${IMAGE_BITMAP} $0
  ${Else}
  	StrCpy ${HANDLE} "error"
  ${EndIf}

	Pop $0
	Pop $1
!macroend

!define NSW_LoadJpg `!insertmacro __NSW_LoadJpg `

!define NSW_SetIcon `!insertmacro __NSW_LoadAndSetImage file ${IMAGE_ICON} 0 "${LR_LOADFROMFILE}|${LR_DEFAULTSIZE}"`
!define NSW_SetIconFromExeResource `!insertmacro __NSW_SetIconFromExeResource`
!define NSW_SetIconFromInstaller `!insertmacro __NSW_SetIconFromInstaller`


!macro __NSW_SetStretchedImage CONTROL IMAGE HANDLE

	Push $0
	Push $1
	Push $2
	Push $R0

	StrCpy $R0 ${CONTROL} # in case ${CONTROL} is $0

	StrCpy $1 ""
	StrCpy $2 ""

	System::Call '*(i, i, i, i) i.s'
	Pop $0

	${If} $0 <> 0

		System::Call 'user32::GetClientRect(iR0, ir0)'
		System::Call '*$0(i, i, i .s, i .s)'
		System::Free $0
		Pop $1
		Pop $2

	${EndIf}

	System::Call 'user32::LoadImage(i0, ts, i ${IMAGE_BITMAP}, ir1, ir2, i${LR_LOADFROMFILE}) i.s' "${IMAGE}"
	Pop $0
    SendMessage $R0 ${STM_SETIMAGE} ${IMAGE_BITMAP} $0

	Pop $R0
	Pop $2
	Pop $1
	Exch $0

	Pop ${HANDLE}

!macroend

!define NSW_SetStretchedImage `!insertmacro __NSW_SetStretchedImage`

!macro __NSW_FreeImage IMAGE

	${If} ${IMAGE} <> 0

		System::Call gdi32::DeleteObject(is) ${IMAGE}

	${EndIf}

!macroend

!define NSW_FreeImage `!insertmacro __NSW_FreeImage`
!define NSW_FreeBitmap `${NSW_FreeImage}`

!macro __NSW_FreeIcon IMAGE
	System::Call user32::DestroyIcon(is) ${IMAGE}
!macroend

!define NSW_FreeIcon `!insertmacro __NSW_FreeIcon`

!macro __NSW_ClearImage _IMGTYPE CONTROL

	SendMessage ${CONTROL} ${STM_SETIMAGE} ${_IMGTYPE} 0

!macroend

!define NSW_ClearImage `!insertmacro __NSW_ClearImage ${IMAGE_BITMAP}`
!define NSW_ClearIcon  `!insertmacro __NSW_ClearImage ${IMAGE_ICON}`

!ifndef DEBUG
!define DEBUG `System::Call kernel32::OutputDebugString(ts)`
!endif

!macro __NSW_ControlCase TYPE

	${Case} ${TYPE}
		${NSW_Create${TYPE}} $R3u $R4u $R5u $R6u $R7
		Pop $R9
		${Break}

!macroend

!macro __NSW_ControlCaseEx TYPE

	${Case} ${TYPE}
		Call ${TYPE}
		${Break}

!macroend

!macro NSW_FUNCTION_INIFILE

	!insertmacro NSW_INIFILE ""

!macroend

!macro NSW_UNFUNCTION_INIFILE

	!insertmacro NSW_INIFILE un.

!macroend

!macro NSW_INIFILE UNINSTALLER_FUNCPREFIX

	;Functions to create dialogs based on old InstallOptions INI files

	Function ${UNINSTALLER_FUNCPREFIX}CreateWindowFromINI
  ;Window name
  Pop $R1
		# $0 = ini

		ReadINIStr $R0 $0 Settings RECT
		${If} $R0 == ""
			StrCpy $R0 1018
		${EndIf}
		
		Pop $R9
	  ${NSW_CreateWindow} $R9 $R1 $R0
;	${nsWindows}::Create $HWNDPARENT ${dwExStyle} ${dwStyle} $R1 $R0
;	${nsWindows}::Create $HWNDPARENT ${dwExStyle} ${dwStyle} $R1 $R0
;		${nsWindows}::Create $R0

		ReadINIStr $R0 $0 Settings RTL
		${nsWindows}::SetRTL $R0

		ReadINIStr $R0 $0 Settings NumFields

		${DEBUG} "NumFields = $R0"

		${For} $R1 1 $R0
			${DEBUG} "Creating field $R1"
			ReadINIStr $R2 $0 "Field $R1" Type
			${DEBUG} "  Type = $R2"
			ReadINIStr $R3 $0 "Field $R1" Left
			${DEBUG} "  Left = $R3"
			ReadINIStr $R4 $0 "Field $R1" Top
			${DEBUG} "  Top = $R4"
			ReadINIStr $R5 $0 "Field $R1" Right
			${DEBUG} "  Right = $R5"
			ReadINIStr $R6 $0 "Field $R1" Bottom
			${DEBUG} "  Bottom = $R6"
			IntOp $R5 $R5 - $R3
			${DEBUG} "  Width = $R5"
			IntOp $R6 $R6 - $R4
			${DEBUG} "  Height = $R6"
			ReadINIStr $R7 $0 "Field $R1" Text
			${DEBUG} "  Text = $R7"
			${Switch} $R2
				!insertmacro __NSW_ControlCase   HLine
				!insertmacro __NSW_ControlCase   VLine
				!insertmacro __NSW_ControlCase   Label
				!insertmacro __NSW_ControlCase   Icon
				!insertmacro __NSW_ControlCase   Bitmap
				!insertmacro __NSW_ControlCaseEx Link
				!insertmacro __NSW_ControlCase   Button
				!insertmacro __NSW_ControlCase   GroupBox
				!insertmacro __NSW_ControlCase   CheckBox
				!insertmacro __NSW_ControlCase   RadioButton
				!insertmacro __NSW_ControlCase   RadioButtonGroup
				!insertmacro __NSW_ControlCase   Text
				!insertmacro __NSW_ControlCase   Password
				!insertmacro __NSW_ControlCaseEx FileRequest
				!insertmacro __NSW_ControlCaseEx DirRequest
				!insertmacro __NSW_ControlCase   ComboBox
				!insertmacro __NSW_ControlCase   DropList
				!insertmacro __NSW_ControlCase   ListBox
			${EndSwitch}

			WriteINIStr $0 "Field $R1" HWND $R9
		${Next}

;		nsWindows::Show
  	${NSW_Show}

	FunctionEnd

	Function ${UNINSTALLER_FUNCPREFIX}UpdateINIState

		${DEBUG} "Updating INI state"

		ReadINIStr $R0 $0 Settings NumFields

		${DEBUG} "NumField = $R0"

		${For} $R1 1 $R0
			ReadINIStr $R2 $0 "Field $R1" HWND
			ReadINIStr $R3 $0 "Field $R1" "Type"
			${Switch} $R3
				${Case} "CheckBox"
				${Case} "RadioButton"
					${DEBUG} "  HWND = $R2"
					${NSW_GetState} $R2 $R2
					${DEBUG} "  Window selection = $R2"
				${Break}
				${CaseElse}
					${DEBUG} "  HWND = $R2"
					${NSW_GetText} $R2 $R2
					${DEBUG} "  Window text = $R2"
				${Break}
			${EndSwitch}
			WriteINIStr $0 "Field $R1" STATE $R2
		${Next}

	FunctionEnd

	Function ${UNINSTALLER_FUNCPREFIX}FileRequest

		IntOp $R5 $R5 - 15
		IntOp $R8 $R3 + $R5

		${NSW_CreateBrowseButton} $R8u $R4u 15u $R6u ...
		Pop $R8

		${nsWindows}::SetUserData $R8 $R1 # remember field id

		WriteINIStr $0 "Field $R1" HWND2 $R8

		${NSW_OnClick} $R8 ${UNINSTALLER_FUNCPREFIX}OnFileBrowseButton

		ReadINIStr $R9 $0 "Field $R1" State

		${NSW_CreateFileRequest} $R3u $R4u $R5u $R6u $R9
		Pop $R9

	FunctionEnd

	Function ${UNINSTALLER_FUNCPREFIX}DirRequest

		IntOp $R5 $R5 - 15
		IntOp $R8 $R3 + $R5

		${NSW_CreateBrowseButton} $R8u $R4u 15u $R6u ...
		Pop $R8

		${nsWindows}::SetUserData $R8 $R1 # remember field id

		WriteINIStr $0 "Field $R1" HWND2 $R8

		${NSW_OnClick} $R8 ${UNINSTALLER_FUNCPREFIX}OnDirBrowseButton

		ReadINIStr $R9 $0 "Field $R1" State

		${NSW_CreateFileRequest} $R3u $R4u $R5u $R6u $R9
		Pop $R9

	FunctionEnd

	Function ${UNINSTALLER_FUNCPREFIX}OnFileBrowseButton

		Pop $R0

		${nsWindows}::GetUserData $R0
		Pop $R1

		ReadINIStr $R2 $0 "Field $R1" HWND
		ReadINIStr $R4 $0 "Field $R1" Filter

		${NSW_GetText} $R2 $R3

		${nsWindows}::SelectFileDialog save $R3 $R4
		Pop $R3

		${If} $R3 != ""
			SendMessage $R2 ${WM_SETTEXT} 0 STR:$R3
		${EndIf}

	FunctionEnd

	Function ${UNINSTALLER_FUNCPREFIX}OnDirBrowseButton

		Pop $R0

		${nsWindows}::GetUserData $R0
		Pop $R1

		ReadINIStr $R2 $0 "Field $R1" HWND
		ReadINIStr $R3 $0 "Field $R1" Text

		${NSW_GetText} $R2 $R4

		${nsWindows}::SelectFolderDialog $R3 $R4
		Pop $R3

		${If} $R3 != error
			SendMessage $R2 ${WM_SETTEXT} 0 STR:$R3
		${EndIf}

	FunctionEnd

	Function ${UNINSTALLER_FUNCPREFIX}Link

		${NSW_CreateLink} $R3u $R4u $R5u $R6u $R7
		Pop $R9

		${nsWindows}::SetUserData $R9 $R1 # remember field id

		${NSW_OnClick} $R9 ${UNINSTALLER_FUNCPREFIX}OnLink

	FunctionEnd

	Function ${UNINSTALLER_FUNCPREFIX}OnLink

		Pop $R0

		${nsWindows}::GetUserData $R0
		Pop $R1

		ReadINIStr $R1 $0 "Field $R1" STATE

		ExecShell "" $R1

	FunctionEnd

!macroend

!verbose pop
!endif
