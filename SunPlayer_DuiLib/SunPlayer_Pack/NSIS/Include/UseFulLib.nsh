/*
Copyright (C) 2004 - 2006 by bluenet
*****************************************************************************************
*****************************************************************************************
*/


!ifndef USEFUL_FUNC
	!define USEFUL_FUNC `常用的函数头文件`

!verbose push
!verbose 3
!include "Sections.nsh"
!include "WinMessages.nsh"
!include "LogicLib.nsh"

!ifdef define
	!undef define
!endif

!define define `!insertmacro FORCE_DEFINE`
!macro FORCE_DEFINE SYMBOL CONTENT
	!ifdef `${SYMBOL}`
		!undef `${SYMBOL}`
	!endif
	!define `${SYMBOL}` `${CONTENT}`
!macroend

!ifdef undef
	!undef undef
!endif

!define undef `!insertmacro UNDEF_IF_DEF`
!macro UNDEF_IF_DEF SYMBOL
	!ifdef `${SYMBOL}`
		!undef `${SYMBOL}`
	!endif
!macroend

!ifdef <定义>
!endif 

# begin of define
###############
# 控件定义
###############

;/*
; * Dialog Box Command IDs
; */
${define} IDOK                1
${define} IDCANCEL            2
${define} IDABORT             3
${define} IDRETRY             4
${define} IDIGNORE            5
${define} IDYES               6
${define} IDNO                7
!define IDC_NEXT                        1
!define IDC_CANCEL                      2
!define IDC_BACK                        3
!define IDD_LICENSE                     102
!define IDD_LICENSE_FSRB                108
!define IDD_LICENSE_FSCB                109
!define IDI_ICON2                       103
!define IDD_DIR                         103
!define IDD_SELCOM                      104
!define IDD_INST                        105
!define IDD_INSTFILES                   106
!define IDD_UNINST                      107
!define IDD_VERIFY                      111
!define IDB_BITMAP1                     110
!define IDC_EDIT1                       1000
!define IDC_BROWSE                      1001
!define IDC_PROGRESS                    1004
!define IDC_INTROTEXT                   1006
!define IDC_CHECK1                      1008
!define IDC_LIST1                       1016
!define IDC_COMBO1                      1017
!define IDC_CHILDRECT                   1018
!define IDC_DIR                         1019
!define IDC_SELDIRTEXT                  1020
!define IDC_TEXT1                       1021
!define IDC_TEXT2                       1022
!define IDC_SPACEREQUIRED               1023
!define IDC_SPACEAVAILABLE              1024
!define IDC_SHOWDETAILS                 1027
!define IDC_VERSTR                      1028
!define IDC_UNINSTFROM                  1029
!define IDC_STR                         1030
!define IDC_ULICON                      1031
!define IDC_TREE1                       1032
!define IDC_BRANDIMAGE                  1033
!define IDC_LICENSEAGREE                1034
!define IDC_LICENSEDISAGREE             1035

;*********************************************
;WinBase.h
;**********************************************

${define} INVALID_FILE_SIZE 0xFFFFFFFF

;*********************************************
;WinDef.h
;**********************************************

${define} MAX_PATH            260

${define} FALSE               0
${define} TRUE                1

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

;/*
; * Edit Control Styles
; */
${define} ES_LEFT             0x0000
${define} ES_CENTER           0x0001
${define} ES_RIGHT            0x0002
${define} ES_MULTILINE        0x0004
${define} ES_UPPERCASE        0x0008
${define} ES_LOWERCASE        0x0010
${define} ES_PASSWORD         0x0020
${define} ES_AUTOVSCROLL      0x0040
${define} ES_AUTOHSCROLL      0x0080
${define} ES_NOHIDESEL        0x0100
${define} ES_OEMCONVERT       0x0400
${define} ES_READONLY         0x0800
${define} ES_WANTRETURN       0x1000
#if(WINVER >= 0x0400)
${define} ES_NUMBER           0x2000
#endif /* WINVER >= 0x0400 */

;/*
; * Edit Control Notification Codes
; */
${define} EN_SETFOCUS         0x0100
${define} EN_KILLFOCUS        0x0200
${define} EN_CHANGE           0x0300
${define} EN_UPDATE           0x0400
${define} EN_ERRSPACE         0x0500
${define} EN_MAXTEXT          0x0501
${define} EN_HSCROLL          0x0601
${define} EN_VSCROLL          0x0602
#if(_WIN32_WINNT >= 0x0500)
#define EN_ALIGN_LTR_EC     0x0700
#define EN_ALIGN_RTL_EC     0x0701
#endif /* _WIN32_WINNT >= 0x0500 */

;/*
; * Edit Control Messages
; */
${define} EM_GETSEL               0x00B0
${define} EM_SETSEL               0x00B1
${define} EM_GETRECT              0x00B2
${define} EM_SETRECT              0x00B3
${define} EM_SETRECTNP            0x00B4
${define} EM_SCROLL               0x00B5
${define} EM_LINESCROLL           0x00B6
${define} EM_SCROLLCARET          0x00B7
${define} EM_GETMODIFY            0x00B8
${define} EM_SETMODIFY            0x00B9
${define} EM_GETLINECOUNT         0x00BA
${define} EM_LINEINDEX            0x00BB
${define} EM_SETHANDLE            0x00BC
${define} EM_GETHANDLE            0x00BD
${define} EM_GETTHUMB             0x00BE
${define} EM_LINELENGTH           0x00C1
${define} EM_REPLACESEL           0x00C2
${define} EM_GETLINE              0x00C4
${define} EM_LIMITTEXT            0x00C5
${define} EM_CANUNDO              0x00C6
${define} EM_UNDO                 0x00C7
${define} EM_FMTLINES             0x00C8
${define} EM_LINEFROMCHAR         0x00C9
${define} EM_SETTABSTOPS          0x00CB
${define} EM_SETPASSWORDCHAR      0x00CC
${define} EM_EMPTYUNDOBUFFER      0x00CD
${define} EM_GETFIRSTVISIBLELINE  0x00CE
${define} EM_SETREADONLY          0x00CF
${define} EM_SETWORDBREAKPROC     0x00D0
${define} EM_GETWORDBREAKPROC     0x00D1
${define} EM_GETPASSWORDCHAR      0x00D2
#if(WINVER >= 0x0400)
#define EM_SETMARGINS           0x00D3
#define EM_GETMARGINS           0x00D4
#define EM_SETLIMITTEXT         EM_LIMITTEXT   /* ;win40 Name change */
#define EM_GETLIMITTEXT         0x00D5
#define EM_POSFROMCHAR          0x00D6
#define EM_CHARFROMPOS          0x00D7
#endif /* WINVER >= 0x0400 */
#if(WINVER >= 0x0500)
#define EM_SETIMESTATUS         0x00D8
#define EM_GETIMESTATUS         0x00D9
#endif /* WINVER >= 0x0500 */

;/*
; * Static Control Mesages
; */
${define} STM_SETICON         0x0170
${define} STM_GETICON         0x0171
#if(WINVER >= 0x0400)
${define} STM_SETIMAGE        0x0172
${define} STM_GETIMAGE        0x0173
${define} STN_CLICKED         0
${define} STN_DBLCLK          1
${define} STN_ENABLE          2
${define} STN_DISABLE         3
#endif /* WINVER >= 0x0400 */
${define} STM_MSGMAX          0x0174

;/*
; * Combo Box messages
; */
${define} CB_GETEDITSEL               0x0140
${define} CB_LIMITTEXT                0x0141
${define} CB_SETEDITSEL               0x0142
${define} CB_ADDSTRING                0x0143
${define} CB_DELETESTRING             0x0144
${define} CB_DIR                      0x0145
${define} CB_GETCOUNT                 0x0146
${define} CB_GETCURSEL                0x0147
${define} CB_GETLBTEXT                0x0148
${define} CB_GETLBTEXTLEN             0x0149
${define} CB_INSERTSTRING             0x014A
${define} CB_RESETCONTENT             0x014B
${define} CB_FINDSTRING               0x014C
${define} CB_SELECTSTRING             0x014D
${define} CB_SETCURSEL                0x014E
${define} CB_SHOWDROPDOWN             0x014F
${define} CB_GETITEMDATA              0x0150
${define} CB_SETITEMDATA              0x0151
${define} CB_GETDROPPEDCONTROLRECT    0x0152
${define} CB_SETITEMHEIGHT            0x0153
${define} CB_GETITEMHEIGHT            0x0154
${define} CB_SETEXTENDEDUI            0x0155
${define} CB_GETEXTENDEDUI            0x0156
${define} CB_GETDROPPEDSTATE          0x0157
${define} CB_FINDSTRINGEXACT          0x0158
${define} CB_SETLOCALE                0x0159
${define} CB_GETLOCALE                0x015A
#if(WINVER >= 0x0400)
${define} CB_GETTOPINDEX              0x015b
${define} CB_SETTOPINDEX              0x015c
${define} CB_GETHORIZONTALEXTENT      0x015d
${define} CB_SETHORIZONTALEXTENT      0x015e
${define} CB_GETDROPPEDWIDTH          0x015f
${define} CB_SETDROPPEDWIDTH          0x0160
${define} CB_INITSTORAGE              0x0161
#if(_WIN32_WCE >= 0x0400)
${define} CB_MULTIPLEADDSTRING        0x0163
#endif
#endif /* WINVER >= 0x0400 */

#if(_WIN32_WINNT >= 0x0501)
${define} CB_GETCOMBOBOXINFO          0x0164
#endif /* _WIN32_WINNT >= 0x0501 */

#if(_WIN32_WINNT >= 0x0501)
${define} CB_MSGMAX                   0x0165
#elif(_WIN32_WCE >= 0x0400)
${define} CB_MSGMAX                   0x0163
#elif(WINVER >= 0x0400)
${define} CB_MSGMAX                   0x0162
#else
${define} CB_MSGMAX                   0x015B
#endif

;/*
; * Listbox messages
; */
${define} LB_ADDSTRING            0x0180
${define} LB_INSERTSTRING         0x0181
${define} LB_DELETESTRING         0x0182
${define} LB_SELITEMRANGEEX       0x0183
${define} LB_RESETCONTENT         0x0184
${define} LB_SETSEL               0x0185
${define} LB_SETCURSEL            0x0186
${define} LB_GETSEL               0x0187
${define} LB_GETCURSEL            0x0188
${define} LB_GETTEXT              0x0189
${define} LB_GETTEXTLEN           0x018A
${define} LB_GETCOUNT             0x018B
${define} LB_SELECTSTRING         0x018C
${define} LB_DIR                  0x018D
${define} LB_GETTOPINDEX          0x018E
${define} LB_FINDSTRING           0x018F
${define} LB_GETSELCOUNT          0x0190
${define} LB_GETSELITEMS          0x0191
${define} LB_SETTABSTOPS          0x0192
${define} LB_GETHORIZONTALEXTENT  0x0193
${define} LB_SETHORIZONTALEXTENT  0x0194
${define} LB_SETCOLUMNWIDTH       0x0195
${define} LB_ADDFILE              0x0196
${define} LB_SETTOPINDEX          0x0197
${define} LB_GETITEMRECT          0x0198
${define} LB_GETITEMDATA          0x0199
${define} LB_SETITEMDATA          0x019A
${define} LB_SELITEMRANGE         0x019B
${define} LB_SETANCHORINDEX       0x019C
${define} LB_GETANCHORINDEX       0x019D
${define} LB_SETCARETINDEX        0x019E
${define} LB_GETCARETINDEX        0x019F
${define} LB_SETITEMHEIGHT        0x01A0
${define} LB_GETITEMHEIGHT        0x01A1
${define} LB_FINDSTRINGEXACT      0x01A2
${define} LB_SETLOCALE            0x01A5
${define} LB_GETLOCALE            0x01A6
${define} LB_SETCOUNT             0x01A7
#if(WINVER >= 0x0400)
${define} LB_INITSTORAGE          0x01A8
${define} LB_ITEMFROMPOINT        0x01A9
#endif /* WINVER >= 0x0400 */
#if(_WIN32_WCE >= 0x0400)
${define} LB_MULTIPLEADDSTRING    0x01B1
#endif


#if(_WIN32_WINNT >= 0x0501)
${define} LB_GETLISTBOXINFO       0x01B2
#endif /* _WIN32_WINNT >= 0x0501 */

#if(_WIN32_WINNT >= 0x0501)
${define} LB_MSGMAX               0x01B3
#elif(_WIN32_WCE >= 0x0400)
${define} LB_MSGMAX               0x01B1
#elif(WINVER >= 0x0400)
${define} LB_MSGMAX               0x01B0
#else
${define} LB_MSGMAX               0x01A8
#endif

;/*
; * TreeView messages
; */
${define} TV_FIRST            0x1100
${define} TVM_SETBKCOLOR      0x111D      ; (TV_FIRST + 29)
${define} TVM_SETTEXTCOLOR    0x111D      ; (TV_FIRST + 30)
${define} TVM_SETLINECOLOR    0x1128      ; (TV_FIRST + 40)

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

;/*
; * MessageBox() Flags
; */
${define} MB_OK                       0x00000000
${define} MB_OKCANCEL                 0x00000001
${define} MB_ABORTRETRYIGNORE         0x00000002
${define} MB_YESNOCANCEL              0x00000003
${define} MB_YESNO                    0x00000004
${define} MB_RETRYCANCEL              0x00000005


${define} MB_ICONHAND                 0x00000010
${define} MB_ICONQUESTION             0x00000020
${define} MB_ICONEXCLAMATION          0x00000030
${define} MB_ICONASTERISK             0x00000040

#if(WINVER >= 0x0400)
${define} MB_USERICON                 0x00000080
${define} MB_ICONWARNING              ${MB_ICONEXCLAMATION}
${define} MB_ICONERROR                ${MB_ICONHAND}
#endif /* WINVER >= 0x0400 */

${define} MB_ICONINFORMATION          ${MB_ICONASTERISK}
${define} MB_ICONSTOP                 ${MB_ICONHAND}

${define} MB_DEFBUTTON1               0x00000000
${define} MB_DEFBUTTON2               0x00000100
${define} MB_DEFBUTTON3               0x00000200
#if(WINVER >= 0x0400)
${define} MB_DEFBUTTON4               0x00000300
#endif /* WINVER >= 0x0400 */

${define} MB_APPLMODAL                0x00000000
${define} MB_SYSTEMMODAL              0x00001000
${define} MB_TASKMODAL                0x00002000
#if(WINVER >= 0x0400)
${define} MB_HELP                     0x00004000 ; Help Button
#endif /* WINVER >= 0x0400 */

${define} MB_NOFOCUS                  0x00008000
${define} MB_SETFOREGROUND            0x00010000
${define} MB_DEFAULT_DESKTOP_ONLY     0x00020000

#if(WINVER >= 0x0400)
${define} MB_TOPMOST                  0x00040000
${define} MB_RIGHT                    0x00080000
${define} MB_RTLREADING               0x00100000


#endif /* WINVER >= 0x0400 */

#ifdef _WIN32_WINNT
#if (_WIN32_WINNT >= 0x0400)
${define} MB_SERVICE_NOTIFICATION          0x00200000
#else
${define} MB_SERVICE_NOTIFICATION          0x00040000
#endif
${define} MB_SERVICE_NOTIFICATION_NT3X     0x00040000
#endif

${define} MB_TYPEMASK                 0x0000000F
${define} MB_ICONMASK                 0x000000F0
${define} MB_DEFMASK                  0x00000F00
${define} MB_MODEMASK                 0x00003000
${define} MB_MISCMASK                 0x0000C000

;/*
; * Dialog Box Command IDs
; */
${define} IDOK                1
${define} IDCANCEL            2
${define} IDABORT             3
${define} IDRETRY             4
${define} IDIGNORE            5
${define} IDYES               6
${define} IDNO                7
#if(WINVER >= 0x0400)
${define} IDCLOSE         8
${define} IDHELP          9
#endif /* WINVER >= 0x0400 */

; Icon/Cursor header
${define} IMAGE_BITMAP        0
${define} IMAGE_ICON          1
${define} IMAGE_CURSOR        2

${define} LR_DEFAULTCOLOR     0x0000
${define} LR_MONOCHROME       0x0001
${define} LR_COLOR            0x0002
${define} LR_COPYRETURNORG    0x0004
${define} LR_COPYDELETEORG    0x0008
${define} LR_LOADFROMFILE     0x0010
${define} LR_LOADTRANSPARENT  0x0020
${define} LR_DEFAULTSIZE      0x0040
${define} LR_VGACOLOR         0x0080
${define} LR_LOADMAP3DCOLORS  0x1000
${define} LR_CREATEDIBSECTION 0x2000
${define} LR_COPYFROMRESOURCE 0x4000
${define} LR_SHARED           0x8000

;/*
; * Window field offsets for GetWindowLong()
; */
;${define} GWL_WNDPROC         -4
;${define} GWL_HINSTANCE       -6
;${define} GWL_HWNDPARENT      -8
${define} GWL_STYLE           -16
;${define} GWL_EXSTYLE         -20
;${define} GWL_USERDATA        -21
;${define} GWL_ID              -12

; Window messages
${define} WM_INITDIALOG                   0x0110
${define} WM_COMMAND                      0x0111
${define} WM_SYSCOMMAND                   0x0112
${define} WM_TIMER                        0x0113
${define} WM_HSCROLL                      0x0114
${define} WM_VSCROLL                      0x0115
${define} WM_INITMENU                     0x0116
${define} WM_INITMENUPOPUP                0x0117
${define} WM_MENUSELECT                   0x011F
${define} WM_MENUCHAR                     0x0120
${define} WM_ENTERIDLE                    0x0121
${define} WM_DRAWITEM                     0x002B

${define} WM_CONTEXTMENU                  0x007B
${define} WM_STYLECHANGING                0x007C
${define} WM_STYLECHANGED                 0x007D
${define} WM_DISPLAYCHANGE                0x007E
${define} WM_GETICON                      0x007F
${define} WM_SETICON                      0x0080

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

;*********************************************
;CommCtrl.h
;**********************************************

; ListView messages
${define} LVM_FIRST               0x1000
${define} LVM_DELETEITEM          0x1008
${define} LVM_DELETEALLITEMS      0x1009

;*********************************************
;WinNT.h
;**********************************************

;/
;// Predefined Value Types.
;/
${define} REG_NONE                         0 ;   // No value type
${define} REG_SZ                           1 ;   // Unicode nul terminated string
${define} REG_EXPAND_SZ                    2 ;   // Unicode nul terminated string
                                             ; (with environment variable references)
${define} REG_BINARY                       3 ;   // Free form binary
${define} REG_DWORD                        4 ;   // 32-bit number
${define} REG_DWORD_LITTLE_ENDIAN          4 ;   // 32-bit number (same as REG_DWORD)
${define} REG_DWORD_BIG_ENDIAN             5 ;   // 32-bit number
${define} REG_LINK                         6 ;   // Symbolic Link (unicode)
${define} REG_MULTI_SZ                     7 ;   // Multiple Unicode strings
${define} REG_RESOURCE_LIST                8 ;   // Resource list in the resource map
${define} REG_FULL_RESOURCE_DESCRIPTOR     9 ;  // Resource list in the hardware description
${define} REG_RESOURCE_REQUIREMENTS_LIST   10 ;
${define} REG_QWORD                        11 ;  // 64-bit number
${define} REG_QWORD_LITTLE_ENDIAN          11 ;  // 64-bit number (same as REG_QWORD)

;//
;// Registry Specific Access Rights.
;//
${define} KEY_QUERY_VALUE         0x0001
${define} KEY_SET_VALUE           0x0002
${define} KEY_CREATE_SUB_KEY      0x0004
${define} KEY_ENUMERATE_SUB_KEYS  0x0008
${define} KEY_NOTIFY              0x0010
${define} KEY_CREATE_LINK         0x0020
${define} KEY_WOW64_32KEY         0x0200
${define} KEY_WOW64_64KEY         0x0100
${define} KEY_WOW64_RES           0x0300
${define} KEY_READ                0x20019
${define} KEY_WRITE               0x20006
${define} KEY_EXECUTE             0x20019
${define} KEY_ALL_ACCESS          0xF003F

;//
;//  The following are masks for the predefined standard access types
;//
${define} STANDARD_RIGHTS_READ     0x00020000
${define} SYNCHRONIZE              0x00100000

;/
;// Reserved Key Handles.
;/
${define} HKEY_CLASSES_ROOT           0x80000000
${define} HKEY_CURRENT_USER           0x80000001
${define} HKEY_LOCAL_MACHINE          0x80000002
${define} HKEY_USERS                  0x80000003
${define} HKEY_PERFORMANCE_DATA       0x80000004
${define} HKEY_PERFORMANCE_TEXT       0x80000050
${define} HKEY_PERFORMANCE_NLSTEXT    0x80000060
#if(WINVER >= 0x0400)
${define} HKEY_CURRENT_CONFIG         0x80000005
${define} HKEY_DYN_DATA               0x80000006
#endif
${define} HKCR             ${HKEY_CLASSES_ROOT}
${define} HKCU             ${HKEY_CURRENT_USER}
${define} HKLM             ${HKEY_LOCAL_MACHINE}
${define} HKU              ${HKEY_USERS}
${define} HKPD             ${HKEY_PERFORMANCE_DATA}
${define} HKCC             ${HKEY_CURRENT_CONFIG}
${define} HKDD             ${HKEY_DYN_DATA}

;/
;// FILE
;/
${define} FILE_ATTRIBUTE_READONLY             0x00000001
${define} FILE_ATTRIBUTE_HIDDEN               0x00000002
${define} FILE_ATTRIBUTE_SYSTEM               0x00000004
${define} FILE_ATTRIBUTE_DIRECTORY            0x00000010
${define} FILE_ATTRIBUTE_ARCHIVE              0x00000020
${define} FILE_ATTRIBUTE_DEVICE               0x00000040
${define} FILE_ATTRIBUTE_NORMAL               0x00000080
${define} FILE_ATTRIBUTE_TEMPORARY            0x00000100
${define} FILE_ATTRIBUTE_SPARSE_FILE          0x00000200
${define} FILE_ATTRIBUTE_REPARSE_POINT        0x00000400
${define} FILE_ATTRIBUTE_COMPRESSED           0x00000800
${define} FILE_ATTRIBUTE_OFFLINE              0x00001000
${define} FILE_ATTRIBUTE_NOT_CONTENT_INDEXED  0x00002000
${define} FILE_ATTRIBUTE_ENCRYPTED            0x00004000

;//
;// dwPlatformId defines:
;//

!define VER_PLATFORM_WIN32s             0
!define VER_PLATFORM_WIN32_WINDOWS      1
!define VER_PLATFORM_WIN32_NT           2



;*********************************************
;WinError.h
;**********************************************

;/*
;// MessageId: ERROR_SUCCESS
;//
;// MessageText:
;//
;//  The operation completed successfully.
;*/
${define} ERROR_SUCCESS                    0

${define} NO_ERROR                         0          ; dderror
${define} SEC_E_OK                         0x00000000

;*********************************************
;WinNls.h
;**********************************************

;/*
;//  Code Page Default Values.
;*/
!define CP_ACP                    0           ; default to ANSI code page
!define CP_OEMCP                  1           ; default to OEM  code page
!define CP_MACCP                  2           ; default to MAC  code page
!define CP_THREAD_ACP             3           ; current thread's ANSI code page
!define CP_SYMBOL                 42          ; SYMBOL translations

!define CP_UTF7                   65000       ; UTF-7 translation
!define CP_UTF8                   65001       ; UTF-8 translation

;//
;//  The following LCTypes are mutually exclusive in that they may NOT
;//  be used in combination with each other.
;//
!define LOCALE_ILANGUAGE              0x00000001   ; language id
!define LOCALE_SLANGUAGE              0x00000002   ; localized name of language
!define LOCALE_SENGLANGUAGE           0x00001001   ; English name of language
!define LOCALE_SABBREVLANGNAME        0x00000003   ; abbreviated language name
!define LOCALE_SNATIVELANGNAME        0x00000004   ; native name of language

!define LOCALE_ICOUNTRY               0x00000005   ; country code
!define LOCALE_SCOUNTRY               0x00000006   ; localized name of country
!define LOCALE_SENGCOUNTRY            0x00001002   ; English name of country
!define LOCALE_SABBREVCTRYNAME        0x00000007   ; abbreviated country name
!define LOCALE_SNATIVECTRYNAME        0x00000008   ; native name of country

!define LOCALE_IDEFAULTLANGUAGE       0x00000009   ; default language id
!define LOCALE_IDEFAULTCOUNTRY        0x0000000A   ; default country code
!define LOCALE_IDEFAULTCODEPAGE       0x0000000B   ; default oem code page
!define LOCALE_IDEFAULTANSICODEPAGE   0x00001004   ; default ansi code page
!define LOCALE_IDEFAULTMACCODEPAGE    0x00001011   ; default mac code page

!define LOCALE_SLIST                  0x0000000C   ; list item separator
!define LOCALE_IMEASURE               0x0000000D   ; 0 = metric, 1 = US

!define LOCALE_SDECIMAL               0x0000000E   ; decimal separator
!define LOCALE_STHOUSAND              0x0000000F   ; thousand separator
!define LOCALE_SGROUPING              0x00000010   ; digit grouping
!define LOCALE_IDIGITS                0x00000011   ; number of fractional digits
!define LOCALE_ILZERO                 0x00000012   ; leading zeros for decimal
!define LOCALE_INEGNUMBER             0x00001010   ; negative number mode
!define LOCALE_SNATIVEDIGITS          0x00000013   ; native ascii 0-9

!define LOCALE_SCURRENCY              0x00000014   ; local monetary symbol
!define LOCALE_SINTLSYMBOL            0x00000015   ; intl monetary symbol
!define LOCALE_SMONDECIMALSEP         0x00000016   ; monetary decimal separator
!define LOCALE_SMONTHOUSANDSEP        0x00000017   ; monetary thousand separator
!define LOCALE_SMONGROUPING           0x00000018   ; monetary grouping
!define LOCALE_ICURRDIGITS            0x00000019   ; # local monetary digits
!define LOCALE_IINTLCURRDIGITS        0x0000001A   ; # intl monetary digits
!define LOCALE_ICURRENCY              0x0000001B   ; positive currency mode
!define LOCALE_INEGCURR               0x0000001C   ; negative currency mode

!define LOCALE_SDATE                  0x0000001D   ; date separator
!define LOCALE_STIME                  0x0000001E   ; time separator
!define LOCALE_SSHORTDATE             0x0000001F   ; short date format string
!define LOCALE_SLONGDATE              0x00000020   ; long date format string
!define LOCALE_STIMEFORMAT            0x00001003   ; time format string
!define LOCALE_IDATE                  0x00000021   ; short date format ordering
!define LOCALE_ILDATE                 0x00000022   ; long date format ordering
!define LOCALE_ITIME                  0x00000023   ; time format specifier
!define LOCALE_ITIMEMARKPOSN          0x00001005   ; time marker position
!define LOCALE_ICENTURY               0x00000024   ; century format specifier (short date)
!define LOCALE_ITLZERO                0x00000025   ; leading zeros in time field
!define LOCALE_IDAYLZERO              0x00000026   ; leading zeros in day field (short date)
!define LOCALE_IMONLZERO              0x00000027   ; leading zeros in month field (short date)
!define LOCALE_S1159                  0x00000028   ; AM designator
!define LOCALE_S2359                  0x00000029   ; PM designator

!define LOCALE_ICALENDARTYPE          0x00001009   ; type of calendar specifier
!define LOCALE_IOPTIONALCALENDAR      0x0000100B   ; additional calendar types specifier
!define LOCALE_IFIRSTDAYOFWEEK        0x0000100C   ; first day of week specifier
!define LOCALE_IFIRSTWEEKOFYEAR       0x0000100D   ; first week of year specifier

!define LOCALE_SDAYNAME1              0x0000002A   ; long name for Monday
!define LOCALE_SDAYNAME2              0x0000002B   ; long name for Tuesday
!define LOCALE_SDAYNAME3              0x0000002C   ; long name for Wednesday
!define LOCALE_SDAYNAME4              0x0000002D   ; long name for Thursday
!define LOCALE_SDAYNAME5              0x0000002E   ; long name for Friday
!define LOCALE_SDAYNAME6              0x0000002F   ; long name for Saturday
!define LOCALE_SDAYNAME7              0x00000030   ; long name for Sunday
!define LOCALE_SABBREVDAYNAME1        0x00000031   ; abbreviated name for Monday
!define LOCALE_SABBREVDAYNAME2        0x00000032   ; abbreviated name for Tuesday
!define LOCALE_SABBREVDAYNAME3        0x00000033   ; abbreviated name for Wednesday
!define LOCALE_SABBREVDAYNAME4        0x00000034   ; abbreviated name for Thursday
!define LOCALE_SABBREVDAYNAME5        0x00000035   ; abbreviated name for Friday
!define LOCALE_SABBREVDAYNAME6        0x00000036   ; abbreviated name for Saturday
!define LOCALE_SABBREVDAYNAME7        0x00000037   ; abbreviated name for Sunday
!define LOCALE_SMONTHNAME1            0x00000038   ; long name for January
!define LOCALE_SMONTHNAME2            0x00000039   ; long name for February
!define LOCALE_SMONTHNAME3            0x0000003A   ; long name for March
!define LOCALE_SMONTHNAME4            0x0000003B   ; long name for April
!define LOCALE_SMONTHNAME5            0x0000003C   ; long name for May
!define LOCALE_SMONTHNAME6            0x0000003D   ; long name for June
!define LOCALE_SMONTHNAME7            0x0000003E   ; long name for July
!define LOCALE_SMONTHNAME8            0x0000003F   ; long name for August
!define LOCALE_SMONTHNAME9            0x00000040   ; long name for September
!define LOCALE_SMONTHNAME10           0x00000041   ; long name for October
!define LOCALE_SMONTHNAME11           0x00000042   ; long name for November
!define LOCALE_SMONTHNAME12           0x00000043   ; long name for December
!define LOCALE_SMONTHNAME13           0x0000100E   ; long name for 13th month (if exists)
!define LOCALE_SABBREVMONTHNAME1      0x00000044   ; abbreviated name for January
!define LOCALE_SABBREVMONTHNAME2      0x00000045   ; abbreviated name for February
!define LOCALE_SABBREVMONTHNAME3      0x00000046   ; abbreviated name for March
!define LOCALE_SABBREVMONTHNAME4      0x00000047   ; abbreviated name for April
!define LOCALE_SABBREVMONTHNAME5      0x00000048   ; abbreviated name for May
!define LOCALE_SABBREVMONTHNAME6      0x00000049   ; abbreviated name for June
!define LOCALE_SABBREVMONTHNAME7      0x0000004A   ; abbreviated name for July
!define LOCALE_SABBREVMONTHNAME8      0x0000004B   ; abbreviated name for August
!define LOCALE_SABBREVMONTHNAME9      0x0000004C   ; abbreviated name for September
!define LOCALE_SABBREVMONTHNAME10     0x0000004D   ; abbreviated name for October
!define LOCALE_SABBREVMONTHNAME11     0x0000004E   ; abbreviated name for November
!define LOCALE_SABBREVMONTHNAME12     0x0000004F   ; abbreviated name for December
!define LOCALE_SABBREVMONTHNAME13     0x0000100F   ; abbreviated name for 13th month (if exists)

!define LOCALE_SPOSITIVESIGN          0x00000050   ; positive sign
!define LOCALE_SNEGATIVESIGN          0x00000051   ; negative sign
!define LOCALE_IPOSSIGNPOSN           0x00000052   ; positive sign position
!define LOCALE_INEGSIGNPOSN           0x00000053   ; negative sign position
!define LOCALE_IPOSSYMPRECEDES        0x00000054   ; mon sym precedes pos amt
!define LOCALE_IPOSSEPBYSPACE         0x00000055   ; mon sym sep by space from pos amt
!define LOCALE_INEGSYMPRECEDES        0x00000056   ; mon sym precedes neg amt
!define LOCALE_INEGSEPBYSPACE         0x00000057   ; mon sym sep by space from neg amt

#if(WINVER >= 0x0400)
!define LOCALE_FONTSIGNATURE          0x00000058   ; font signature
!define LOCALE_SISO639LANGNAME        0x00000059   ; ISO abbreviated language name
!define LOCALE_SISO3166CTRYNAME       0x0000005A   ; ISO abbreviated country name
#endif /* WINVER >= 0x0400 */

#if(WINVER >= 0x0500)
!define LOCALE_IDEFAULTEBCDICCODEPAGE 0x00001012   ; default ebcdic code page
!define LOCALE_IPAPERSIZE             0x0000100A   ; 1 = letter, 5 = legal, 8 = a3, 9 = a4
!define LOCALE_SENGCURRNAME           0x00001007   ; english name of currency
!define LOCALE_SNATIVECURRNAME        0x00001008   ; native name of currency
!define LOCALE_SYEARMONTH             0x00001006   ; year month format string
!define LOCALE_SSORTNAME              0x00001013   ; sort name
!define LOCALE_IDIGITSUBSTITUTION     0x00001014   ; 0 = context, 1 = none, 2 = national
#endif /* WINVER >= 0x0500 */

;//
;//  Default System and User IDs for language and locale.
;//
!define LOCALE_SYSTEM_DEFAULT 2048

;*********************************************
;COM
;**********************************************
!define CLSCTX_INPROC_SERVER	 0x1
!define	CLSCTX_INPROC_HANDLER	 0x2
!define	CLSCTX_LOCAL_SERVER	 0x4
!define	CLSCTX_INPROC_SERVER16	 0x8
!define	CLSCTX_REMOTE_SERVER	 0x10
!define	CLSCTX_INPROC_HANDLER16	 0x20
!define	CLSCTX_RESERVED1	 0x40
!define	CLSCTX_RESERVED2	 0x80
!define	CLSCTX_RESERVED3	 0x100
!define	CLSCTX_RESERVED4	 0x200
!define	CLSCTX_NO_CODE_DOWNLOAD	 0x400
!define	CLSCTX_RESERVED5	 0x800
!define	CLSCTX_NO_CUSTOM_MARSHAL	 0x1000
!define	CLSCTX_ENABLE_CODE_DOWNLOAD	 0x2000
!define	CLSCTX_NO_FAILURE_LOG	 0x4000
!define	CLSCTX_DISABLE_AAA	 0x8000
!define	CLSCTX_ENABLE_AAA	 0x10000
!define	CLSCTX_FROM_DEFAULT_CONTEXT	 0x20000
!define	CLSCTX_ACTIVATE_32_BIT_SERVER	 0x40000
!define	CLSCTX_ACTIVATE_64_BIT_SERVER	 0x80000

;ActiveDesktop
!define CLSID_ActiveDesktop {75048700-EF1F-11D0-9888-006097DEACF9}
!define IID_IActiveDesktop {F490EB00-1240-11D1-9888-006097DEACF9}

;///////////////////////////////////////////
;/ Flags for IActiveDesktop::ApplyChanges()
!define AD_APPLY_SAVE             0x00000001
!define AD_APPLY_HTMLGEN          0x00000002
!define AD_APPLY_REFRESH          0x00000004
!define AD_APPLY_ALL              0x00000007 ;(AD_APPLY_SAVE | AD_APPLY_HTMLGEN | AD_APPLY_REFRESH)
!define AD_APPLY_FORCE            0x00000008
!define AD_APPLY_BUFFERED_REFRESH 0x00000010
!define AD_APPLY_DYNAMICREFRESH   0x00000020

;///////////////////////////////////////////
;/ Flags for IActiveDesktop::GetWallpaperOptions()
;/           IActiveDesktop::SetWallpaperOptions()
!define WPSTYLE_CENTER      0
!define WPSTYLE_TILE        1
!define WPSTYLE_STRETCH     2
!define WPSTYLE_MAX         3

;*********************************************
;文件 BOM 标记
;**********************************************
!define BOM_ANSI                    0
!define BOM_EBCDIC                  1
!define BOM_UCS4_LE                 2
!define BOM_UCS4_BE                 3
!define BOM_UTF16_BE                4
!define BOM_UTF16_LE                5
!define BOM_UNICODE_BE              6
!define BOM_UNICODE_LE              7
!define BOM_UTF8                    8
!define BOM_UNICODE                 ${BOM_UNICODE_LE}

;*********************************************
;用户标记
;**********************************************
!define CURRENT_USER               1
!define LOCAL_MACHINE              2
!define ALL_USERS                  3

;*********************************************
;System.dll Function modules
;**********************************************

!ifdef <System.dll模块>
!endif
 
${define} RegOpenKey     "Advapi32::RegOpenKey(i, t, i) i"
${define} RegOpenKeyW     "Advapi32::RegOpenKeyW(i, t, i) i"
;LONG RegOpenKey(
;  HKEY hKey,
;  LPCTSTR lpSubKey,
;  PHKEY phkResult
;);

${define} RegOpenKeyEx     "Advapi32::RegOpenKeyEx(i, t, i, i, i) i"
${define} RegOpenKeyExW     "Advapi32::RegOpenKeyExW(i, t, i, i, i) i"
;LONG RegOpenKeyEx(
;  HKEY hKey,
;  LPCTSTR lpSubKey,
;  DWORD ulOptions,
;  REGSAM samDesired,
;  PHKEY phkResult
;);

${define} RegQueryValueEx  "Advapi32::RegQueryValueEx(i, t, i, i, i, i, i) i"
${define} RegQueryValueExW  "Advapi32::RegQueryValueExW(i, t, i, i, i, i, i) i"
;LONG RegQueryValueEx(
;  HKEY hKey,
;  LPCTSTR lpValueName,
;  LPDWORD lpReserved,
;  LPDWORD lpType,
;  LPBYTE lpData,
;  LPDWORD lpcbData
;);

${define} RegCreateKey     "Advapi32::RegCreateKey(i, t, i) i"
${define} RegCreateKeyW     "Advapi32::RegCreateKeyW(i, t, i) i"
;LONG RegCreateKey(
;  HKEY hKey,
;  LPCTSTR lpSubKey,
;  PHKEY phkResult
;);

${define} RegSetValueEx    "Advapi32::RegSetValueEx(i, t, i, i, t, i) i"
${define} RegSetValueExW    "Advapi32::RegSetValueExW(i, t, i, i, t, i) i"
;LONG RegSetValueEx(
;  HKEY hKey,
;  LPCTSTR lpValueName,
;  DWORD Reserved,
;  DWORD dwType,
;  const BYTE* lpData,
;  DWORD cbData
;);

${define} RegEnumKey       "Advapi32::RegEnumKey(i, i, t, i) i"
${define} RegEnumKeyW       "Advapi32::RegEnumKeyW(i, i, t, i) i"
;LONG RegEnumKey(
;  HKEY hKey,
;  DWORD dwIndex,
;  LPTSTR lpName,
;  DWORD cchName
;);

${define} RegEnumValue     "Advapi32::RegEnumValue(i, i, t, i, i, i, t, i) i"
${define} RegEnumValueW     "Advapi32::RegEnumValueW(i, i, t, i, i, i, t, i) i"
;LONG RegEnumValue(
;  HKEY hKey,
;  DWORD dwIndex,
;  LPTSTR lpValueName,
;  LPDWORD lpcValueName,
;  LPDWORD lpReserved,
;  LPDWORD lpType,
;  LPBYTE lpData,
;  LPDWORD lpcbData
;);

${define} RegDeleteKey     "Advapi32::RegDeleteKey(i, t) i"
${define} RegDeleteKeyW     "Advapi32::RegDeleteKeyW(i, t) i"
;LONG RegDeleteKey(
;  HKEY hKey,
;  LPCTSTR lpSubKey
;);

${define} RegDeleteKeyEx     "Advapi32::RegDeleteKeyEx(i, t, i, i) i"
${define} RegDeleteKeyExW     "Advapi32::RegDeleteKeyExW(i, t, i, i) i"
;LONG RegDeleteKeyEx(
;  HKEY hKey,
;  LPCTSTR lpSubKey,
;  REGSAM samDesired,
;  DWORD Reserved
;);

${define} RegDeleteValue     "Advapi32::RegDeleteValue(i, t) i"
${define} RegDeleteValueW     "Advapi32::RegDeleteValueW(i, t) i"
;LONG RegDeleteValue(
;  HKEY hKey,
;  LPCTSTR lpValueName
;);

${define} RegCloseKey      "Advapi32::RegCloseKey(i) i"
;LONG RegCloseKey(
;  HKEY hKey
;);

${define} RegQueryInfoKey      "Advapi32::RegQueryInfoKey(i, t, i, i, i, i, i, i, i, i, i, i) i"
${define} RegQueryInfoKeyW      "Advapi32::RegQueryInfoKeyW(i, t, i, i, i, i, i, i, i, i, i, i) i"
;LONG RegQueryInfoKey(
;  HKEY hKey,                      // handle to key
;  LPTSTR lpClass,                 // class buffer
;  LPDWORD lpcClass,               // size of class buffer
;  LPDWORD lpReserved,             // reserved
;  LPDWORD lpcSubKeys,             // number of subkeys
;  LPDWORD lpcMaxSubKeyLen,        // longest subkey name
;  LPDWORD lpcMaxClassLen,         // longest class string
;  LPDWORD lpcValues,              // number of value entries
;  LPDWORD lpcMaxValueNameLen,     // longest value name
;  LPDWORD lpcMaxValueLen,         // longest value data
;  LPDWORD lpcbSecurityDescriptor, // descriptor length
;  PFILETIME lpftLastWriteTime     // last write time
;);

${define} MultiByteToWideChar       "Kernel32::MultiByteToWideChar(i, i, t, i, t, i) i"
;int MultiByteToWideChar(
;  UINT CodePage,         // code page
;  DWORD dwFlags,         // character-type options
;  LPCSTR lpMultiByteStr, // string to map
;  int cbMultiByte,       // number of bytes in string
;  LPWSTR lpWideCharStr,  // wide-character buffer
;  int cchWideChar        // size of buffer
;);

${define} WideCharToMultiByte       "Kernel32::WideCharToMultiByte(i, i, t, i, t, i, t, i) i"
;int WideCharToMultiByte(
;  UINT CodePage,            // code page
;  DWORD dwFlags,            // performance and mapping flags
;  LPCWSTR lpWideCharStr,    // wide-character string
;  int cchWideChar,          // number of chars in string
;  LPSTR lpMultiByteStr,     // buffer for new string
;  int cbMultiByte,          // size of buffer
;  LPCSTR lpDefaultChar,     // default for unmappable chars
;  LPBOOL lpUsedDefaultChar  // set when default char used
;);


;*********************************************
;for debug
;**********************************************

${define} mydebug            `dumpstate::debug`

!macro StackTestInit
	StrCpy $0 `$$0`
	StrCpy $1 `$$1`
	StrCpy $2 `$$2`
	StrCpy $3 `$$3`
	StrCpy $4 `$$4`
	StrCpy $5 `$$5`
	StrCpy $6 `$$6`
	StrCpy $7 `$$7`
	StrCpy $8 `$$8`
	StrCpy $9 `$$9`
	StrCpy $R0 `$$R0`
	StrCpy $R1 `$$R1`
	StrCpy $R2 `$$R2`
	StrCpy $R3 `$$R3`
	StrCpy $R4 `$$R4`
	StrCpy $R5 `$$R5`
	StrCpy $R6 `$$R6`
	StrCpy $R7 `$$R7`
	StrCpy $R8 `$$R8`
	StrCpy $R9 `$$R9`
!macroend

!macro StackTestDisplay
	DetailPrint $0
	DetailPrint $1
	DetailPrint $2
	DetailPrint $3
	DetailPrint $4
	DetailPrint $5
	DetailPrint $6
	DetailPrint $7
	DetailPrint $8
	DetailPrint $9
	DetailPrint $R0
	DetailPrint $R1
	DetailPrint $R2
	DetailPrint $R3
	DetailPrint $R4
	DetailPrint $R5
	DetailPrint $R6
	DetailPrint $R7
	DetailPrint $R8
	DetailPrint $R9
!macroend

!macro BitOutput STRING
    Push `${STRING}`
    Exch $0
    Push $1
    Push $2
    Push $3
    Push $4
    Push $5
    Push $6
    Push $7

    System::Call /NOUNLOAD "*(&t${NSIS_MAX_STRLEN} r0) i .r1"
    System::Alloc /NOUNLOAD ${NSIS_MAX_STRLEN}
    Pop $6
    StrLen $2 $0
    StrCpy $7 $6
    ${For} $3 0 $2
        IntOp $4 $1 + $3
        System::Call /NOUNLOAD "*$4(&i1 .r5)"
        IntFmt $5 "0x%X " $5
        System::Call /NOUNLOAD "*$7(&t5 r5)"
        IntOp $7 $7 + 5
    ${Next}
    System::Call /NOUNLOAD "*$6(&t${NSIS_MAX_STRLEN} .r5)"
    DetailPrint $5
    System::Free /NOUNLOAD $1
    System::Free $6

    Pop $7
    Pop $6
    Pop $5
    Pop $4
    Pop $3
    Pop $2
    Pop $1
    Pop $0
!macroend

# end of define




!macro DEFINE_FUNC NAME
	${define} `${NAME}` `!insertmacro INSERT_FUNC_${NAME} "${NAME}" ""`
	${define} `un.${NAME}` `!insertmacro INSERT_FUNC_${NAME} "${NAME}" un.`
!macroend

!macro DEFINE_CALL NAME UNFIX
	!undef `${UNFIX}${NAME}`
	!define `${UNFIX}${NAME}` `!insertmacro CALL_FUNC_${NAME} "${NAME}" "${UNFIX}"`
!macroend

!macro DEFINE_FUNC_LITE NAME
	${define} `${NAME}` `!insertmacro INSERT_FUNC_LITE_${NAME}`
!macroend

!ifdef SECTION_DEPAND
	Var USF_FUNC_TEMP
!endif



!ifdef <Macro>
!endif
 
###############################################################
# 函数: IsWinNT
###############################################################
!insertmacro DEFINE_FUNC_LITE IsWinNT
!macro INSERT_FUNC_LITE_IsWinNT ResultVar
	ReadRegStr ${ResultVar} HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion" CurrentVersion
	${If} ${ResultVar} == ""
		StrCpy ${ResultVar} 0
	${Else}
		StrCpy ${ResultVar} 1
	${EndIf}
!macroend

###############################################################
# 函数: GetPlatformId
###############################################################
!insertmacro DEFINE_FUNC_LITE GetPlatformId
!macro INSERT_FUNC_LITE_GetPlatformId ResultVar
	;typedef struct _OSVERSIONINFOA {
	;    DWORD dwOSVersionInfoSize;
	;    DWORD dwMajorVersion;
	;    DWORD dwMinorVersion;
	;    DWORD dwBuildNumber;
	;    DWORD dwPlatformId;
	;    CHAR   szCSDVersion[ 128 ];     // Maintenance string for PSS usage
	;} OSVERSIONINFOA, *POSVERSIONINFOA, *LPOSVERSIONINFOA;

	;sizeof(OSVERSIONINFOA) == 148
	System::Call /NOUNLOAD '*(i 148, i, i, i, i, &t128) i .s'
	Exch $R0
	System::Call /NOUNLOAD 'Kernel32::GetVersionExA(i R0) i'
	System::Call /NOUNLOAD '*$R0(i 148, i, i, i, i .s, &t128)'
	System::Free $R0
	Exch
	Pop $R0
	Pop ${ResultVar}
!macroend

###############################################################
# 函数: GetWinName
###############################################################
!insertmacro DEFINE_FUNC_LITE GetWinName
!macro INSERT_FUNC_LITE_GetWinName ResultVar
	ReadRegStr ${ResultVar} HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion" CurrentVersion
	${If} ${ResultVar} == ""
		ReadRegStr ${ResultVar} HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion" ProductName
	${Else}
		ReadRegStr ${ResultVar} HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion" ProductName
	${EndIf}
!macroend

###############################################################
# 函数: GetInstallerName
###############################################################
!insertmacro DEFINE_FUNC_LITE GetInstallerName
!macro INSERT_FUNC_LITE_GetInstallerName ResultVar
	System::Call 'kernel32::GetModuleFileNameA(i 0, t .s, i ${NSIS_MAX_STRLEN}) i'
	Pop `${ResultVar}`
!macroend

###############################################################
# 函数: GetVolume
###############################################################
!insertmacro DEFINE_FUNC_LITE GetVolume
!macro INSERT_FUNC_LITE_GetVolume ResultVar Drive
	System::Call 'kernel32::GetVolumeInformation(t "${Drive}", t .s , i 255, *i, *i, *i, *i, i 255) i'
	Pop `${ResultVar}`
!macroend

###############################################################
# 函数: GetLocaleInfo
###############################################################
!insertmacro DEFINE_FUNC_LITE GetLocaleInfo
!macro INSERT_FUNC_LITE_GetLocaleInfo ResultVar INFOMATION
	System::Call "Kernel32::GetLocaleInfo(i ${LOCALE_SYSTEM_DEFAULT},i ${INFOMATION},t .s,i ${NSIS_MAX_STRLEN}) i"
	Pop `${ResultVar}`
!macroend

###############################################################
# 函数: GetComputerName
###############################################################
!insertmacro DEFINE_FUNC_LITE GetComputerName
!macro INSERT_FUNC_LITE_GetComputerName ResultVar
	ReadRegStr ${ResultVar} HKLM "System\CurrentControlSet\Control\ComputerName\ComputerName" "Computername"
!macroend

###############################################################
# 函数: CloseApp
###############################################################
!insertmacro DEFINE_FUNC_LITE CloseApp
!macro INSERT_FUNC_LITE_CloseApp CLASS
	Push `${CLASS}`
	Exch $1
	Push $0
	FindWindow $0 $1
	IntCmp $0 0 +2
	SendMessage $0 ${WM_CLOSE} 0 0
	Pop $0
	Pop $1
!macroend

###############################################################
# 函数: GetUserName
###############################################################
!insertmacro DEFINE_FUNC_LITE GetUserName
!macro INSERT_FUNC_LITE_GetUserName ResultVar
	System::Call "advapi32::GetUserName(t .s, *i 1024) i"
	Pop `${ResultVar}`
!macroend

###############################################################
# 函数: RefreshIcon
###############################################################
!insertmacro DEFINE_FUNC_LITE RefreshIcon
!macro INSERT_FUNC_LITE_RefreshIcon
	System::Call 'shell32.dll::SHChangeNotify(l, l, i, i) v (0x08000000, 0, 0, 0)'
!macroend

###############################################################
# 函数: TrimDir
###############################################################
!insertmacro DEFINE_FUNC_LITE TrimDir
!macro INSERT_FUNC_LITE_TrimDir DIR_VAR
	Push ${DIR_VAR}
	Exch $R1
	Push $R0
	StrCpy $R0 $R1 "" -1
	StrCmp $R0 "\" 0 +2
	StrCpy $R1 $R1 -1
	Pop $R0
	Exch $R1
	Pop ${DIR_VAR}
!macroend

###############################################################
# 函数: LoadImage
###############################################################
!insertmacro DEFINE_FUNC_LITE LoadImage
!macro INSERT_FUNC_LITE_LoadImage OUTPUT HWNDCTL IMGNAME IMGTYPE
	Push ${HWNDCTL}
	Push `${IMGNAME}`
    System::Call 'Kernel32::GetModuleHandle(t) i (0) .s'
	System::Call 'user32::LoadImageA(i, t, i, i, i, i) i \
	(s, s, ${IMGTYPE}, 0, 0, ${LR_CREATEDIBSECTION}|${LR_LOADFROMFILE}) .s'
	Exch $R1
	Exch
	Exch $R0
	SendMessage $R0 ${STM_SETIMAGE} ${IMGTYPE} $R1 ;载入的图像句柄
	Push $R1
	Exch 2
	Pop $R1
	Pop $R0
	Pop ${OUTPUT} ;载入的图像句柄
!macroend

###############################################################
# 函数: DeleteObject
###############################################################
!insertmacro DEFINE_FUNC_LITE DeleteObject
!macro INSERT_FUNC_LITE_DeleteObject HWND
	System::Call 'Gdi32::DeleteObject(i) i (${HWND})' 
!macroend

###############################################################
# 函数: DestroyCursor
###############################################################
!insertmacro DEFINE_FUNC_LITE DestroyCursor
!macro INSERT_FUNC_LITE_DestroyCursor HWND
	System::Call 'Gdi32::DestroyCursor(i) i (${HWND})' 
!macroend

###############################################################
# 函数: DestroyIcon
###############################################################
!insertmacro DEFINE_FUNC_LITE DestroyIcon
!macro INSERT_FUNC_LITE_DestroyIcon HWND
	System::Call 'Gdi32::DestroyIcon(i) i (${HWND})' 
!macroend

###############################################################
# 函数: SecDepandInit
# 应该用在 Function .onInit 里
###############################################################
!insertmacro DEFINE_FUNC_LITE SecDepandInit
!macro INSERT_FUNC_LITE_SecDepandInit
	Push $R0
	Push $R1
	Push $R2
	Push $R3
	Push $R4
	Push $R5
	
	StrCpy $R1 0
	ClearErrors
	${Do}
		SectionGetFlags $R1 $R0
		${IfThen} ${Errors} ${|} ${ExitDo} ${|}
		IntOp $R4 $R1 / 2
		StrCpy $R2 $USF_FUNC_TEMP $R4
		StrCpy $R3 $USF_FUNC_TEMP 1 $R4
		IntFmt $R3 `%d` 0x$R3
		IntOp $R4 $R1 % 2
		IntOp $R4 $R4 + 2
		IntOp $R5 1 << $R4
		IntOp $R5 $R5 ~
		IntOp $R3 $R3 & $R5
		IntOp $R0 $R0 & ${SF_SELECTED}
		IntOp $R0 $R0 << $R4
		IntOp $R3 $R3 | $R0
		IntFmt $R3 %x $R3
		StrCpy $USF_FUNC_TEMP `$R2$R3`
		
		IntOp $R1 $R1 + 1
	${Loop}
	
	Pop $R5
	Pop $R4
	Pop $R3
	Pop $R2
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: SecDepandStart
# 应该用在 Function .onSelChange 里
###############################################################
!insertmacro DEFINE_FUNC_LITE SecDepandStart
!macro INSERT_FUNC_LITE_SecDepandStart SECTION
	!ifndef SECTION_DEPAND
		!error `没有定义 SECTION_DEPAND`
	!endif
	${define} SECTION_DEPAND_START ``
	
	Push $R0
	Push $R1
	Push $R2
	Push $R3
	Push $R4
	Push $R5
	
	IntOp $R0 ${SECTION} / 2
	StrCpy $R1 $USF_FUNC_TEMP 1 $R0
	IntFmt $R1 `%d` 0x$R1
	StrCpy $R2 $USF_FUNC_TEMP $R0
	IntOp $R0 $R0 + 1
	StrCpy $R3 $USF_FUNC_TEMP `` $R0
	
	IntOp $R0 ${SECTION} % 2
	SectionGetFlags ${SECTION} $R4
	IntOp $R4 $R4 & ${SF_SELECTED}
	IntOp $R4 $R4 << $R0
	IntOp $R5 1 << $R0
	IntOp $R5 $R5 ~
	IntOp $R1 $R1 & $R5
	IntOp $R1 $R1 | $R4
	IntFmt $R1 `%X` $R1
	StrCpy $USF_FUNC_TEMP `$R2$R1$R3`
	
	Pop $R5
	Pop $R4
	Pop $R3
	Pop $R2
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: SecDepandEnd
# 应该用在 Function .onSelChange 里
###############################################################
!insertmacro DEFINE_FUNC_LITE SecDepandEnd
!macro INSERT_FUNC_LITE_SecDepandEnd SECTION
	!ifndef SECTION_DEPAND
		!error `没有定义 SECTION_DEPAND`
	!endif
	!ifndef SECTION_DEPAND_START & SECTION_DEPAND_BODY
		!error `请先使用 ${SecDepandStart} 和 ${SecDepand}`
	!endif
	
	Push $R0
	Push $R1
	Push $R2
	Push $R3
	Push $R4
	Push $R5
	
	IntOp $R0 ${SECTION} / 2
	StrCpy $R1 $USF_FUNC_TEMP 1 $R0
	IntFmt $R1 `%d` 0x$R1
	StrCpy $R2 $USF_FUNC_TEMP $R0
	IntOp $R0 $R0 + 1
	StrCpy $R3 $USF_FUNC_TEMP `` $R0
	
	IntOp $R0 ${SECTION} % 2
	IntOp $R5 1 << $R0
	IntOp $R4 $R5 & $R1
	IntOp $R4 $R4 << 2
	IntOp $R5 $R5 << 2
	IntOp $R5 $R5 ~
	IntOp $R1 $R1 & $R5
	IntOp $R1 $R1 | $R4
	IntFmt $R1 `%X` $R1
	StrCpy $USF_FUNC_TEMP `$R2$R1$R3`
	
	Pop $R5
	Pop $R4
	Pop $R3
	Pop $R2
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: SecDepand
# 应该用在 Function .onSelChange 里
###############################################################
!insertmacro DEFINE_FUNC_LITE SecDepand
!macro INSERT_FUNC_LITE_SecDepand PARENT CHILD
	!ifndef SECTION_DEPAND
		!error `没有定义 SECTION_DEPAND`
	!endif
	!ifndef SECTION_DEPAND_START
		!error `请先使用 ${SecDepandStart}`
	!endif
	${define} SECTION_DEPAND_BODY ``
	
	Push $R0
	Push $R1
	Push $R2
	Push $R3
	Push $R4
	Push $R5
	
	IntOp $R0 ${PARENT} / 2
	StrCpy $R1 $USF_FUNC_TEMP 1 $R0
	IntFmt $R1 `%d` 0x$R1
	StrCpy $R2 $USF_FUNC_TEMP $R0
	IntOp $R0 $R0 + 1
	StrCpy $R3 $USF_FUNC_TEMP `` $R0
	
	IntOp $R0 ${PARENT} % 2
	IntOp $R4 1 << $R0
	IntOp $R5 $R4 << 2
	IntOp $R4 $R4 & $R1
	IntOp $R5 $R5 & $R1

	${Unless} $R4 = $R5
	
		SectionGetFlags ${PARENT} $R4
		IntOp $R4 $R4 & ${SF_SELECTED}
		${Unless} $R4 = ${SF_SELECTED}
			!insertmacro UnSelectSection ${CHILD}
			IntOp $R0 ${CHILD} / 2
			StrCpy $R1 $USF_FUNC_TEMP 1 $R0
			IntFmt $R1 `%d` 0x$R1
			StrCpy $R2 $USF_FUNC_TEMP $R0
			IntOp $R0 $R0 + 1
			StrCpy $R3 $USF_FUNC_TEMP `` $R0
			
			IntOp $R0 ${CHILD} % 2
			IntOp $R4 1 << $R0
			IntOp $R4 $R4 ~
			IntOp $R1 $R4 & $R1
			IntFmt $R1 `%X` $R1
			StrCpy $USF_FUNC_TEMP `$R2$R1$R3`
		${EndUnless}
		
	${Else}
	
		${SecDepandStart} ${CHILD}
		
		IntOp $R0 ${CHILD} / 2
		StrCpy $R1 $USF_FUNC_TEMP 1 $R0
		IntFmt $R1 `%d` 0x$R1
		StrCpy $R2 $USF_FUNC_TEMP $R0
		IntOp $R0 $R0 + 1
		StrCpy $R3 $USF_FUNC_TEMP $R0
		
		IntOp $R0 ${CHILD} % 2
		IntOp $R4 1 << $R0
		IntOp $R5 $R4 << 2
		IntOp $R4 $R4 & $R1
		IntOp $R5 $R5 & $R1
		${Unless} $R4 = $R5
			SectionGetFlags ${CHILD} $R4
			IntOp $R4 $R4 & ${SF_SELECTED}
			${If} $R4 = ${SF_SELECTED}
				!insertmacro SelectSection ${PARENT}
				IntOp $R0 ${PARENT} / 2
				StrCpy $R1 $USF_FUNC_TEMP 1 $R0
				IntFmt $R1 `%d` 0x$R1
				StrCpy $R2 $USF_FUNC_TEMP $R0
				IntOp $R0 $R0 + 1
				StrCpy $R3 $USF_FUNC_TEMP `` $R0
				
				IntOp $R0 ${PARENT} % 2
				IntOp $R4 1 << $R0
				IntOp $R1 $R4 | $R1
				IntFmt $R1 `%X` $R1
				StrCpy $USF_FUNC_TEMP `$R2$R1$R3`
			${EndIf}
		${EndUnless}
	
	${EndUnless}
	
	!ifdef SubSecDepand
		!undef SubSecDepand
	!else
		${SecDepandEnd} ${CHILD}
	!endif
	
	Pop $R5
	Pop $R4
	Pop $R3
	Pop $R2
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: DeleteFile
###############################################################
!insertmacro DEFINE_FUNC_LITE DeleteFile
!macro INSERT_FUNC_LITE_DeleteFile lpFileName
	SetFileAttributes `${lpFileName}` NORMAL
	Push `${lpFileName}`
	System::Call `Kernel32::DeleteFile(t) i (s) .s`
	Exch $0
	${IfThen} $0 = 0 ${|} SetErrors ${|}
	Pop $0
!macroend

###############################################################
# 函数: MoveFile
###############################################################
!insertmacro DEFINE_FUNC_LITE MoveFile
!macro INSERT_FUNC_LITE_MoveFile lpExistingFileName lpNewFileName
	${If} ${FileExists} '${lpExistingFileName}'
	${AndIf} ${FileExists} `${lpNewFileName}`
		${DeleteFile} `${lpNewFileName}`
	${EndIf}
	Push '${lpNewFileName}'
	Push '${lpExistingFileName}'
	System::Call `Kernel32::MoveFile(t,t) i (s,s) .s`
	Exch $0
	${IfThen} $0 = 0 ${|} SetErrors ${|}
	Pop $0
!macroend

###############################################################
# 函数: CopyFile
###############################################################
!insertmacro DEFINE_FUNC_LITE CopyFile
!macro INSERT_FUNC_LITE_CopyFile lpExistingFileName lpNewFileName
	Push '${lpNewFileName}'
	Push '${lpExistingFileName}'
	System::Call `Kernel32::CopyFile(t,t,i) i (s,s,0) .s`
	Exch $0
	${IfThen} $0 = 0 ${|} SetErrors ${|}
	Pop $0
!macroend

###############################################################
# 函数: IsWritable
###############################################################
!insertmacro DEFINE_FUNC_LITE IsWritable
!macro INSERT_FUNC_LITE_IsWritable ResultVar File
	Push `${File}`
	Exch $0
	${If} ${FileExists} $0
		FileOpen $0 $0 a
		${If} $0 == ``
			StrCpy $0 0
		${Else}
			FileClose $0
			StrCpy $0 1
		${EndIf}
	${Else}
		StrCpy $0 -1
	${EndIf} 
	Exch $0
	Pop ${ResultVar}
!macroend

###############################################################
# 函数: FileTimeCmp
###############################################################
!insertmacro DEFINE_FUNC_LITE FileTimeCmp
!macro INSERT_FUNC_LITE_FileTimeCmp ResultVar File1 File2
	Push `${File2}`
	Push `${File1}`
	Exch $0
	Exch
	Exch $1
	Push $2
	Push $3
	Push $4
		SetPluginUnload alwaysoff
		System::Call `*(&i4, &i4) i .r2`
		FileOpen $4 $0 r
		System::Call `kernel32::GetFileTime(i,i,i,i) i (r4,0,0,r2)`
		FileClose $4
		
		System::Call `*(&i4, &i4) i .r3`
		FileOpen $4 $1 r
		System::Call `kernel32::GetFileTime(i,i,i,i) i (r4,0,0,r3)`
		FileClose $4
		
		System::Call `Kernel32::CompareFileTime(i, i) i (r2, r3) .s`
		System::Free $0
		SetPluginUnload manual
		System::Free $1
	Exch 5
	Pop $0
	Pop $4
	Pop $3
	Pop $2
	Pop $1
	Pop ${ResultVar}
!macroend

###############################################################
# 函数: GetDllVersion
###############################################################
!insertmacro DEFINE_FUNC_LITE GetDllVersion
!macro INSERT_FUNC_LITE_GetDllVersion ResultVar DllFile
	Push `${DllFile}`
	Exch $0
	Push $1
	Push $2
	Push $3
	Push $4
		GetDllVersion $0 $1 $2
		IntOp $3 $1 / 0x00010000
		IntOp $1 $1 & 0x0000FFFF
		IntOp $4 $2 / 0x00010000
		IntOp $2 $2 & 0x0000FFFF
		StrCpy $0 "$3.$1.$4.$2"
	Pop $4
	Pop $3
	Pop $2
	Pop $1
	Exch $0
	Pop ${ResultVar}
!macroend

###############################################################
# 函数: UpperDrvChar
###############################################################
!insertmacro DEFINE_FUNC_LITE UpperDrvChar
!macro INSERT_FUNC_LITE_UpperDrvChar IOVar
	Push `${IOVar}`
	Exch $0
	Push $1
		StrCpy $1 $0 2 1
		${If} $1 == `:\`
			StrCpy $1 $0 1
			Push $1
			System::Call "User32::CharUpper(t s s)i"
			Pop $1
			StrCpy $0 $0 `` 1
			StrCpy $0 $1$0
		${EndIf}
	Pop $1
	Exch $0
	Pop ${IOVar}
!macroend

###############################################################
# 函数: IsSectionSelected
###############################################################
!insertmacro DEFINE_FUNC_LITE IsSectionSelected
!macro INSERT_FUNC_LITE_IsSectionSelected ResultVar Section
	Push `${Section}`
	Exch $0
		SectionGetFlags $0 $0
		IntOp $0 $0 & 1
	Exch $0
	Pop ${ResultVar}
!macroend

###############################################################
# 函数: IsSubSection
###############################################################
!insertmacro DEFINE_FUNC_LITE IsSubSection
!macro INSERT_FUNC_LITE_IsSubSection ResultVar Section
	Push `${Section}`
	Exch $0
		SectionGetFlags $0 $0
		IntOp $0 $0 & 2
		IntOp $0 $0 >> 1
	Exch $0
	Pop ${ResultVar}
!macroend

###############################################################
# 函数: IsSubSectionEnd
###############################################################
!insertmacro DEFINE_FUNC_LITE IsSubSectionEnd
!macro INSERT_FUNC_LITE_IsSubSectionEnd ResultVar Section
	Push `${Section}`
	Exch $0
		SectionGetFlags $0 $0
		IntOp $0 $0 & 4
		IntOp $0 $0 >> 2
	Exch $0
	Pop ${ResultVar}
!macroend

###############################################################
# 函数: IsSectionBold
###############################################################
!insertmacro DEFINE_FUNC_LITE IsSectionBold
!macro INSERT_FUNC_LITE_IsSectionBold ResultVar Section
	Push `${Section}`
	Exch $0
		SectionGetFlags $0 $0
		IntOp $0 $0 & 8
		IntOp $0 $0 >> 4
	Exch $0
	Pop ${ResultVar}
!macroend

###############################################################
# 函数: IsSectionReadOnly
###############################################################
!insertmacro DEFINE_FUNC_LITE IsSectionReadOnly
!macro INSERT_FUNC_LITE_IsSectionReadOnly ResultVar Section
	Push `${Section}`
	Exch $0
		SectionGetFlags $0 $0
		IntOp $0 $0 & 16
		IntOp $0 $0 >> 8
	Exch $0
	Pop ${ResultVar}
!macroend

###############################################################
# 函数: IsSectionExpanded
###############################################################
!insertmacro DEFINE_FUNC_LITE IsSectionExpanded
!macro INSERT_FUNC_LITE_IsSectionExpanded ResultVar Section
	Push `${Section}`
	Exch $0
		SectionGetFlags $0 $0
		IntOp $0 $0 & 32
		IntOp $0 $0 >> 16
	Exch $0
	Pop ${ResultVar}
!macroend

###############################################################
# 函数: IsSectionPartiallySelected
###############################################################
!insertmacro DEFINE_FUNC_LITE IsSectionPartiallySelected
!macro INSERT_FUNC_LITE_IsSectionPartiallySelected ResultVar Section
	Push `${Section}`
	Exch $0
		SectionGetFlags $0 $0
		IntOp $0 $0 & 64
		IntOp $0 $0 >> 32
	Exch $0
	Pop ${ResultVar}
!macroend

###############################################################
# 函数: MessageBox
###############################################################
!insertmacro DEFINE_FUNC_LITE MessageBox
!macro INSERT_FUNC_LITE_MessageBox ReturnValue lpText lpCaption uType
;int MessageBox(
;    HWND hWnd,
;    LPCTSTR lpText,
;    LPCTSTR lpCaption,
;    UINT uType
;);	
	Push `${lpCaption}`
	Push `${lpText}`
	System::Call `User32::MessageBoxA(i,t,t,i) i ($HWNDPARENT,s,s,${uType}) .s`
	Pop ${ReturnValue}
!macroend

###############################################################
# 函数: MessageBox2
###############################################################
!insertmacro DEFINE_FUNC_LITE MessageBox2
!macro INSERT_FUNC_LITE_MessageBox2 lpText lpCaption uType
;int MessageBox(
;    HWND hWnd,
;    LPCTSTR lpText,
;    LPCTSTR lpCaption,
;    UINT uType
;);
	Push `${lpCaption}`
	Push `${lpText}`
	System::Call `User32::MessageBoxA(i,t,t,i) i ($HWNDPARENT,s,s,${uType})`
!macroend

###############################################################
# 函数: LogSet
###############################################################
!insertmacro DEFINE_FUNC_LITE LogSet
!macro INSERT_FUNC_LITE_LogSet Switch
!ifdef NSIS_CONFIG_LOG
	LogSet ${Switch}
!else
	!warning `NSIS_CONFIG_LOG haven't defined, skipping LogSet`
!endif
!macroend

###############################################################
# 函数: TrimRN
###############################################################
!insertmacro DEFINE_FUNC_LITE TrimRN

!macro INSERT_FUNC_LITE_TrimRN Var
	Push ${Var}
	
	Exch $R0
	Push $R1
	
	StrCpy $R1 $R0 1 -1
	${If} $R1 == `$\r`
	${OrIf} $R1 == `$\n`
		StrCpy $R0 $R0 -1
	${EndIf}

	StrCpy $R1 $R0 1 -1
	${If} $R1 == `$\r`
	${OrIf} $R1 == `$\n`
		StrCpy $R0 $R0 -1
	${EndIf}
	
	Pop $R1
	Exch $R0
	Pop ${Var}
!macroend

###############################################################
# 函数: SetOutPath
###############################################################
!insertmacro DEFINE_FUNC_LITE SetOutPath

!macro INSERT_FUNC_LITE_SetOutPath OUT_PATH
	StrCpy $OUTDIR `${OUT_PATH}`
	Push `${OUT_PATH}`
	System::Call "Kernel32::SetCurrentDirectory(t)i(s)"
!macroend

###############################################################
# 函数: AddBackslash
###############################################################
!insertmacro DEFINE_FUNC_LITE AddBackslash

!macro INSERT_FUNC_LITE_AddBackslash PATH 
	Push `${PATH}`
	System::Call `Shlwapi::PathAddBackslash(t) t (ss)`
	Pop ${PATH}
!macroend

###############################################################
# 函数: RemoveBackslash
###############################################################
!insertmacro DEFINE_FUNC_LITE RemoveBackslash

!macro INSERT_FUNC_LITE_RemoveBackslash PATH
	Push `${PATH}`
	System::Call `Shlwapi::PathRemoveBackslash(t) t (ss)`
	Pop ${PATH}
!macroend

###############################################################
# 函数: CompactPathEx
###############################################################
!insertmacro DEFINE_FUNC_LITE CompactPathEx

!macro INSERT_FUNC_LITE_CompactPathEx OUTPUT PATH NUMBER 
	Push `${PATH}`
	System::Call "Shlwapi::PathCompactPathEx(t, t, i, i) i (.s, s, ${NUMBER}, 0)"
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: FindExtension
###############################################################
!insertmacro DEFINE_FUNC_LITE FindExtension

!macro INSERT_FUNC_LITE_FindExtension OUTPUT PATH 
	Push `${PATH}`
	System::Call "Shlwapi::PathFindExtension(t) t (s) .s"
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: FindFileName
###############################################################
!insertmacro DEFINE_FUNC_LITE FindFileName

!macro INSERT_FUNC_LITE_FindFileName OUTPUT PATH 
	Push `${PATH}`
	System::Call "Shlwapi::PathFindFileName(t) t (s) .s"
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: RemoveExtension
###############################################################
!insertmacro DEFINE_FUNC_LITE RemoveExtension

!macro INSERT_FUNC_LITE_RemoveExtension IOSTR
	Push `${IOSTR}`
	System::Call "Shlwapi::PathRemoveExtension(t) v (ss)"
	Pop ${IOSTR}
!macroend

###############################################################
# 函数: RemoveFileSpec
###############################################################
!insertmacro DEFINE_FUNC_LITE RemoveFileSpec

!macro INSERT_FUNC_LITE_RemoveFileSpec IOSTR
	Push `${IOSTR}`
	System::Call "Shlwapi::PathRemoveFileSpec(t) i (ss)"
	Pop ${IOSTR}
!macroend

###############################################################
# 函数: RenameExtension
###############################################################
!insertmacro DEFINE_FUNC_LITE RenameExtension

!macro INSERT_FUNC_LITE_RenameExtension IOSTR EXTENSION
	Push `${EXTENSION}`
	Push `${IOSTR}`
	System::Call "Shlwapi::PathRenameExtension(t, t) i (ss, s)"
	Pop ${IOSTR}
!macroend

###############################################################
# 函数: RelativePathTo
###############################################################
!insertmacro DEFINE_FUNC_LITE RelativePathTo

!macro INSERT_FUNC_LITE_RelativePathTo OUTPUT RELATIVEPATHFROM RELATIVEPATHTO
	Push `${RELATIVEPATHTO}`
	Push `${RELATIVEPATHFROM}`
	System::Call "Shlwapi::PathRelativePathTo(t, t, i, t, i) i\
		(.s, s, ${FILE_ATTRIBUTE_DIRECTORY}, s, ${FILE_ATTRIBUTE_NORMAL})"
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: PathCanonicalize
###############################################################
!insertmacro DEFINE_FUNC_LITE PathCanonicalize

!macro INSERT_FUNC_LITE_PathCanonicalize OUTPUT RELATIVEPATH
	Push `${RELATIVEPATH}`
	System::Call "Shlwapi::PathCanonicalize(t, t) i (.s, s)"
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: RemoveArgs
###############################################################
!insertmacro DEFINE_FUNC_LITE RemoveArgs

!macro INSERT_FUNC_LITE_RemoveArgs IOPATH
	Push `${IOPATH}`
	System::Call "Shlwapi::PathRemoveArgs(t) v (ss)"
	Pop ${IOPATH}
!macroend

###############################################################
# 函数: SHCopyKey
###############################################################
!insertmacro DEFINE_FUNC_LITE SHCopyKey

!macro INSERT_FUNC_LITE_SHCopyKey ROOT_SRC KEY_SRC ROOT_DEST KEY_DEST
	Push `${KEY_SRC}`
	Push `${ROOT_SRC}`
	Push `${KEY_DEST}`
	Push `${ROOT_DEST}`
	Push $R0
	Push $R1
	Exch 2
	Exch
	Exch 3
	Exch
	System::Call /NOUNLOAD "*(i 0) i .R0"
	System::Call /NOUNLOAD "${RegCreateKey}(s, s, R0) .R1"
	${If} $R1 == ${ERROR_SUCCESS}
	    System::Call /NOUNLOAD "*$R0(&i4 .R1)"
		Exch 2
		Exch
		Exch 3
		Exch
		System::Call /NOUNLOAD "Shlwapi::SHCopyKey(i, t, i, i) i (s, s, R1, 0) .R1"
		${If} $R1 != ${ERROR_SUCCESS}
		    SetErrors
		${EndIf}
	${Else}
		SetErrors
	${EndIf}
	System::Call /NOUNLOAD "${RegCloseKey}(R1)"
	System::Free $R0
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: SHRegGetPath
###############################################################
!insertmacro DEFINE_FUNC_LITE SHRegGetPath

!macro INSERT_FUNC_LITE_SHRegGetPath OUTPUT ROOT_KEY SUB_KEY VALUE
	Push `${VALUE}`
	Push `${SUB_KEY}`
	System::Call "Shlwapi::SHRegGetPath(i, t, t, t, i) i (${ROOT_KEY}, s, s, .s, 0)"
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: GetRegKeyCount
###############################################################
!insertmacro DEFINE_FUNC_LITE GetRegKeyCount
!define GetRegKeyNum `${GetRegKeyCount}` ;保持兼容

!macro INSERT_FUNC_LITE_GetRegKeyCount OUTPUT ROOT KEY
	Push `${KEY}`
	Push `${ROOT}`
	Push $R0
	Push $R1
	Exch 2
	Exch
	Exch 3
	Exch
	System::Call /NOUNLOAD "*(i 0) i .R0"
	System::Call /NOUNLOAD "${RegOpenKey}(s, s, R0)"
	Push $R0
	System::Call /NOUNLOAD "*$R0(&i4 .R0)"
	System::Call /NOUNLOAD "*(i 0) i .R1"
	System::Call /NOUNLOAD "${RegQueryInfoKey}(R0, i 0, 0, 0, R1, 0, 0, 0, 0, 0, 0, 0)"
	System::Call /NOUNLOAD "*$R1(i .s)"
	System::Free /NOUNLOAD $R1
	System::Call /NOUNLOAD "${RegCloseKey}(R0)"
	Exch
	Pop $R0
	System::Free $R0
	Exch
	Pop $R1
	Exch
	Pop $R0
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: GetRegValueCount
###############################################################
!insertmacro DEFINE_FUNC_LITE GetRegValueCount
!define GetRegValueNum `${GetRegValueCount}` ;保持兼容

!macro INSERT_FUNC_LITE_GetRegValueCount OUTPUT ROOT KEY
	Push `${KEY}`
	Push `${ROOT}`
	Push $R0
	Push $R1
	Exch 2
	Exch
	Exch 3
	Exch
	System::Call /NOUNLOAD "*(i 0) i .R0"
	System::Call /NOUNLOAD "${RegOpenKey}(s, s, R0)"
	Push $R0
	System::Call /NOUNLOAD "*$R0(&i4 .R0)"
	System::Call /NOUNLOAD "*(i 0) i .R1"
	System::Call /NOUNLOAD "${RegQueryInfoKey}(R0, i 0, 0, 0, 0, 0, 0, R1, 0, 0, 0, 0)"
	System::Call /NOUNLOAD "*$R1(i .s)"
	System::Free /NOUNLOAD $R1
	System::Call /NOUNLOAD "${RegCloseKey}(R0)"
	Exch
	Pop $R0
	System::Free $R0
	Exch
	Pop $R1
	Exch
	Pop $R0
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: GetFileSize
###############################################################
!insertmacro DEFINE_FUNC_LITE GetFileSize

!macro INSERT_FUNC_LITE_GetFileSize OUTPUT FILE
	Push `${FILE}`
	Exch $R0
	Push $R1
    FileOpen $R1 $R0 r
    System::Call "Kernel32::GetFileSize(i, i) i (R1, 0) .s"
    FileClose $R1
    Exch
    Pop $R1
    Exch
    Pop $R0
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: StrStr
###############################################################
!insertmacro DEFINE_FUNC_LITE StrStr

!macro INSERT_FUNC_LITE_StrStr OUTPUT STRING TOSREACH
	Push `${TOSREACH}`
	Push `${STRING}`
	System::Call "Shlwapi::StrStr(t, t) t (s, s) .s"
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: StrStrI
###############################################################
!insertmacro DEFINE_FUNC_LITE StrStrI

!macro INSERT_FUNC_LITE_StrStrI OUTPUT STRING TOSREACH
	Push `${TOSREACH}`
	Push `${STRING}`
	System::Call "Shlwapi::StrStrI(t, t) t (s, s) .s"
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: StrRStrI
###############################################################
!insertmacro DEFINE_FUNC_LITE StrRStrI

!macro INSERT_FUNC_LITE_StrRStrI OUTPUT STRING TOSREACH
	Push `${TOSREACH}`
	Push `${STRING}`
	System::Call "Shlwapi::StrRStrI(t, t) t (s, s) .s"
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: ClearDetail
###############################################################
!insertmacro DEFINE_FUNC_LITE ClearDetail

!macro INSERT_FUNC_LITE_ClearDetail
	Push $R0
	FindWindow $R0 "#32770" "" $HWNDPARENT
	GetDlgItem $R0 $R0 1016
	SendMessage $R0 0x1009 0 0
	Pop $R0
!macroend

###############################################################
# 函数: ConvertANSIToUTF16
###############################################################
!insertmacro DEFINE_FUNC_LITE ConvertANSIToUTF16

!macro INSERT_FUNC_LITE_ConvertANSIToUTF16 OUTPUT CODEPAGE STRING
    Push `${STRING}`
    Push `${CODEPAGE}`
    Exch $R0 ;代码页
    Exch
    Exch $R1 ;要转换的字串
    Push $R2
    
	StrLen $R2 $R1
	IntOp $R2 $R2 + 1
	IntOp $R2 $R2 * 2
	System::Alloc /NOUNLOAD $R2
	Pop $R2
	System::Call /NOUNLOAD "${MultiByteToWideChar}(R0, 0, R1, -1, i 0, 0) .s"
	System::Call "${MultiByteToWideChar}(R0, 0, R1, -1, i R2, s)"
	StrCpy $R0 $R2
	
	Pop $R2
	Pop $R1
	Exch $R0
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: ConvertUTF16ToANSI
###############################################################
!insertmacro DEFINE_FUNC_LITE ConvertUTF16ToANSI

!macro INSERT_FUNC_LITE_ConvertUTF16ToANSI OUTPUT CODEPAGE ADDRESS
    Push `${ADDRESS}`
    Push `${CODEPAGE}`
    Exch $R0 ;代码页
    Exch
    Exch $R1 ;要转换的字串地址

	System::Call /NOUNLOAD "${WideCharToMultiByte}(R0, 0, i R1, -1, i 0, 0, 0, 0) .s"
	System::Call /NOUNLOAD "${WideCharToMultiByte}(R0, 0, i R1, -1, .R0, s, 0, 0)"
	System::Free $R1

	Pop $R1
	Exch $R0
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: StartRadioButtons
###############################################################
!insertmacro DEFINE_FUNC_LITE StartRadioButtons

!macro INSERT_FUNC_LITE_StartRadioButtons VAR GROUP_SECTION
	!define STARTRADIOBUTTONS_VAR "${VAR}"
	!define STARTRADIOBUTTONS_GROUP "${GROUP_SECTION}"
	Push $R0
		SectionGetFlags "${STARTRADIOBUTTONS_VAR}" $R0
		IntOp $R0 $R0 & ${SECTION_OFF}
		SectionSetFlags "${STARTRADIOBUTTONS_VAR}" $R0
	Push $R1
		StrCpy $R1 "${STARTRADIOBUTTONS_VAR}"
!macroend

###############################################################
# 函数: RadioButton
###############################################################
!insertmacro DEFINE_FUNC_LITE RadioButton

!macro INSERT_FUNC_LITE_RadioButton SECTION_NAME
	!define RADIOBUTTON_LINE ${__LINE__}
	IntCmp ${STARTRADIOBUTTONS_GROUP} 0 0 +4
	SectionGetFlags ${STARTRADIOBUTTONS_GROUP} $R0
	IntOp $R0 $R0 & ${SF_PSELECTED}
	IntCmp $R0 ${SF_PSELECTED} 0 skip_${RADIOBUTTON_LINE} skip_${RADIOBUTTON_LINE}

	Push ${SECTION_NAME}
	Exch $R1
	SectionGetFlags $R1 $R0
	IntOp $R0 $R0 & ${SF_SELECTED}
	IntCmp $R0 ${SF_SELECTED} 0 +2 +2
	StrCpy "${STARTRADIOBUTTONS_VAR}" $R1
	Pop $R1

	skip_${RADIOBUTTON_LINE}:
	!undef RADIOBUTTON_LINE
!macroend

###############################################################
# 函数: EndRadioButtons
###############################################################
!insertmacro DEFINE_FUNC_LITE EndRadioButtons

!macro INSERT_FUNC_LITE_EndRadioButtons
	StrCmp $R1 "${STARTRADIOBUTTONS_VAR}" 0 +4 ; selection hasn't changed
	SectionGetFlags "${STARTRADIOBUTTONS_VAR}" $R0
	IntOp $R0 $R0 | ${SF_SELECTED}
	SectionSetFlags "${STARTRADIOBUTTONS_VAR}" $R0

	${If} ${STARTRADIOBUTTONS_GROUP} >= 0
		SectionGetFlags ${STARTRADIOBUTTONS_GROUP} $R0
		IntOp $R0 $R0 & ${SF_PSELECTED}
		${If} $R0 <> ${SF_PSELECTED}
			!insertmacro UnselectSection ${STARTRADIOBUTTONS_GROUP}
			!insertmacro SelectSection $R1
		${EndIf}
	${EndIf}

	Pop $R1
	Pop $R0

	!undef STARTRADIOBUTTONS_VAR
	!undef STARTRADIOBUTTONS_GROUP
!macroend

###############################################################
# 函数: EndRadioButtons2
###############################################################
!insertmacro DEFINE_FUNC_LITE EndRadioButtons2

!macro INSERT_FUNC_LITE_EndRadioButtons2
	StrCmp $R1 "${STARTRADIOBUTTONS_VAR}" 0 +4 ; selection hasn't changed
	SectionGetFlags "${STARTRADIOBUTTONS_VAR}" $R0
	IntOp $R0 $R0 | ${SF_SELECTED}
	SectionSetFlags "${STARTRADIOBUTTONS_VAR}" $R0

	${If} ${STARTRADIOBUTTONS_GROUP} >= 0
		SectionGetFlags ${STARTRADIOBUTTONS_GROUP} $R0
		IntOp $R0 $R0 & ${SF_PSELECTED}
		${If} $R0 <> ${SF_PSELECTED}
			!insertmacro UnselectSection ${STARTRADIOBUTTONS_GROUP}
		${EndIf}
	${EndIf}

	Pop $R1
	Pop $R0

	!undef STARTRADIOBUTTONS_VAR
	!undef STARTRADIOBUTTONS_GROUP
!macroend

!ifdef "<Window/Control Functions>"
!endif

###############################################################
# 函数: GetDlgItemText
###############################################################
!insertmacro DEFINE_FUNC_LITE GetDlgItemText

!macro INSERT_FUNC_LITE_GetDlgItemText OUT HWNDDLG CTLID
	System::Call "User32::GetDlgItemTextA(i, i, t, i) i (${HWNDDLG}, ${CTLID}, .s, ${NSIS_MAX_STRLEN})"
	Pop ${OUT}
!macroend

###############################################################
# 函数: SetDlgItemText
###############################################################
!insertmacro DEFINE_FUNC_LITE SetDlgItemText

!macro INSERT_FUNC_LITE_SetDlgItemText HWNDDLG CTLID TEXT
	Push `${TEXT}`
	System::Call "User32::SetDlgItemTextA(i, i, t) i (${HWNDDLG}, ${CTLID}, s)"
!macroend

###############################################################
# 函数: GetDlgCtrlID
###############################################################
!insertmacro DEFINE_FUNC_LITE GetDlgCtrlID

!macro INSERT_FUNC_LITE_GetDlgCtrlID OUT HWNDCTL
	System::Call "User32::GetDlgCtrlID(i) i (${HWNDCTL}) .s"
	Pop ${OUT}
!macroend

###############################################################
# 函数: GetDlgItemRect
###############################################################
!insertmacro DEFINE_FUNC_LITE GetDlgItemRect

!macro INSERT_FUNC_LITE_GetDlgItemRect OUT_LEFT OUT_TOP OUT_RIGHT OUT_BOTTOM HWNDDLG CTLID
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
# 函数: DestroyWindow
###############################################################
!insertmacro DEFINE_FUNC_LITE DestroyWindow

!macro INSERT_FUNC_LITE_DestroyWindow HWNDDLG CTLID
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    GetDlgItem $R0 ${HWNDDLG} ${CTLID}
	System::Call 'User32::DestroyWindow(i) i ($R0) .s'
	Pop $R0
!macroend

###############################################################
# 函数: DestroyWindow2
###############################################################
!insertmacro DEFINE_FUNC_LITE DestroyWindow2

!macro INSERT_FUNC_LITE_DestroyWindow2 HWNDDLG CTLID
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    GetDlgItem $R0 ${HWNDDLG} ${CTLID}
	System::Call 'User32::DestroyWindow(i) i ($R0) .s'
	Pop $R0

  ButtonLinker::UnsetEventHandler /NOUNLOAD ${CTLID}
!macroend

###############################################################
# 函数: DestroyWindow3
###############################################################
!insertmacro DEFINE_FUNC_LITE DestroyWindow3

!macro INSERT_FUNC_LITE_DestroyWindow3 HWNDDLG
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
	System::Call 'User32::DestroyWindow(i) i (${HWNDDLG}) .s'
!macroend

###############################################################
# 函数: CreateLabel
###############################################################
!insertmacro DEFINE_FUNC_LITE CreateLabel

!macro INSERT_FUNC_LITE_CreateLabel TITLE LEFT TOP WIDTH HEIGHT HWNDPARENT CTLID
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
!insertmacro DEFINE_FUNC_LITE CreateButton

!macro INSERT_FUNC_LITE_CreateButton TITLE LEFT TOP WIDTH HEIGHT HWNDPARENT CTLID FUNADD
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
!insertmacro DEFINE_FUNC_LITE CreateLinker

!macro INSERT_FUNC_LITE_CreateLinker TEXT LEFT TOP WIDTH HEIGHT HWNDPARENT TARGET LINKADD
!ifdef NSIS_SUPPORT_CREATELINKER
	CreateLinker ${TEXT} ${LEFT} ${TOP} ${WIDTH} ${HEIGHT} ${HWNDPARENT} ${CTLID} ${LINKADD}
!endif
!ifndef NSIS_SUPPORT_CREATELINKER
!echo '警告: 您所用的 NSIS 不支持创建超级链接，请使用函数"CreateLinker2"与插件"ButtonLinker.dll"来实现'
!endif
!macroend

###############################################################
# 函数: CreateCheckbox
###############################################################
!insertmacro DEFINE_FUNC_LITE CreateCheckbox

!macro INSERT_FUNC_LITE_CreateCheckbox TITLE LEFT TOP WIDTH HEIGHT HWNDDLG CTLID
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    Push `${TITLE}`
	;Style = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_TABSTOP | BS_TEXT | BS_VCENTER | BS_AUTOCHECKBOX | BS_MULTILINE
	System::Call 'User32::CreateWindowEx(i,t,t,i,i,i,i,i,i,i,i,v) i (0,"BUTTON",s,0x54012C03,${LEFT},${TOP},${WIDTH},${HEIGHT},${HWNDDLG},${CTLID},s,0) .s'
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
!insertmacro DEFINE_FUNC_LITE CreateCheckbox2

!macro INSERT_FUNC_LITE_CreateCheckbox2 TITLE LEFT TOP WIDTH HEIGHT HWNDDLG CTLID STATE
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    Push `${TITLE}`
	;Style = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_TABSTOP | BS_TEXT | BS_VCENTER | BS_AUTOCHECKBOX | BS_MULTILINE
	System::Call 'User32::CreateWindowEx(i,t,t,i,i,i,i,i,i,i,i,v) i (0,"BUTTON",s,0x54012C03,${LEFT},${TOP},${WIDTH},${HEIGHT},${HWNDDLG},${CTLID},s,0) .s'
	Exch $R0
	Push $R1
	CreateFont $R1 $(^Font) $(^FontSize) ${FW_NORMAL}
	SendMessage $R0 ${WM_SETFONT} $R1 0
	System::Call 'User32::CheckDlgButton(i,i,i) i (${HWNDDLG},${CTLID},${STATE}) .s'

	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: CreateCheckbox3
###############################################################
!insertmacro DEFINE_FUNC_LITE CreateCheckbox3

!macro INSERT_FUNC_LITE_CreateCheckbox3 TITLE LEFT TOP WIDTH HEIGHT HWNDDLG CTLID STATE CHECKADD
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    Push `${TITLE}`
	;Style = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_TABSTOP | BS_TEXT | BS_VCENTER | BS_AUTOCHECKBOX | BS_MULTILINE
	System::Call 'User32::CreateWindowEx(i,t,t,i,i,i,i,i,i,i,i,v) i (0,"BUTTON",s,0x54012C03,${LEFT},${TOP},${WIDTH},${HEIGHT},${HWNDDLG},${CTLID},s,0) .s'
	Exch $R0
	Push $R1
	CreateFont $R1 $(^Font) $(^FontSize) ${FW_NORMAL}
	SendMessage $R0 ${WM_SETFONT} $R1 0
;	SendMessage $R0 ${BM_SETCHECK} ${STATE} 0
	System::Call 'User32::CheckDlgButton(i,i,i) i (${HWNDDLG},${CTLID},${STATE}) .s'
;	SendMessage $R0 ${BM_SETSTATE} ${STATE} 0
	GetFunctionAddress $R2 ${CHECKADD}
	ButtonLinker::AddEventHandler /NOUNLOAD ${CTLID} $R2
	Pop $R2
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: GetButtonState
###############################################################
!insertmacro DEFINE_FUNC_LITE GetButtonState

!macro INSERT_FUNC_LITE_GetButtonState OUT HWNDDLG CTLID
	System::Call 'User32::IsDlgButtonChecked(i,i) i (${HWNDDLG},${CTLID}) .s'
	Pop ${OUT}
${if} ${OUT} != 0
${andif} ${OUT} != 1
  StrCpy ${OUT} "error"
${endif}
!macroend

###############################################################
# 函数: SetButtonState
###############################################################
!insertmacro DEFINE_FUNC_LITE SetButtonState

!macro INSERT_FUNC_LITE_SetButtonState STATE HWNDDLG CTLID
	System::Call 'User32::CheckDlgButton(i,i,i) i (${HWNDDLG},${CTLID},${STATE}) .s'
	Pop $R0
!macroend

###############################################################
# 函数: CheckRadioButton
###############################################################
!insertmacro DEFINE_FUNC_LITE CheckRadioButton

!macro INSERT_FUNC_LITE_CheckRadioButton HWNDDLG FirstCTLID LastCTLID CTLID
	System::Call 'User32::CheckRadioButton(i,i,i,i) i ($HWNDPARENT, ${FirstCTLID}, ${LastCTLID}, ${CTLID})'
	Pop $R0
!macroend

###############################################################
# 函数: CreateButton2
###############################################################
!insertmacro DEFINE_FUNC_LITE CreateButton2

!macro INSERT_FUNC_LITE_CreateButton2 TEXT LEFT TOP WIDTH HEIGHT HWNDPARENT CTLID ButtonADD
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
# 函数: CreateButton3
###############################################################
!insertmacro DEFINE_FUNC_LITE CreateButton3

!macro INSERT_FUNC_LITE_CreateButton3 TEXT LEFT TOP WIDTH HEIGHT HWNDDLG CTLID
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    Push `${TEXT}`
	;Style = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_TABSTOP
	System::Call 'User32::CreateWindowEx(i,t,t,i,i,i,i,i,i,i,i,v) i (0,"BUTTON",s,0x54010000,${LEFT},${TOP},${WIDTH},${HEIGHT},${HWNDDLG},${CTLID},s,0) .s'
	Exch $R0
	Push $R1
	CreateFont $R1 $(^Font) $(^FontSize) ${FW_NORMAL}
	SendMessage $R0 ${WM_SETFONT} $R1 0

	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: CreateLinker2
###############################################################
!insertmacro DEFINE_FUNC_LITE CreateLinker2

!macro INSERT_FUNC_LITE_CreateLinker2 TEXT LEFT TOP WIDTH HEIGHT HWNDPARENT CTLID LINKADD
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
# 函数: CreateGroupBox
###############################################################
!insertmacro DEFINE_FUNC_LITE CreateGroupBox

!macro INSERT_FUNC_LITE_CreateGroupBox TITLE LEFT TOP WIDTH HEIGHT HWNDDLG CTLID
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    Push `${TITLE}`
	;Style = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_TABSTOP | BS_TEXT | BS_VCENTER | BS_GROUPBOX | BS_MULTILINE
	System::Call 'User32::CreateWindowEx(i,t,t,i,i,i,i,i,i,i,i,v) i (0,"BUTTON",s,0x54012C07,${LEFT},${TOP},${WIDTH},${HEIGHT},${HWNDDLG},${CTLID},s,0) .s'
	Exch $R0
	Push $R1
	CreateFont $R1 $(^Font) $(^FontSize) ${FW_NORMAL}
	SendMessage $R0 ${WM_SETFONT} $R1 0
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: CreateRadioButtonGroup
###############################################################
!insertmacro DEFINE_FUNC_LITE CreateRadioButtonGroup

!macro INSERT_FUNC_LITE_CreateRadioButtonGroup TITLE LEFT TOP WIDTH HEIGHT HWNDDLG CTLID STATE
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    Push `${TITLE}`
	;Style = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_TABSTOP | BS_TEXT | BS_VCENTER | BS_AUTORADIOBUTTON | BS_MULTILINE | BS_GROUP
	System::Call 'User32::CreateWindowEx(i,t,t,i,i,i,i,i,i,i,i,v) i (0,"BUTTON",s,0x54032C09,${LEFT},${TOP},${WIDTH},${HEIGHT},${HWNDDLG},${CTLID},s,0) .s'
	Exch $R0
	Push $R1
	CreateFont $R1 $(^Font) $(^FontSize) ${FW_NORMAL}
	SendMessage $R0 ${WM_SETFONT} $R1 0
	SendMessage $R0 ${BM_SETCHECK} ${STATE} 0
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: CreateRadioButtonGroup2
###############################################################
!insertmacro DEFINE_FUNC_LITE CreateRadioButtonGroup2

!macro INSERT_FUNC_LITE_CreateRadioButtonGroup2 TITLE LEFT TOP WIDTH HEIGHT HWNDDLG CTLID STATE RadioADD
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    Push `${TITLE}`
	;Style = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_TABSTOP | BS_TEXT | BS_VCENTER | BS_AUTORADIOBUTTON | BS_MULTILINE | BS_GROUP
	System::Call 'User32::CreateWindowEx(i,t,t,i,i,i,i,i,i,i,i,v) i (0,"BUTTON",s,0x54032C09,${LEFT},${TOP},${WIDTH},${HEIGHT},${HWNDDLG},${CTLID},s,0) .s'
	Exch $R0
	Push $R1
	CreateFont $R1 $(^Font) $(^FontSize) ${FW_NORMAL}
	SendMessage $R0 ${WM_SETFONT} $R1 0
	SendMessage $R0 ${BM_SETCHECK} ${STATE} 0

	GetFunctionAddress $R2 ${RadioADD}
	ButtonLinker::AddEventHandler /NOUNLOAD ${CTLID} $R2

	Pop $R2
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: CreateRadioButton
###############################################################
!insertmacro DEFINE_FUNC_LITE CreateRadioButton

!macro INSERT_FUNC_LITE_CreateRadioButton TITLE LEFT TOP WIDTH HEIGHT HWNDDLG CTLID STATE
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    Push `${TITLE}`
	;Style = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_TABSTOP | BS_TEXT | BS_VCENTER | BS_AUTORADIOBUTTON | BS_MULTILINE
	System::Call 'User32::CreateWindowEx(i,t,t,i,i,i,i,i,i,i,i,v) i (0,"BUTTON",s,0x54012C09,${LEFT},${TOP},${WIDTH},${HEIGHT},${HWNDDLG},${CTLID},s,0) .s'
	Exch $R0
	Push $R1
	CreateFont $R1 $(^Font) $(^FontSize) ${FW_NORMAL}
	SendMessage $R0 ${WM_SETFONT} $R1 0
	SendMessage $R0 ${BM_SETCHECK} ${STATE} 0
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: CreateRadioButton2
###############################################################
!insertmacro DEFINE_FUNC_LITE CreateRadioButton2

!macro INSERT_FUNC_LITE_CreateRadioButton2 TITLE LEFT TOP WIDTH HEIGHT HWNDDLG CTLID STATE RadioADD
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
    Push `${TITLE}`
	;Style = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_TABSTOP | BS_TEXT | BS_VCENTER | BS_AUTORADIOBUTTON | BS_MULTILINE
	System::Call 'User32::CreateWindowEx(i,t,t,i,i,i,i,i,i,i,i,v) i (0,"BUTTON",s,0x54012C09,${LEFT},${TOP},${WIDTH},${HEIGHT},${HWNDDLG},${CTLID},s,0) .s'
	Exch $R0
	Push $R1
	CreateFont $R1 $(^Font) $(^FontSize) ${FW_NORMAL}
	SendMessage $R0 ${WM_SETFONT} $R1 0
	SendMessage $R0 ${BM_SETCHECK} ${STATE} 0

	GetFunctionAddress $R2 ${RadioADD}
	ButtonLinker::AddEventHandler /NOUNLOAD ${CTLID} $R2

	Pop $R2
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: CreateMenu
###############################################################
!insertmacro DEFINE_FUNC_LITE CreateMenu

!macro INSERT_FUNC_LITE_CreateMenu LPNEWITEM UFLAGS HWNDDLG UIDNEWITEM
	System::Call 'User32::GetSystemMenu(i, i) i (${HWNDDLG}, 0) .s'
	Pop $R0
	Push `${LPNEWITEM}`
	System::Call 'User32::AppendMenu(i, i, i, t) i ($R0, ${UFLAGS}, ${UIDNEWITEM}, s)'
	Pop $R0
!macroend

###############################################################
# 函数: CreateMenu2
###############################################################
!insertmacro DEFINE_FUNC_LITE CreateMenu2

!macro INSERT_FUNC_LITE_CreateMenu2 LPNEWITEM UFLAGS HWNDDLG UIDNEWITEM MenuADD
	System::Call 'User32::GetSystemMenu(i, i) i (${HWNDDLG}, 0) .s'
	Pop $R0
	Push `${LPNEWITEM}`
	System::Call 'User32::AppendMenu(i, i, i, t) i ($R0, ${UFLAGS}, ${UIDNEWITEM}, s)'
	GetFunctionAddress $R1 ${MenuADD}
  ButtonLinker::AddEventHandler /NOUNLOAD ${UIDNEWITEM} $R1 ${BN_CLICKED} 1
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: CreateLink
###############################################################
!insertmacro DEFINE_FUNC_LITE CreateLink

!macro INSERT_FUNC_LITE_CreateLink HWNDPARENT LEFT TOP WIDTH HEIGHT TEXT TARGET
!ifdef NSIS_SUPPORT_CREATELINK
	CreateLink ${HWNDPARENT} ${LEFT} ${TOP} ${WIDTH} ${HEIGHT} ${TEXT} ${TARGET}
!endif
!macroend

###############################################################
# 函数: GetSystemMenu
###############################################################
!insertmacro DEFINE_FUNC_LITE GetSystemMenu

!macro INSERT_FUNC_LITE_GetSystemMenu OUTPUT HWNDDLG
	System::Call 'User32::GetSystemMenu(i, i) i (${HWNDDLG}, 0) .s'
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: AppendMenu
###############################################################
!insertmacro DEFINE_FUNC_LITE AppendMenu

!macro INSERT_FUNC_LITE_AppendMenu HMENU UFLAGS UIDNEWITEM LPNEWITEM
	Push `${LPNEWITEM}`
	System::Call 'User32::AppendMenu(i, i, i, t) i (${HMENU}, ${UFLAGS}, ${UIDNEWITEM}, s)'
!macroend

###############################################################
# 函数: ModifyMenu
###############################################################
!insertmacro DEFINE_FUNC_LITE ModifyMenu

!macro INSERT_FUNC_LITE_ModifyMenu HWNDDLG UIDNEWITEM TEXT
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
	System::Call 'User32::GetSystemMenu(i, i) i (${HWNDDLG}, 0) .s'
	Pop $R0
	Push `${TEXT}`
	System::Call 'User32::ModifyMenu(i, i, i, i, t) i ($R0, ${UIDNEWITEM}, ${MF_BYCOMMAND}, ${UIDNEWITEM}, s)'
	Pop $R0
!macroend

###############################################################
# 函数: ModifyMenu2
###############################################################
!insertmacro DEFINE_FUNC_LITE ModifyMenu2

!macro INSERT_FUNC_LITE_ModifyMenu2 HWNDDLG UIDNEWITEM TEXT MenuADD
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
	System::Call 'User32::GetSystemMenu(i, i) i (${HWNDDLG}, 0) .s'
	Pop $R0
	Push `${TEXT}`
	System::Call 'User32::ModifyMenu(i, i, i, i, t) i ($R0, ${UIDNEWITEM}, ${MF_BYCOMMAND}, ${UIDNEWITEM}, s)'

  ButtonLinker::UnsetEventHandler /NOUNLOAD ${UIDNEWITEM}

	GetFunctionAddress $R1 ${MenuADD}
  ButtonLinker::AddEventHandler /NOUNLOAD ${UIDNEWITEM} $R1
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: DeleteMenu
###############################################################
!insertmacro DEFINE_FUNC_LITE DeleteMenu

!macro INSERT_FUNC_LITE_DeleteMenu HWNDDLG UIDNEWITEM
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
	System::Call 'User32::GetSystemMenu(i, i) i (${HWNDDLG}, 0) .s'
	Pop $R0
	System::Call 'User32::DeleteMenu(i, i, i) i ($R0, ${UIDNEWITEM}, ${MF_BYCOMMAND})'
!macroend

###############################################################
# 函数: DeleteMenu2
###############################################################
!insertmacro DEFINE_FUNC_LITE DeleteMenu2

!macro INSERT_FUNC_LITE_DeleteMenu2 HWNDDLG UIDNEWITEM
	System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
	System::Call 'User32::GetSystemMenu(i, i) i (${HWNDDLG}, 0) .s'
	Pop $R0
	System::Call 'User32::DeleteMenu(i, i, i) i ($R0, ${UIDNEWITEM}, ${MF_BYCOMMAND})'

  ButtonLinker::UnsetEventHandler /NOUNLOAD ${UIDNEWITEM}

!macroend

###############################################################
# 函数: GetWallpaper
###############################################################
!insertmacro DEFINE_FUNC_LITE GetWallpaper

!macro INSERT_FUNC_LITE_GetWallpaper OUTPUT
	Push $R0
	Push $R1
	System::Call "ole32::CoCreateInstance( \
		g '${CLSID_ActiveDesktop}', i 0, \
		i ${CLSCTX_INPROC_SERVER}, \
		g '${IID_IActiveDesktop}', *i .R0) i.R1"
	${If} $R1 >= 0
		# call IActiveDesktop->GetWallpaper
		System::Call /NOUNLOAD "$R0->4(w .s, i ${NSIS_MAX_STRLEN}, i 0)"
		# call IActiveDesktop->Release
		System::Call "$R0->2()"
	${Else}
		Push ""
		SetErrors
	${EndIf}
	Exch 2
	Pop $R0
	Pop $R1
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: SetWallpaper
###############################################################
!insertmacro DEFINE_FUNC_LITE SetWallpaper

!macro INSERT_FUNC_LITE_SetWallpaper WALLPAPER
	Push $R0
	Push $R1
	Push `${WALLPAPER}`
	System::Call "ole32::CoCreateInstance( \
		g '${CLSID_ActiveDesktop}', i 0, \
		i ${CLSCTX_INPROC_SERVER}, \
		g '${IID_IActiveDesktop}', *i .R0) i.R1"
	${If} $R1 >= 0
		# call IActiveDesktop->GetWallpaper
		System::Call /NOUNLOAD "$R0->5(w s, i 0)"
		# call IActiveDesktop->ApplyChanges
		System::Call /NOUNLOAD "$R0->3(i ${AD_APPLY_ALL})"
		# call IActiveDesktop->Release
		System::Call "$R0->2()"
	${Else}
		SetErrors
	${EndIf}
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: GetWallpaperOptions
###############################################################
!insertmacro DEFINE_FUNC_LITE GetWallpaperOptions

!macro INSERT_FUNC_LITE_GetWallpaperOptions OUTPUT
	Push $R0
	Push $R1
	System::Call "ole32::CoCreateInstance( \
		g '${CLSID_ActiveDesktop}', i 0, \
		i ${CLSCTX_INPROC_SERVER}, \
		g '${IID_IActiveDesktop}', *i .R0) i.R1"
	${If} $R1 >= 0
		# alloc a WALLPAPEROPT struct buffer
	    System::Call /NOUNLOAD "*(i 8, i 0) i .s"
	    Exch $R2
		# call IActiveDesktop->GetWallpaperOptions
		System::Call /NOUNLOAD "$R0->6(i R2, i 0)"
		# read WALLPAPEROPT struct buffer
	    System::Call /NOUNLOAD "*$R2(i 8, i .s)"
	    System::Free /NOUNLOAD $R2
	    Exch
	    Pop $R2
		# call IActiveDesktop->Release
		System::Call "$R0->2()"
	${Else}
	    Push ""
		SetErrors
	${EndIf}
	Exch 2
	Pop $R0
	Pop $R1
	Pop ${OUTPUT}
!macroend

###############################################################
# 函数: SetWallpaperOptions
###############################################################
!insertmacro DEFINE_FUNC_LITE SetWallpaperOptions

!macro INSERT_FUNC_LITE_SetWallpaperOptions STYLE
	Push $R0
	Push $R1
	Push ${STYLE}
	System::Call "ole32::CoCreateInstance( \
		g '${CLSID_ActiveDesktop}', i 0, \
		i ${CLSCTX_INPROC_SERVER}, \
		g '${IID_IActiveDesktop}', *i .R0) i.R1"
	${If} $R1 >= 0
		# alloc a WALLPAPEROPT struct buffer
	    System::Call /NOUNLOAD "*(i 8, i s) i .s"
	    Exch $R2
		# call IActiveDesktop->SetWallpaperOptions
		System::Call /NOUNLOAD "$R0->7(i R2, i 0)"
	    System::Free /NOUNLOAD $R2
	    Pop $R2
		# call IActiveDesktop->ApplyChanges
		System::Call /NOUNLOAD "$R0->3(i ${AD_APPLY_ALL})"
		# call IActiveDesktop->Release
		System::Call "$R0->2()"
	${Else}
		SetErrors
	${EndIf}
	Pop $R1
	Pop $R0
!macroend

###############################################################
# 函数: EnableTheming
###############################################################
!insertmacro DEFINE_FUNC_LITE EnableTheming

!macro INSERT_FUNC_LITE_EnableTheming bEnable
	System::Call "UxTheme::EnableTheming(i ${bEnable}) i"
!macroend

###############################################################
# 函数: GetCurrentThemeName
###############################################################
!insertmacro DEFINE_FUNC_LITE GetCurrentThemeName

!macro INSERT_FUNC_LITE_GetCurrentThemeName OUT_NAME OUT_COLOR OUT_SIZE
	System::Call "UxTheme::GetCurrentThemeName(w, i, w, i, w, i) i \
		(.s, ${NSIS_MAX_STRLEN}, .s, ${NSIS_MAX_STRLEN}, .s, ${NSIS_MAX_STRLEN})"
	Pop ${OUT_NAME}
	Pop ${OUT_COLOR}
	Pop ${OUT_SIZE}
!macroend









!ifdef <函数>
!endif 

###############################################################
# 函数: StrCase (from StrFunc.nsh)
###############################################################
!insertmacro DEFINE_FUNC StrCase

!macro CALL_FUNC_StrCase NAME UNFIX ResultVar String Type
	Push `${String}`
	Push `${Type}`
	Call ${UNFIX}${NAME}
	Pop ${ResultVar}
!macroend

!macro INSERT_FUNC_StrCase NAME UNFIX
	Function `${UNFIX}${NAME}`
		;After this point:
		; ------------------------------------------
		;  $0 = String (input)
		;  $1 = Type (input)
		;  $2 = StrLength (temp)
		;  $3 = StartChar (temp)
		;  $4 = EndChar (temp)
		;  $5 = ResultStr (temp)
		;  $6 = CurrentChar (temp)
		;  $7 = LastChar (temp)
		;  $8 = Temp (temp)
		
		  ;Get input from user
		  Exch $1
		  Exch
		  Exch $0
		  Exch
		  Push $2
		  Push $3
		  Push $4
		  Push $5
		  Push $6
		  Push $7
		  Push $8
		
		  ;Initialize variables
		  StrCpy $2 ""
		  StrCpy $3 ""
		  StrCpy $4 ""
		  StrCpy $5 ""
		  StrCpy $6 ""
		  StrCpy $7 ""
		  StrCpy $8 ""
		  
		  SetPluginUnload alwaysoff
		
		  ;Upper and lower cases are simple to use
		  ${If} $1 == "U"
		
			;Upper Case System:
			;------------------
			; Convert all characters to upper case.
		
			System::Call "User32::CharUpper(t r0 r5)i"
			Goto StrCase_End
		  ${ElseIf} $1 == "L"
		
			;Lower Case System:
			;------------------
			; Convert all characters to lower case.
		
			System::Call "User32::CharLower(t r0 r5)i"
			Goto StrCase_End
		  ${EndIf}
		
		  ;For the rest of cases:
		  ;Get "String" length
		  StrLen $2 $0
		
		  ;Make a loop until the end of "String"
		  ${For} $3 0 $2
			;Add 1 to "EndChar" counter also
			IntOp $4 $3 + 1
		
			# Step 1: Detect one character at a time
		
			;Remove characters before "StartChar" except when
			;"StartChar" is the first character of "String"
			${If} $3 <> 0
			  StrCpy $6 $0 `` $3
			${EndIf}
		
			;Remove characters after "EndChar" except when
			;"EndChar" is the last character of "String"
			${If} $4 <> $2
			  ${If} $3 = 0
				StrCpy $6 $0 1
			  ${Else}
				StrCpy $6 $6 1
			  ${EndIf}
			${EndIf}
		
			# Step 2: Convert to the advanced case user chose:
		
			${If} $1 == "T"
		
			  ;Title Case System:
			  ;------------------
			  ; Convert all characters after a non-alphabetic character to upper case.
			  ; Else convert to lower case.
		
			  ;Use "IsCharAlpha" for the job
			  System::Call "*(&t1 r7) i .r8"
			  System::Call "*$8(&i1 .r7)"
			  System::Free $8
			  System::Call "user32::IsCharAlpha(i r7) i .r8"
			  
			  ;Verify "IsCharAlpha" result and convert the character
			  ${If} $8 = 0
				System::Call "User32::CharUpper(t r6 r6)i"
			  ${Else}
				System::Call "User32::CharLower(t r6 r6)i"
			  ${EndIf}
			${ElseIf} $1 == "S"
		
			  ;Sentence Case System:
			  ;------------------
			  ; Convert all characters after a ".", "!" or "?" character to upper case.
			  ; Else convert to lower case. Spaces or tabs after these marks are ignored.
		
			  ;Detect current characters and ignore if necessary
			  ${If} $6 == " "
			  ${OrIf} $6 == "$\t"
				Goto IgnoreLetter
			  ${EndIf}
		
			  ;Detect last characters and convert
			  ${If} $7 == "."
			  ${OrIf} $7 == "!"
			  ${OrIf} $7 == "?"
			  ${OrIf} $7 == ""
				System::Call "User32::CharUpper(t r6 r6)i"
			  ${Else}
				System::Call "User32::CharLower(t r6 r6)i"
			  ${EndIf}
			${ElseIf} $1 == "<>"
		
			  ;Switch Case System:
			  ;------------------
			  ; Switch all characters cases to their inverse case.
		
			  ;Use "IsCharUpper" for the job
			  System::Call "*(&t1 r6) i .r8"
			  System::Call "*$8(&i1 .r7)"
			  System::Free $8
			  System::Call "user32::IsCharUpper(i r7) i .r8"
			  
			  ;Verify "IsCharUpper" result and convert the character
			  ${If} $8 = 0
				System::Call "User32::CharUpper(t r6 r6)i"
			  ${Else}
				System::Call "User32::CharLower(t r6 r6)i"
			  ${EndIf}
			${EndIf}
		
			;Write the character to "LastChar"
			StrCpy $7 $6
		
			IgnoreLetter:
			;Add this character to "ResultStr"
			StrCpy $5 `$5$6`
		  ${Next}
		
		  StrCase_End:
		
		;After this point:
		; ------------------------------------------
		;  $0 = OutVar (output)
		
		  ; Copy "ResultStr" to "OutVar"
		  StrCpy $0 $5
		  
		  SetPluginUnload manual
		  ;Return output to user
		  Pop $8
		  Pop $7
		  Pop $6
		  Pop $5
		  Pop $4
		  Pop $3
		  Pop $2
		  Pop $1
		  Exch $0
	FunctionEnd	
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: Find
###############################################################
!insertmacro DEFINE_FUNC Find

!macro CALL_FUNC_Find NAME UNFIX ResultVar String StrToSearchFor
	Push `${String}`
	Push `${StrToSearchFor}`
	Call ${UNFIX}${NAME}
	Pop ${ResultVar}
!macroend

!macro INSERT_FUNC_Find NAME UNFIX
	Function `${UNFIX}${NAME}`
		Exch $R0 ;要查找的字串
		Exch
		Exch $R1 ;在该字串中查找
		Push $R2
		Push $R3
		Push $R4 ;计数
		Push $R5 ;temp
			StrLen $R2 $R0
			StrLen $R3 $R1
			StrCpy $R4 0
			${Do}
				StrCpy $R5 $R1 $R2 $R4
				System::Call `Kernel32::lstrcmpA(t, t) i (R5, R0) .R5`
				${If} $R5 == 0
					StrCpy $R0 $R4
					${ExitDo}
				${EndIf}
				
				${If} $R4 >= $R3
					StrCpy $R0 -1
					${ExitDo}
				${EndIf}
				
				IntOp $R4 $R4 + 1
			${Loop}
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd	
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: FindLast
###############################################################
!insertmacro DEFINE_FUNC FindLast

!macro CALL_FUNC_FindLast NAME UNFIX ResultVar String StrToSearchFor
	Push `${String}`
	Push `${StrToSearchFor}`
	Call ${UNFIX}${NAME}
	Pop ${ResultVar}
!macroend

!macro INSERT_FUNC_FindLast NAME UNFIX
	Function `${UNFIX}${NAME}`
		Exch $R0 ;要查找的字串
		Exch
		Exch $R1 ;在该字串中查找
		Push $R2
		Push $R3
		Push $R4 ;计数
		Push $R5 ;temp
			StrLen $R2 $R0
			StrLen $R3 $R1
			StrCpy $R4 $R2
			${Do}
				StrCpy $R5 $R1 $R2 -$R4
				System::Call `Kernel32::lstrcmpA(t, t) i (R5, R0) .R5`
				${If} $R5 == 0
					IntOp $R0 $R3 - $R4
					${ExitDo}
				${EndIf}
				
				${If} $R4 >= $R3
					StrCpy $R0 -1
					${ExitDo}
				${EndIf}
				
				IntOp $R4 $R4 + 1
			${Loop}
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd	
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: FindI
###############################################################
!insertmacro DEFINE_FUNC FindI

!macro CALL_FUNC_FindI NAME UNFIX ResultVar String StrToSearchFor
	Push `${String}`
	Push `${StrToSearchFor}`
	Call ${UNFIX}${NAME}
	Pop ${ResultVar}
!macroend

!macro INSERT_FUNC_FindI NAME UNFIX
	Function `${UNFIX}${NAME}`
		Exch $R0 ;要查找的字串
		Exch
		Exch $R1 ;在该字串中查找
		Push $R2
		Push $R3
		Push $R4 ;计数
		Push $R5 ;temp
			StrLen $R2 $R0
			StrLen $R3 $R1
			StrCpy $R4 0
			${Do}
				StrCpy $R5 $R1 $R2 $R4
				${If} $R5 == $R0
					StrCpy $R0 $R4
					${ExitDo}
				${EndIf}

				${If} $R4 >= $R3
					StrCpy $R0 -1
					${ExitDo}
				${EndIf}

				IntOp $R4 $R4 + 1
			${Loop}
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: FindLastI
###############################################################
!insertmacro DEFINE_FUNC FindLastI

!macro CALL_FUNC_FindLastI NAME UNFIX ResultVar String StrToSearchFor
	Push `${String}`
	Push `${StrToSearchFor}`
	Call ${UNFIX}${NAME}
	Pop ${ResultVar}
!macroend

!macro INSERT_FUNC_FindLastI NAME UNFIX
	Function `${UNFIX}${NAME}`
		Exch $R0 ;要查找的字串
		Exch
		Exch $R1 ;在该字串中查找
		Push $R2
		Push $R3
		Push $R4 ;计数
		Push $R5 ;temp
			StrLen $R2 $R0
			StrLen $R3 $R1
			StrCpy $R4 $R2
			${Do}
				StrCpy $R5 $R1 $R2 -$R4
				${If} $R5 == $R0
					IntOp $R0 $R3 - $R4
					${ExitDo}
				${EndIf}

				${If} $R4 >= $R3
					StrCpy $R0 -1
					${ExitDo}
				${EndIf}

				IntOp $R4 $R4 + 1
			${Loop}
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: GetParent
###############################################################
!insertmacro DEFINE_FUNC GetParent

!macro CALL_FUNC_GetParent NAME UNFIX ResultVar String
	Push `${String}`
	Call ${UNFIX}${NAME}
	Pop ${ResultVar}
!macroend

!macro INSERT_FUNC_GetParent NAME UNFIX
	Function `${UNFIX}${NAME}`
		Exch $R0
		Push $R1
		Push $R2
		Push $R3
		
		StrCpy $R1 1
		StrLen $R2 $R0
		${Do}
			StrCpy $R3 $R0 1 -$R1
			${If} $R3 == "\"
				IntOp $R1 $R2 - $R1
				StrCpy $R0 $R0 $R1
				${ExitDo}
			${EndIf}
			${If} $R1 >= $R2
				StrCpy $R0 ""
				${ExitDo}
			${EndIf}
			
			IntOp $R1 $R1 + 1
		${Loop}
		
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd	
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: GetChild
###############################################################
!insertmacro DEFINE_FUNC GetChild

!macro CALL_FUNC_GetChild NAME UNFIX ResultVar String
	Push `${String}`
	Call ${UNFIX}${NAME}
	Pop ${ResultVar}
!macroend

!macro INSERT_FUNC_GetChild NAME UNFIX
	Function `${UNFIX}${NAME}`
		Exch $R0
		Push $R1
		Push $R2
		Push $R3
		
		StrCpy $R1 1
		StrLen $R2 $R0
		${Do}
			StrCpy $R3 $R0 1 -$R1
			${If} $R3 == "\"
				IntOp $R1 $R1 - 1
				StrCpy $R0 $R0 "" -$R1
				${ExitDo}
			${EndIf}
			${If} $R1 >= $R2
				${ExitDo}
			${EndIf}
			
			IntOp $R1 $R1 + 1
		${Loop}
		
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd	
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: GetFileExt
###############################################################
!insertmacro DEFINE_FUNC GetFileExt

!macro CALL_FUNC_GetFileExt NAME UNFIX ResultVar FileName
	Push `${FileName}`
	Call ${UNFIX}${NAME}
	Pop ${ResultVar}
!macroend

!macro INSERT_FUNC_GetFileExt NAME UNFIX
	Function `${UNFIX}${NAME}`
		Exch $R0
		Push $R1
		Push $R2
		Push $R3
			StrLen $R2 $R0
			StrCpy $R1 1
			${Do}
				;从右向左查找
				StrCpy $R3 $R0 1 -$R1
			
				;如果找到了 . 
				${If} $R3 == "."
					IntOp $R1 $R1 - 1
					StrCpy $R0 $R0 "" -$R1
					${ExitDo}
				${EndIf}
			
				;如果找不到则返回空值
				${If} $R3 == "\"
				${OrIf} $R1 >= $R2
					StrCpy $R0 ""
					${ExitDo}
				${EndIf}
		
				IntOp $R1 $R1 + 1
			${Loop}
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd	
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: TrimLine
###############################################################
!insertmacro DEFINE_FUNC TrimLine

!macro CALL_FUNC_TrimLine NAME UNFIX Var
	Push ${Var}
	Call ${UNFIX}${NAME}
	Pop ${Var}
!macroend

!macro INSERT_FUNC_TrimLine NAME UNFIX
	Function `${UNFIX}${NAME}`
		Exch $R0
		Push $R1
		
		StrCpy $R1 $R0 1 -1  ;去除回车、换行
		StrCmp $R1 "$\r" 0 +3
		StrCpy $R0 $R0 -1
		Goto -3
		StrCmp $R1 "$\n" 0 +3
		StrCpy $R0 $R0 -1
		Goto -6
		
		StrCpy $R1 $R0 1 -1  ;去除行尾空格
		StrCmp $R1 " " 0 +3
		StrCpy $R0 $R0 -1
		Goto -3
		
		StrCpy $R1 $R0 1     ;去除行首空格
		StrCmp $R1 " " 0 +3
		StrCpy $R0 $R0 "" 1
		Goto -3
		
		Pop $R1
		Exch $R0
	FunctionEnd
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: TrimLineEx
###############################################################
!insertmacro DEFINE_FUNC TrimLineEx

!macro CALL_FUNC_TrimLineEx NAME UNFIX Var
	Push ${Var}
	Call ${UNFIX}${NAME}
	Pop ${Var}
!macroend

!macro INSERT_FUNC_TrimLineEx NAME UNFIX
	Function `${UNFIX}${NAME}`
		Exch $R0
		Push $R1
		
		StrCpy $R1 $R0 1 -1  ;去除回车、换行
		StrCmp $R1 "$\r" 0 +3
		StrCpy $R0 $R0 -1
		Goto -3
		StrCmp $R1 "$\n" 0 +3
		StrCpy $R0 $R0 -1
		Goto -6
		
		StrCpy $R1 $R0 1 -1  ;去除行尾空格
		StrCmp $R1 " " +2
		StrCmp $R1 "$\t" 0 +3 ;去除制表符
		StrCpy $R0 $R0 -1
		Goto -4
		
		StrCpy $R1 $R0 1     ;去除行首空格
		StrCmp $R1 " " +2
		StrCmp $R1 "$\t" 0 +3  ;去除制表符
		StrCpy $R0 $R0 "" 1
		Goto -4
		
		Pop $R1
		Exch $R0
	FunctionEnd
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: Replace
###############################################################
!insertmacro DEFINE_FUNC Replace

!macro CALL_FUNC_Replace NAME UNFIX ResultVar StrToFind StrToReplace
	Push `${StrToReplace}`
	Push `${StrToFind}`
	Push ${ResultVar}
	Call ${UNFIX}${NAME}
	Pop ${ResultVar}
!macroend

!macro INSERT_FUNC_Replace NAME UNFIX
	Function `${UNFIX}${NAME}`
		Exch $R0
		Exch
		Exch $R1
		Exch
		Exch 2
		Exch $R2
		Push $R3
		Push $R4
		Push $R5
		Push $R6
		Push $R7
		
		StrLen $R3 $R0
		StrLen $R4 $R1
		StrCpy $R5 0
		
		${Do}
			StrCpy $R6 $R0 $R4 $R5
			${If} $R6 == $R1
				StrCpy $R6 $R0 $R5
				IntOp $R7 $R5 + $R4
				StrCpy $R0 $R0 `` $R7
				StrCpy $R0 `$R6$R2$R0`
				StrLen $R6 $R2
				IntOp $R5 $R5 + $R6
				IntOp $R5 $R5 - 1
				StrLen $R3 $R0
			${EndIf}
			IntOp $R5 $R5 + 1
		${LoopUntil} $R5 >= $R3
		
		Pop $R7
		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: ReplaceEx
###############################################################
!insertmacro DEFINE_FUNC ReplaceEx

!macro CALL_FUNC_ReplaceEx NAME UNFIX ResultVar StrToFind StrToReplace StrOffSet ReplaceCount CaseSensitive
	Push `${CaseSensitive}`
	Push `${ReplaceCount}`
	Push `${StrOffSet}`
	Push `${StrToReplace}`
	Push `${StrToFind}`
	Push ${ResultVar}
	Call ${UNFIX}${NAME}
	Pop ${ResultVar}
!macroend

!macro INSERT_FUNC_ReplaceEx NAME UNFIX
	Function `${UNFIX}${NAME}`
		Exch $R0 ;IO string
		Exch
		Exch $R1 ;string to find
		Exch
		Exch 2
		Exch $R2 ;string to replace
		Exch
		Exch 2
		Exch 3
		Exch $0 ;string offset
		Exch
		Exch 2
		Exch 3
		Exch 4
		Exch $1 ;replace count
		Exch
		Exch 2
		Exch 3
		Exch 4
		Exch 5
		Exch $2 ;Case-sensitive ?
		Push $R3
		Push $R4
		Push $R5
		Push $R6
		Push $R7
		Push $R8
		
		StrLen $R3 $R0
		StrLen $R4 $R1
		StrCpy $R5 $0
		StrCpy $R8 0
		
		${Do}
			StrCpy $R6 $R0 $R4 $R5 ;$R6 = temp var
			
			${If} $2 > 0
			
				System::Call `kernel32::lstrcmpA(t R6, t R1) i .s`
				Pop $R6
				${If} $R6 = 0          ;$R1 = string to find
					StrCpy $R6 $R0 $R5
					IntOp $R7 $R5 + $R4
					StrCpy $R0 $R0 `` $R7
					StrCpy $R0 `$R6$R2$R0`
					
					${If} $1 != ``
					${AndIf} $1 != 0
						IntOp $R8 $R8 + 1
						${If} $R8 >= $1
							${ExitDo}
						${EndIf}
					${EndIf}
					
					StrLen $R6 $R2
					IntOp $R5 $R5 + $R6
					IntOp $R5 $R5 - 1
					StrLen $R3 $R0
				${EndIf}
				
			${Else}
			
				${If} $R6 == $R1       ;$R1 = string to find
					StrCpy $R6 $R0 $R5
					IntOp $R7 $R5 + $R4
					StrCpy $R0 $R0 `` $R7
					StrCpy $R0 `$R6$R2$R0`
					
					${If} $1 != ``
					${AndIf} $1 != 0
						IntOp $R8 $R8 + 1
						${If} $R8 >= $1
							${ExitDo}
						${EndIf}
					${EndIf}
					
					StrLen $R6 $R2
					IntOp $R5 $R5 + $R6
					IntOp $R5 $R5 - 1
					StrLen $R3 $R0
				${EndIf}
				
			${EndIf}
			IntOp $R5 $R5 + 1
		${LoopUntil} $R5 >= $R3
		
		Pop $R8
		Pop $R7
		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $2
		Pop $1
		Pop $0
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: VerCmp
###############################################################
!insertmacro DEFINE_FUNC VerCmp

!macro CALL_FUNC_VerCmp NAME UNFIX ResultVar Ver1 Ver2
	Push `${Ver2}`
	Push `${Ver1}`
	Call ${UNFIX}${NAME}
	Pop ${ResultVar}
!macroend

!macro INSERT_FUNC_VerCmp NAME UNFIX
	Function ${UNFIX}${NAME}
		Exch $R0
		Exch
		Exch $R1
		Push $R2
		Push $R3
		
		${Do}
			${If} $R0 != ""
				Push $R0
				Call ${UNFIX}${NAME}.FindDot
				Pop $R0 ;点后面的
				Pop $R2 ;点前面的
			${Else}
				StrCpy $R2 0
			${EndIf}
			${If} $R1 != ""
				Push $R1
				Call ${UNFIX}${NAME}.FindDot
				Pop $R1 ;点后面的
				Pop $R3 ;点前面的
			${Else}
				StrCpy $R3 0
			${EndIf}
			
			${If} $R2 > $R3
				StrCpy $R0 1
				${ExitDo}
			${ElseIf} $R2 < $R3
				StrCpy $R0 -1
				${ExitDo}
			${EndIf}
		
			${If} $R0 == ""
			${AndIf} $R1 == ""
				StrCpy $R0 0
				${ExitDo}
			${EndIf}
		${loop}
			
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd
	
	Function ${UNFIX}${NAME}.FindDot
		Exch $R0
		Push $R1
		Push $R2
		Push $R3
		StrCpy $R2 0
			${Do}
				StrCpy $R3 $R0 1 $R2
				${If} $R3 == "."
					StrCpy $R1 $R0 $R2
					IntOp $R2 $R2 + 1
					StrCpy $R0 $R0 "" $R2
					${ExitDo}
				${EndIf}
				${If} $R3 == ""
					StrCpy $R1 $R0
					StrCpy $R0 ""
					${ExitDo}
				${EndIf}
				IntOp $R2 $R2 + 1
			${Loop}
		Pop $R3
		Pop $R2
		Exch $R1
		Exch
		Exch $R0
	FunctionEnd

	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: DumpLog
###############################################################
!insertmacro DEFINE_FUNC DumpLog

!macro CALL_FUNC_DumpLog NAME UNFIX LogFile
	Push `${LogFile}`
	Call ${UNFIX}${NAME}
!macroend

!macro INSERT_FUNC_DumpLog NAME UNFIX
	Function `${UNFIX}${NAME}`
		Exch $R5
		Push $R0
		Push $R1
		Push $R2
		Push $R3
		Push $R4
		Push $R6
		
		FindWindow $R0 "#32770" "" $HWNDPARENT
		GetDlgItem $R0 $R0 1016
		${Unless} $R0 = 0
			FileOpen $R5 $R5 a
			${Unless} $R5 == ""
				FileSeek $R5 0 END
				SendMessage $R0 0x1004 0 0 $R6
				SetPluginUnload alwaysoff
				System::Alloc 1024
				Pop $R3
				StrCpy $R2 0
				System::Call "*(i, i, i, i, i, i, i, i, i) i (0, 0, 0, 0, 0, R3, 1024) .R1"
				${While} $R2 < $R6
				  System::Call "User32::SendMessageA(i, i, i, i) i ($R0, 0x102D, $R2, R1)"
				  System::Call "*$R3(&t1024 .R4)"
				  FileWrite $R5 "$R4$\r$\n"
				  IntOp $R2 $R2 + 1
				${EndWhile}
				FileClose $R5
				System::Free $R1
				SetPluginUnload manual
				System::Free $R3
			${EndUnless}
		${EndUnless}
		
		Pop $R6
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Pop $R0
		Pop $R5
	FunctionEnd
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: AppendFile
###############################################################
!insertmacro DEFINE_FUNC AppendFile

!macro CALL_FUNC_AppendFile NAME UNFIX Src Dest
	Push `${Src}`
	Push `${Dest}`
	Call ${UNFIX}${NAME}
!macroend

!macro INSERT_FUNC_AppendFile NAME UNFIX
	Function `${UNFIX}${NAME}`
		Exch $R0 ;目标
		Exch
		Exch $R1 ;源
		Push $R2
		Push $R3
		Push $R4
			FileOpen $R2 $R1 r
			FileOpen $R3 $R0 a
			FileSeek $R3 0 END
			${Do}
				FileReadByte $R2 $R4
				${IfThen} $R4 == "" ${|} ${ExitDo} ${|}
				FileWriteByte $R3 $R4
			${Loop}
			FileClose $R2
			FileClose $R3
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Pop $R0
	FunctionEnd
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: DelFileByLog
###############################################################
!insertmacro DEFINE_FUNC DelFileByLog

!macro CALL_FUNC_DelFileByLog NAME UNFIX LogFile
	${If} ${FileExists} `${LogFile}`
		Push `${LogFile}`
		Call ${UNFIX}${NAME}
	${EndIf}
!macroend

!macro INSERT_FUNC_DelFileByLog NAME UNFIX
	Function `${UNFIX}${NAME}`
		Exch $R0
		Push $R1
		Push $R2
		Push $R3
		
		FileOpen $R0 $R0 r
		${Do}
		  FileRead $R0 $R1
		  ${IfThen} $R1 == `` ${|} ${ExitDo} ${|}
			StrCpy $R1 $R1 -2
			StrCpy $R2 $R1 11
			StrCpy $R3 $R1 20
			${If} $R2 == "File: wrote"
			${OrIf} $R2 == "File: skipp"
			${OrIf} $R3 == "CreateShortCut: out:"
			${OrIf} $R3 == "created uninstaller:"
				Push $R1
				Push '"'
				Call ${UNFIX}${NAME}.StrLoc
				Pop $R2
				${If} $R2 != ""
					IntOp $R2 $R2 + 1
					StrCpy $R3 $R1 "" $R2
					Push $R3
					Push '"'
					Call ${UNFIX}${NAME}.StrLoc
					Pop $R2
					${If} $R2 != ""
						StrCpy $R3 $R3 $R2
						Delete /REBOOTOK $R3
					${EndIf}
				${EndIf}
			${EndIf}
			StrCpy $R2 $R1 7
			${If} $R2 == "Rename:"
				Push $R1
				Push '->'
				Call ${UNFIX}${NAME}.StrLoc
				Pop $R2
				${If} $R2 != ""
					IntOp $R2 $R2 + 2
					StrCpy $R3 $R1 "" $R2
					Delete /REBOOTOK $R3
				${EndIf}
			${EndIf}
		${Loop}
		FileClose $R0
			
		Pop $R3
		Pop $R2
		Pop $R1
		Pop $R0
	FunctionEnd
	
	Function ${UNFIX}${NAME}.StrLoc
		Exch $R0 ;Str to search for
		Exch
		Exch $R1 ;string
		Push $R2 ;len of Str to search for
		Push $R3 ;len of string
		Push $R4
		Push $R5
			StrLen $R2 $R0
			StrLen $R3 $R1
			StrCpy $R4 0
			${Do}
				StrCpy $R5 $R1 $R2 $R4
				${If} $R5 == $R0
				${OrIf} $R4 = $R3
					${ExitDo}
				${EndIf}
				IntOp $R4 $R4 + 1
			${Loop}
			${If} $R4 = $R3
				StrCpy $R0 ""
			${Else}
				StrCpy $R0 $R4
			${EndIf}	
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd	
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: RMDir
###############################################################
!insertmacro DEFINE_FUNC RMDir

!macro CALL_FUNC_RMDir NAME UNFIX Dir
	Push `${Dir}`
	Call ${UNFIX}${NAME}
!macroend

!macro INSERT_FUNC_RMDir NAME UNFIX
	Function ${UNFIX}${NAME}
		Exch $R0
		Push $R1
		Push $R2
		Push $R3
		Push $R4
		Push $R5
		Push $R6
		
		GetTempFileName $R2
		
		FileOpen $R1 $R2 a
		FileWrite $R1 `$\r$\n`
		Push $R1
		Push $R0
		Call ${UNFIX}${NAME}.List
		
		FileSeek $R1 -2 CUR
		${Do}
			FileSeek $R1 -2 CUR $R4
			${IfThen} $R4 <= 0 ${|} ${ExitDo} ${|}
			FileReadByte $R1 $R3
			${If} $R3 = 10
				FileSeek $R1 0 CUR $R5
				FileRead $R1 $R6
				StrCpy $R6 $R6 -2
				RMDir $R6
				FileSeek $R1 $R5
				FileSeek $R1 -1 CUR
			${EndIf}
		${Loop}
		
		FileClose $R1
		RMDir $R0
		SetFileAttributes $R2 NORMAL
		System::Call `Kernel32::DeleteFile(t) i (R2)`
		
		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Pop $R0
	FunctionEnd
	
	Function ${UNFIX}${NAME}.List
		Exch $R0
		Exch
		Exch $R1
		Push $R2
		Push $R3
		FindFirst $R3 $R2 "$R0\*"
		${While} $R2 != ``
			${If} $R2 != "."
			${AndIf} $R2 != ".."
				${If} ${FileExists} "$R0\$R2\*" ;is dir
					FileWrite $R1 "$R0\$R2$\r$\n"
					Push $R1
					Push "$R0\$R2"
					Call ${UNFIX}${NAME}.List
				${EndIf}
			${EndIf}
		  FindNext $R3 $R2
		${EndWhile}
		FindClose $R3
		Pop $R3
		Pop $R2
		Pop $R1
		Pop $R0
	FunctionEnd	
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: CopyReg
###############################################################
!insertmacro DEFINE_FUNC CopyReg

!macro CALL_FUNC_CopyReg NAME UNFIX SRC_ROOT SRC_SUBKEY DEST_ROOT DEST_SUBKEY
	${If} "${SRC_ROOT}\${SRC_SUBKEY}" != "${DEST_ROOT}\${DEST_SUBKEY}"
	${AndIf} "${SRC_ROOT}" != ``
	${AndIf} "${DEST_ROOT}" != ``
		Push "${DEST_SUBKEY}"
		Push "${DEST_ROOT}"
		Push "${SRC_SUBKEY}"
		Push "${SRC_ROOT}"
		Call ${UNFIX}${NAME}
	${EndIf}
!macroend

!macro INSERT_FUNC_CopyReg NAME UNFIX
	Function ${UNFIX}${NAME}
		Exch $6  ;root key (source)
		Exch
		Exch $7  ;subkey to open (source)
		Exch
		Exch 2
		Exch $8  ;root key (destination)
		Exch
		Exch 2
		Exch 3
		Exch $9  ;subkey to create (destination)
		Push $7
		
		Call ${UNFIX}${NAME}.Enum
		
		
		Pop $9
		Pop $8
		Pop $7
		Pop $6
	FunctionEnd
	
	Function ${UNFIX}${NAME}.Enum
		Exch $R6
		Push $R0 ;address of handle to open key
		Push $R1 ;Return Values
		Push $R2 ;HKEY of open key
		Push $R3 ;address of buffer for subkey name
		Push $R4 ;index of subkey to query
		Push $R5 ;value
		Push $R7 ;address of handle to create key
		Push $R8 ;HKEY of create key
		Push $R9
		Push $0
		Push $1
		
		System::Call /NOUNLOAD "*(i 0) i .R0"
		;打开源键
		System::Call /NOUNLOAD "${RegOpenKeyEx}($6, '$R6', 0, ${KEY_QUERY_VALUE}|${KEY_ENUMERATE_SUB_KEYS}, R0) .R1"
		${If} $R1 = ${ERROR_SUCCESS}
			System::Call /NOUNLOAD "*$R0(&i4 .R2)"
			
			System::Call /NOUNLOAD "*(i 0) i .R7"
			StrLen $R4 $7
			IntOp $R4 $R4 + 1
			StrCpy $R4 $R6 "" $R4 ;取得相对子键
			System::Call /NOUNLOAD "${RegCreateKey}($8, '$9\$R4', R7) .R1" ;创建键
			${If} $R1 == ${ERROR_SUCCESS}
				System::Call /NOUNLOAD "*$R7(&i4 .R8)"
			
				StrCpy $R4 0
				StrCpy $0 0
				${Do}
					Push $R0
					System::Call /NOUNLOAD "*(i ${NSIS_MAX_STRLEN}) i .s"
					Pop $R0
					System::Call /NOUNLOAD "${RegEnumValue}(R2, $R4, .R5, R0 R0, 0, 0, i 0, 0)"
					System::Free /NOUNLOAD $R0
					Pop $R0
					${IfThen} $R5 == `` ${|} IntOp $0 $0 + 1 ${|}
					${IfThen} $0 >= 2 ${|} ${ExitDo} ${|}
					IntOp $R4 $R4 + 1
					
					;查询值的类型和长度
					System::Call /NOUNLOAD "*(i 0) i .R3"
					System::Call /NOUNLOAD "*(i 0) i .R9"
					System::Call /NOUNLOAD "${RegQueryValueEx}(R2, R5, 0, R3, 0, R9)"
					System::Call /NOUNLOAD "*$R3(&i4 .R1)" ;$R1 = 数据类型
					System::Free /NOUNLOAD $R3
					System::Call /NOUNLOAD "*$R9(&i4 .R3)" ;$R3 = 数据长度
						
					${If} $R5 != ``
					${OrIf} $R3 > 0
						;分配一个符合查询值长度的缓冲
						System::Alloc /NOUNLOAD $R3
						Pop $1
						
						;查询数据
						System::Call /NOUNLOAD "${RegQueryValueEx}(R2, R5, 0, 0, r1, R9)"
						;写入数据
						System::Call /NOUNLOAD "${RegSetValueEx}(R8, R5, 0, R1, i r1, R3)"
						;释放数据缓冲区
						System::Free /NOUNLOAD $1
						;DetailPrint `$R6 $R5`
					${EndIf}
					System::Free /NOUNLOAD $R9
				${Loop}
				
				System::Call /NOUNLOAD "${RegCloseKey}(R7)"
					
			${EndIf}
			
			System::Free /NOUNLOAD $R7
			System::Alloc /NOUNLOAD 1024
			Pop $R3 ;address of buffer for subkey name
			
			${Unless} $R3 = 0
			
				StrCpy $R4 0
				${Do}
					System::Call /NOUNLOAD "${RegEnumKey}(R2, $R4, i $R3, 1023) .R1"
					${IfThen} $R1 != 0 ${|} ${ExitDo} ${|}
					System::Call /NOUNLOAD "*$R3(&t1024 .R5)"
					Push `$R6\$R5`
					Call ${UNFIX}${NAME}.Enum
					IntOp $R4 $R4 + 1
				${Loop}
				
			${EndUnless}
			
			System::Free /NOUNLOAD $R3
			System::Call /NOUNLOAD "${RegCloseKey}(R0)"
		${EndIf}
		
		System::Free $R0
		Pop $1
		Pop $0
		Pop $R9
		Pop $R8
		Pop $R7
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Pop $R0
		Pop $R6
	FunctionEnd
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: StrToHex
###############################################################
!insertmacro DEFINE_FUNC StrToHex

!macro CALL_FUNC_StrToHex NAME UNFIX ResultVar String
	Push `${String}`
	Call ${UNFIX}${NAME}
	Pop ${ResultVar}
!macroend

!macro INSERT_FUNC_StrToHex NAME UNFIX
	Function ${UNFIX}${NAME}
		Exch $R0
		Push $R1
		Push $R2
		Push $R3
		Push $R4
		Push $R5
		Push $R6
		
		SetPluginUnload alwaysoff
		System::Alloc 4
		Pop $R1
		
		StrCpy $R6 ``
		StrLen $R2 $R0
		IntOp $R2 $R2 - 1
		${For} $R3 0 $R2
			StrCpy $R4 $R0 1 $R3
			${If} $R4 == ``
				StrCpy $R4 $R0 2 $R3
				IntOp $R3 $R3 + 1
			${EndIf}
			System::Call "*$R1(&t4 R4)"
			System::Call "*$R1(i .R4)"
			IntFmt $R4 %X $R4
			${If} 0x$R4 < 0x10
				StrCpy $R4 `0$R4`
			${ElseIf} 0x$R4 > 0x100
				StrCpy $R5 $R4 2 2
				StrCpy $R4 $R4 2
				StrCpy $R4 $R5$R4
				${If} 0x$R4 < 0x1000
					StrCpy $R4 `0$R4`
				${EndIf}
			${EndIf}
			StrCpy $R6 $R6$R4
		${Next}
		
		SetPluginUnload manual
		System::Free $R1
		StrCpy $R0 $R6
		
		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: ReadRegBin
###############################################################
!insertmacro DEFINE_FUNC ReadRegBin

!macro CALL_FUNC_ReadRegBin NAME UNFIX ResultVar ROOT SubKey Value
	${If} ${ROOT} != ``
		Push `${Value}`
		Push `${SubKey}`
		Push ${ROOT}
		Call ${UNFIX}${NAME}
		Pop ${ResultVar}
	${EndIf}
!macroend

!macro INSERT_FUNC_ReadRegBin NAME UNFIX
	Function ${UNFIX}${NAME}
		Exch 2
		Exch $R0 ;Value
		Exch 2
		Push $R1
		Exch 2
		Exch
		Push $R2
		Exch 2
		Exch
		Push $R3
		Exch 2
		Exch
		Push $R4
		Exch 2
		Exch
		Push $R5
		Exch 2
		Exch
		Push $R6
		Exch 2
		Exch
		
		SetPluginUnload alwaysoff
		System::Call "*(i 0) i .R1"
		System::Call "${RegOpenKeyEx}(s, s, 0, ${KEY_QUERY_VALUE}|${KEY_ENUMERATE_SUB_KEYS}, R1) .R2"
		Push $R1
		${If} $R2 = ${ERROR_SUCCESS}
			System::Call "*$R1(&i4 .R2)"
			System::Call "*(i 0) i .R1"
			System::Call "*(i 0) i .R3"
			System::Call "${RegQueryValueEx}(R2, R0, 0, R1, 0, R3)"
			System::Call "*$R1(&i4 .R4)"
			${If} $R4 = ${REG_BINARY}
				System::Call "*$R3(&i4 .R4)"
				System::Free $R1
				${If} $R4 > 0
					System::Alloc $R4
					Pop $R1
					System::Call "${RegQueryValueEx}(R2, R0, 0, 0, R1, R3)"
					IntOp $R4 $R4 + $R1
					IntOp $R4 $R4 - 1
					StrCpy $R0 ``
					
					${For} $R5 $R1 $R4
						System::Call "*$R5(&i1 .R6)"
						IntFmt $R6 %x $R6
						${If} 0x$R6 < 0x10
							StrCpy $R6 `0$R6`
						${EndIf}
						StrCpy $R0 `$R0$R6`
					${Next}
					
					System::Free $R1
					
				${Else}
					StrCpy $R0 ``
				${EndIf}
			${Else}
				System::Free $R1
				StrCpy $R0 ``
			${EndIf}
		${Else}
			StrCpy $R0 ``
		${EndIf}
		Pop $R1
		System::Call "${RegCloseKey}(R1)"
		System::Free $R1
		
		SetPluginUnload manual
		System::Free $R3
		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: WriteRegBin
###############################################################
!insertmacro DEFINE_FUNC WriteRegBin

!macro CALL_FUNC_WriteRegBin NAME UNFIX ROOT SubKey Value Data
	${If} ${ROOT} != ``
		Push `${Data}`
		Push `${Value}`
		Push `${SubKey}`
		Push ${ROOT}
		Call ${UNFIX}${NAME}
	${EndIf}
!macroend

!macro INSERT_FUNC_WriteRegBin NAME UNFIX
	Function ${UNFIX}${NAME}
		Exch 3
		Exch $R0 ;Data
		Exch 3
		Exch 2
		Exch $R1 ;Value
		Exch 2
		Push $R2
		Exch 2
		Exch
		Push $R3
		Exch 2
		Exch
		Push $R4
		Exch 2
		Exch
		Push $R5
		Exch 2
		Exch
		Push $R6
		Exch 2
		Exch
		Push $R7
		Exch 2
		Exch
		
		StrLen $R4 $R0
		IntOp $R2 $R4 % 2
		${If} $R2 = 0
		
			SetPluginUnload alwaysoff
			
			System::Call "*(i 0) i .R2"
			System::Call "${RegCreateKey}(s, s, R2) .R3"
			Push $R2
			${If} $R3 = ${ERROR_SUCCESS}
				System::Call "*$R2(&i4 .R3)"
				
				IntOp $R4 $R4 / 2
				System::Alloc $R4
				Pop $R5
				StrCpy $R2 0
				StrCpy $R7 $R5
				
				${Do}
					StrCpy $R6 $R0 2 $R2
					${IfThen} $R6 == `` ${|} ${ExitDo} ${|}
					System::Call "*$R7(&i1 0x$R6)"
					IntOp $R7 $R7 + 1
					IntOp $R2 $R2 + 2
				${Loop}
				
				System::Call "${RegSetValueEx}(R3, R1, 0, ${REG_BINARY}, i R5, R4) .s"
				Pop $R1
				${Unless} $R1 = ${ERROR_SUCCESS}
					SetErrors
				${EndUnless}
				System::Free $R5
			${Else}
				SetErrors
			${EndIf}
			Pop $R1
			System::Call "${RegCloseKey}(R1)"
			
			SetPluginUnload manual
			System::Free $R1
			
		${Else}
			SetErrors
		${EndIf}
		
		Pop $R7
		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Pop $R0
	FunctionEnd
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: GetVarValue
###############################################################
!insertmacro DEFINE_FUNC GetVarValue

!macro CALL_FUNC_GetVarValue NAME UNFIX OutPut Value 
	Push `${Value}`
	Call ${UNFIX}${NAME}
	Pop `${OutPut}` 
!macroend

!macro GetVarValueMacro VAR
	StrLen $R5 $$${VAR}
	StrCpy $R3 $R0 $R5 $R1
	StrCmp $R3 $$${VAR} 0 +3
	StrCpy $R4 $${VAR}
	Goto find_var_end
!macroend

!macro INSERT_FUNC_GetVarValue NAME UNFIX
	Function ${UNFIX}${NAME}
	    Exch $R0
	    Push $R1
	    Push $R2
	    Push $R3
	    Push $R4
	    Push $R5
	    Push $R6
	    
	    StrLen $R2 $R0
	    ${For} $R1 0 $R2
			StrCpy $R3 $R0 2 $R1
			${If} $R3 == $$$$ ;$$ 转义 
				StrCpy $R3 $R0 $R1
				IntOp $R4 $R1 + 1
				StrCpy $R0 $R0 "" $R4
				StrCpy $R0 "$R3$R0"
				IntOp $R2 $R2 - 1
				${Continue}
			${EndIf}
			
			StrCpy $R3 $R0 1 $R1
	    	StrCpy $R4 `` 
			${If} $R3 == $$
				!insertmacro GetVarValueMacro INSTDIR
				!insertmacro GetVarValueMacro OUTDIR
				!insertmacro GetVarValueMacro CMDLINE
				!insertmacro GetVarValueMacro LANGUAGE
				
				;常量
				!insertmacro GetVarValueMacro PLUGINSDIR
				!insertmacro GetVarValueMacro PROGRAMFILES
				!insertmacro GetVarValueMacro COMMONFILES
				!insertmacro GetVarValueMacro DESKTOP
				!insertmacro GetVarValueMacro WINDIR
				!insertmacro GetVarValueMacro SYSDIR
				!insertmacro GetVarValueMacro EXEDIR
				!insertmacro GetVarValueMacro STARTMENU
				!insertmacro GetVarValueMacro SMPROGRAMS
				!insertmacro GetVarValueMacro SMSTARTUP
				!insertmacro GetVarValueMacro QUICKLAUNCH
				!insertmacro GetVarValueMacro DOCUMENTS
				!insertmacro GetVarValueMacro SENDTO
				!insertmacro GetVarValueMacro RECENT
				!insertmacro GetVarValueMacro FAVORITES
				!insertmacro GetVarValueMacro MUSIC
				!insertmacro GetVarValueMacro PICTURES
				!insertmacro GetVarValueMacro VIDEOS
				!insertmacro GetVarValueMacro NETHOOD
				!insertmacro GetVarValueMacro FONTS
				!insertmacro GetVarValueMacro TEMPLATES
				!insertmacro GetVarValueMacro APPDATA
				!insertmacro GetVarValueMacro PRINTHOOD 
				!insertmacro GetVarValueMacro INTERNET_CACHE
				!insertmacro GetVarValueMacro COOKIES
				!insertmacro GetVarValueMacro HISTORY
				!insertmacro GetVarValueMacro PROFILE
				!insertmacro GetVarValueMacro ADMINTOOLS
				!insertmacro GetVarValueMacro RESOURCES
				!insertmacro GetVarValueMacro RESOURCES_LOCALIZED
				!insertmacro GetVarValueMacro CDBURN_AREA
				!insertmacro GetVarValueMacro HWNDPARENT
				find_var_end:
				
				${If} $R4 != ""
					StrCpy $R6 $R0 $R1
					IntOp $R1 $R1 + $R5
					StrCpy $R0 $R0 "" $R1
					StrCpy $R0 "$R6$R4$R0"
					StrLen $R2 $R0
					IntOp $R1 $R1 - 1
				${EndIf}
			${EndIf}
		${Next}
			
	    Pop $R6
	    Pop $R5
	    Pop $R4
	    Pop $R3
	    Pop $R2
	    Pop $R1
	    Exch $R0
	FunctionEnd
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: WriteRegStrW 
###############################################################
!insertmacro DEFINE_FUNC WriteRegStrW

!macro CALL_FUNC_WriteRegStrW NAME UNFIX CodePage hKey lpSubKey lpValueName lpData 
	Push `${lpData}`
	Push `${lpValueName}`
	Push `${lpSubKey}`
	Push ${hKey}
	Push ${CodePage}
	Call ${UNFIX}${NAME}
!macroend

!macro INSERT_FUNC_WriteRegStrW NAME UNFIX
	Function ${UNFIX}${NAME}
	    Exch $R0 ;CodePage
	    Exch
	    Exch $R1 ;hKey
	    Exch 
	    Exch 2
	    Exch $R2 ;lpSubKey
	    Exch
	    Exch 2
	    Exch 3
	    Exch $R3 ;lpValueName
	    Exch
	    Exch 2
	    Exch 3
	    Exch 4
	    Exch $R4 ;lpData
	    Push $R5
	    Push $R6
	    Push $R7
	    
	    StrCpy $R5 $R2
		StrLen $R6 $R5
		IntOp $R6 $R6 * 2
		IntOp $R6 $R6 + 1
		System::Alloc /NOUNLOAD $R6
		Pop $R2
		Push $R5
		System::Call /NOUNLOAD "${MultiByteToWideChar}($R0,0,s,-1,i 0,0).s"
		Push $R2
		Push $R5
		System::Call /NOUNLOAD "${MultiByteToWideChar}($R0,0,s,-1,i s,s)"
			
	    StrCpy $R5 $R3
		StrLen $R6 $R5
		IntOp $R6 $R6 * 2
		IntOp $R6 $R6 + 1
		System::Alloc /NOUNLOAD $R6
		Pop $R3
		Push $R5
		System::Call /NOUNLOAD "${MultiByteToWideChar}($R0,0,s,-1,i 0,0).s"
		Push $R3
		Push $R5
		System::Call /NOUNLOAD "${MultiByteToWideChar}($R0,0,s,-1,i s,s)"
			
	    StrCpy $R5 $R4
		StrLen $R6 $R5
		IntOp $R6 $R6 * 2
		IntOp $R6 $R6 + 1
		System::Alloc /NOUNLOAD $R6
		Pop $R4
		Push $R5
		System::Call /NOUNLOAD "${MultiByteToWideChar}($R0,0,s,-1,i 0,0).s"
		Push $R4
		Push $R5
		System::Call /NOUNLOAD "${MultiByteToWideChar}($R0,0,s,-1,i s,s)"
			
		System::Call /NOUNLOAD "*(i) i (0) .R5"
		System::Call /NOUNLOAD "${RegCreateKeyW}($R1,$R2,R5)"
		System::Call /NOUNLOAD "*$R5(&i4 .R6)"
		System::Call /NOUNLOAD "Kernel32::lstrlenW(t)i(i $R4).R7"
		IntOp $R7 $R7 * 2
		System::Call /NOUNLOAD "${RegSetValueExW}(R6,i $R3,0,${REG_SZ},i $R4,$R7).s"
		Pop $R1
		${Unless} $R1 = ${ERROR_SUCCESS}
			SetErrors
		${EndUnless}
		System::Call /NOUNLOAD "${RegCloseKey}(R6)"
	
		System::Free /NOUNLOAD $R5
		System::Free /NOUNLOAD $R4
		System::Free /NOUNLOAD $R3
		System::Free $R2
		
	    Pop $R7
	    Pop $R6
	    Pop $R5
	    Pop $R4
	    Pop $R3
	    Pop $R2
	    Pop $R1
	    Pop $R0
	FunctionEnd
	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: ForEachFile
###############################################################
!insertmacro DEFINE_FUNC ForEachFile

!macro CALL_FUNC_ForEachFile NAME UNFIX DIR_TO_SEARCH FUNCTION
	Push `${FUNCTION}`
	Push `${DIR_TO_SEARCH}`
	Call ${UNFIX}${NAME}
!macroend

!macro INSERT_FUNC_ForEachFile NAME UNFIX
	Function ${UNFIX}${NAME}
		Exch $R0
		Exch
		Exch $R1
		Push $R2
		Push $R3
		Push $R4
		Push $R5
		Push $R6

		ClearErrors
		FindFirst $R2 $R3 "$R0\*"
		${Unless} ${Errors}
			${Do}
				${Select} $R3
				${Case2} "." ".."
				  ; Do nothing
				${CaseElse}
					${Unless} ${FileExists} "$R0\$R3\*"
					    Push "$R0\$R3"
					    Call $R1
					${EndUnless}
				${EndSelect}
				FindNext $R2 $R3
			${LoopUntil} $R3 == ``
		FindClose $R2
		${EndUnless}

		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Pop $R0
	FunctionEnd

	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: ForEachFileEx
###############################################################
!insertmacro DEFINE_FUNC ForEachFileEx

!macro CALL_FUNC_ForEachFileEx NAME UNFIX DIR_TO_SEARCH FUNCTION
	Push `${FUNCTION}`
	Push `${DIR_TO_SEARCH}`
	Call ${UNFIX}${NAME}
!macroend

!macro INSERT_FUNC_ForEachFileEx NAME UNFIX
	Function ${UNFIX}${NAME}
		Exch $R0
		Exch
		Exch $R1
		Push $R2
		Push $R3
		Push $R4
		Push $R5
		Push $R6

		ClearErrors
		FindFirst $R2 $R3 "$R0\*"
		${Unless} ${Errors}
			${Do}
				${Select} $R3
				${Case2} "." ".."
				  ; Do nothing
				${CaseElse}
					${If} ${FileExists} "$R0\$R3\*"
						Push $R1
						Push `$R0\$R3`
						Call ${UNFIX}${NAME}
					${Else}
					    Push "$R0\$R3"
					    Call $R1
					${EndIf}
				${EndSelect}
				FindNext $R2 $R3
			${LoopUntil} $R3 == ``
		FindClose $R2
		${EndUnless}

		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Pop $R0
	FunctionEnd

	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: SearchFile
###############################################################
!insertmacro DEFINE_FUNC SearchFile

!macro CALL_FUNC_SearchFile NAME UNFIX RESULT DIR_TO_SEARCH FILE_FOR_SEARCH
	Push `${FILE_FOR_SEARCH}`
	Push `${DIR_TO_SEARCH}`
	Call ${UNFIX}${NAME}
	Pop ${RESULT}
!macroend

!macro INSERT_FUNC_SearchFile NAME UNFIX
	Function ${UNFIX}${NAME}
		Exch $R0 ;dir
		Exch
		Exch $R1 ;file
		Push $R2
		Push $R3
		Push $R4
		Push $R5
		Push $R6

		ClearErrors
		FindFirst $R2 $R3 "$R0\*"
		${Unless} ${Errors}
			${Do}
				${Select} $R3
				${Case2} "." ".."
				  ; Do nothing
				${CaseElse}
					${If} ${FileExists} "$R0\$R3\*"
						Push $R1
						Push `$R0\$R3`
						Call ${UNFIX}${NAME}
						Pop $R3
						${If} $R3 != ``
						    ${ExitDo}
						${EndIf}
					${ElseIf} $R3 == $R1
					    StrCpy $R3 "$R0\$R3"
					    ${ExitDo}
					${EndIf}
				${EndSelect}
				FindNext $R2 $R3
			${LoopUntil} $R3 == ``
		FindClose $R2
		${EndUnless}
		StrCpy $R0 $R3

		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd

	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: ReadRegMultiStr
###############################################################
!insertmacro DEFINE_FUNC ReadRegMultiStr

!macro CALL_FUNC_ReadRegMultiStr NAME UNFIX ROOT SUBKEY VALUE CALLBACK
	Push `${CALLBACK}`
	Push `${VALUE}`
	Push `${SUBKEY}`
	Push `${ROOT}`
	Call ${UNFIX}${NAME}
!macroend

!macro INSERT_FUNC_ReadRegMultiStr NAME UNFIX
	Function ${UNFIX}${NAME}
		Exch $R0 ;root
		Exch
		Exch $R1 ;subkey
		Exch
		Exch 2
		Exch $R2 ;key
		Exch
		Exch 2
		Exch 3
		Exch $R3 ;function address
		Push $R4
		Push $R5
		Push $R6
		Push $R9

		System::Call /NOUNLOAD "*(i) i (0) .R4"
		Push $R4
		System::Call /NOUNLOAD "${RegOpenKeyEx}(R0, R1, 0, ${KEY_ALL_ACCESS}, R4) .R9"
		${If} $R9 = ${ERROR_SUCCESS}
		    System::Call /NOUNLOAD "*$R4(&i4 .R4)"
			System::Call /NOUNLOAD "*(i) i (0) .R0"
			System::Call /NOUNLOAD "*(i) i (0) .R1"
		    System::Call /NOUNLOAD "${RegQueryValueEx}(R4, R2, 0, R0, 0, R1) .R9"
		    ${If} $R9 = ${ERROR_SUCCESS}
			    System::Call /NOUNLOAD "*$R0(&i4 .R5)"
			    ${If} $R5 = ${REG_MULTI_SZ}
				    System::Call /NOUNLOAD "*$R1(&i4 .R5)"
				    ${If} $R5 = 0
				        SetErrors
				        SetErrorLevel 4 ;值为空
				    ${Else}
				        System::Free /NOUNLOAD $R0
				        System::Alloc /NOUNLOAD $R5
				        Pop $R0
				        System::Call /NOUNLOAD "${RegQueryValueEx}(R4, R2, 0, 0, R0, R1) .R9"
				        ${If} $R9 = ${ERROR_SUCCESS}
				            Push $R0
				            IntOp $R6 $R0 + $R5
				            ${Do}
				                System::Call /NOUNLOAD "*$R0(&t${NSIS_MAX_STRLEN} .R5)"
				                Push $R5
				                Call $R3
				                StrLen $R9 $R5
				                IntOp $R0 $R0 + $R9
				                IntOp $R0 $R0 + 1
							${LoopUntil} $R0 >= $R6
							Pop $R0
				        ${Else}
				            SetErrors
				            SetErrorLevel 2
				        ${EndIf}
				    ${EndIf}
			    ${Else}
			        SetErrors
			        SetErrorLevel 3 ;不是 REG_MULTI_SZ 类型
			    ${EndIf}
		    ${Else}
		        SetErrors
		        SetErrorLevel 2 ;无法查询注册表健
		    ${EndIf}
		    System::Call /NOUNLOAD "${RegCloseKey}(R4)"
			System::Free /NOUNLOAD $R0
			System::Free /NOUNLOAD $R1
		${Else}
		    SetErrors
		    SetErrorLevel 1 ;不能打开注册表健
		${EndIf}
		Pop $R4
		System::Free $R4

		Pop $R9
		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Pop $R0
	FunctionEnd

	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: ConvertUTF16ToUTF8
###############################################################
!insertmacro DEFINE_FUNC ConvertUTF16ToUTF8

!macro CALL_FUNC_ConvertUTF16ToUTF8 NAME UNFIX OUTPUT ADDRESS
	Push `${ADDRESS}`
	Call ${UNFIX}${NAME}
	Pop ${OUTPUT}
!macroend

!macro INSERT_FUNC_ConvertUTF16ToUTF8 NAME UNFIX
	Function ${UNFIX}${NAME}
	    Exch $R0
	    Push $R1
	    Push $R2
	    Push $R3
	    Push $R4
	    Push $R5
	    Push $R6
	    Push $R9
	    
		;指针地址压入堆栈留给函数返回时释放
		Push $R0
		
		;给输出分配内存
		System::Alloc /NOUNLOAD ${NSIS_MAX_STRLEN}
		Pop $R9
		;指针地址压入堆栈留给函数返回时释放
		Push $R9
		
		;循环里对缓冲区字符串编码(UTF-16 -> UTF-8)
		${Do}
		
		    ;取缓冲区的一个 2 字节整数
			System::Call /NOUNLOAD "*$R0(&i2 .R1)"
			
			;测试是否结束循环
			${If} $R1 <= 0
			    ${ExitDo}
			${EndIf}
			
			;$R6 记录 WCHAR 长度
		    ;一个 WCHAR(2 字节)
		    StrCpy $R6 2
		    IntOp $R2 $R1 & 0xFC00
		    ;检测 Unicode 是否是 4 字节类型
		    ${If} $R2 = 0xD800
		        ;指针移动一个 WCHAR 宽度
		        IntOp $R3 $R0 + 2
		        ;读取低位的 WCHAR
		        System::Call /NOUNLOAD "*$R3(&i2 .R4)"
		        IntOp $R5 $R4 & 0xFC00
		        ${If} $R5 = 0xDC00
					;处理 4 字节 Unicode
					IntOp $R1 $R1 & 0x3FF
					IntOp $R1 $R1 << 10
					IntOp $R4 $R4 & 0x3FF
					IntOp $R1 $R1 | $R4
					IntOp $R1 $R1 + 0x10000
					;两个 WCHAR(4 字节)
					StrCpy $R6 4
		        ${EndIf}
		    ${EndIf}
			;$R1 == Unicode 解码后的整数数据

			;UTF-8 编码
			;0x00000000 - 0x0000007F:  0xxxxxxx
			;0x00000080 - 0x000007FF:  110xxxxx 10xxxxxx
			;0x00000800 - 0x0000FFFF:  1110xxxx 10xxxxxx 10xxxxxx
			;0x00010000 - 0x001FFFFF:  11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
			;0x00200000 - 0x03FFFFFF:  111110xx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
			;0x04000000 - 0x7FFFFFFF:  1111110x 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx

			;增量指针
			IntOp $R0 $R0 + $R6
			
			;$R2 == UTF-16 字符编码后的长度(1 ~ 6)
			${If} $R1 U< 0x80
			    StrCpy $R2 1
			${ElseIf} $R1 U< 0x800
			    StrCpy $R2 2
			${ElseIf} $R1 U< 0x10000
			    StrCpy $R2 3
			${ElseIf} $R1 U< 0x200000
			    StrCpy $R2 4
			${ElseIf} $R1 U< 0x4000000
			    StrCpy $R2 5
			${ElseIf} $R1 U<= 0x7FFFFFFF
			    StrCpy $R2 6
			${Else}
			    ${ExitDo}
			${EndIf}
			
			${Switch} $R2
			    ${Case} 6
			        IntOp $R4 $R9 + 5
					IntOp $R3 $R1 & 0x3F
					IntOp $R3 $R3 | 0x80
			        System::Call /NOUNLOAD "*$R4(&i1 R3)"
			        IntOp $R1 $R1 >> 6
			        IntOp $R1 $R1 | 0x4000000
			    ${Case} 5
			        IntOp $R4 $R9 + 4
					IntOp $R3 $R1 & 0x3F
					IntOp $R3 $R3 | 0x80
			        System::Call /NOUNLOAD "*$R4(&i1 R3)"
			        IntOp $R1 $R1 >> 6
			        IntOp $R1 $R1 | 0x200000
			    ${Case} 4
			        IntOp $R4 $R9 + 3
					IntOp $R3 $R1 & 0x3F
					IntOp $R3 $R3 | 0x80
			        System::Call /NOUNLOAD "*$R4(&i1 R3)"
			        IntOp $R1 $R1 >> 6
			        IntOp $R1 $R1 | 0x10000
			    ${Case} 3
			        IntOp $R4 $R9 + 2
					IntOp $R3 $R1 & 0x3F
					IntOp $R3 $R3 | 0x80
			        System::Call /NOUNLOAD "*$R4(&i1 R3)"
			        IntOp $R1 $R1 >> 6
			        IntOp $R1 $R1 | 0x800
			    ${Case} 2
			        IntOp $R4 $R9 + 1
					IntOp $R3 $R1 & 0x3F
					IntOp $R3 $R3 | 0x80
			        System::Call /NOUNLOAD "*$R4(&i1 R3)"
			        IntOp $R1 $R1 >> 6
			        IntOp $R1 $R1 | 0xC0
			    ${Case} 1
			        System::Call /NOUNLOAD "*$R9(&i1 R1)"
			${EndSwitch}
			
			;目标地址增量
			IntOp $R9 $R9 + $R2
			
		${Loop}
		
		;弹出缓冲区地址到 $R1
        Pop $R1
		;读取目标字串
        System::Call /NOUNLOAD "*$R1(&t${NSIS_MAX_STRLEN} .R0)"
        ;释放分配的缓冲区
		System::Free /NOUNLOAD $R1
		;弹出缓冲区地址到 $R1
        Pop $R1
        ;释放分配的缓冲区
		System::Free $R1
		
		Pop $R9
		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd

	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: ConvertUTF8ToUTF16
###############################################################
!insertmacro DEFINE_FUNC ConvertUTF8ToUTF16

!macro CALL_FUNC_ConvertUTF8ToUTF16 NAME UNFIX OUTPUT STRING
	Push `${STRING}`
	Call ${UNFIX}${NAME}
	Pop ${OUTPUT}
!macroend

!macro INSERT_FUNC_ConvertUTF8ToUTF16 NAME UNFIX
	Function ${UNFIX}${NAME}
	    Exch $R0
	    Push $R1
	    Push $R2
	    Push $R3
	    Push $R4
	    Push $R5
	    Push $R6
	    Push $R7
	    Push $R9

        ;把 UTF-8 载入内存
		System::Call /NOUNLOAD "*(&t${NSIS_MAX_STRLEN} R0) i .R0"
		;指针地址压入堆栈留给函数返回时释放
		Push $R0

		;给输出分配内存
		System::Alloc /NOUNLOAD ${NSIS_MAX_STRLEN}
		Pop $R9
		;指针地址压入堆栈留给函数返回时释放
		Push $R9

		;循环里对缓冲区字符串编码(UTF-8 -> UTF-16)
		${Do}

		    ;取缓冲区的一个 1 字节整数
			System::Call /NOUNLOAD "*$R0(&i1 .R1)"

			;测试是否结束循环
			${If} $R1 <= 0
			    ${ExitDo}
			${EndIf}

			;$R6 记录 UTF-8 字符长度
			${If} $R1 U< 0x80
			    StrCpy $R6 1
			${Else}
			    IntOp $R2 $R1 & 0x80
			    ${If} $R2 = 0
			        StrCpy $R6 1
				${Else}
				    IntOp $R2 $R1 & 0xE0
				    ${If} $R2 = 0xC0
				        StrCpy $R6 2
				    ${Else}
					    IntOp $R2 $R1 & 0xF0
					    ${If} $R2 = 0xE0
					        StrCpy $R6 3
					    ${Else}
						    IntOp $R2 $R1 & 0xF8
						    ${If} $R2 = 0xF0
						        StrCpy $R6 4
						    ${Else}
							    IntOp $R2 $R1 & 0xFC
							    ${If} $R2 = 0xF8
							        StrCpy $R6 5
							    ${Else}
								    IntOp $R2 $R1 & 0xFE
								    ${If} $R2 = 0xFC
								        StrCpy $R6 6
								    ${Else}
								        ${ExitDo}
								    ${EndIf}
							    ${EndIf}
						    ${EndIf}
					    ${EndIf}
				    ${EndIf}
			    ${EndIf}
			${EndIf}
			
			IntOp $R2 $R1 & 0x1E
			${If} $R2 = 0
			${AndIf} $R6 = 2
			    ${ExitDo}
			${EndIf}
			
		    ;开始编码
		    ${If} $R6 != 1
		        IntOp $R2 $R6 + 1
		        IntOp $R2 0xFF >> $R2
		        IntOp $R1 $R1 & $R2
		    ${EndIf}
		    
		    IntOp $R2 $R6 - 1
		    ${For} $R3 1 $R2
		        IntOp $R4 $R0 + $R3
		        System::Call /NOUNLOAD "*$R4(&i1 .R5)"
		        IntOp $R4 $R5 & 0xC0
		        ${Unless} $R4 = 0x80
		            StrCpy $R6 0
		            ${ExitFor}
		        ${EndUnless}
		        
		        IntOp $R4 $R5 & 0x7F
		        IntOp $R7 7 - $R6
		        IntOp $R4 $R4 >> $R7
		        ${If} $R1 = 0
		        ${AndIf} $R3 = 2
		        ${AndIf} $R4 = 0
		            StrCpy $R6 0
		            ${ExitFor}
		        ${EndIf}
		        
		        IntOp $R1 $R1 << 6
		        IntOp $R4 $R5 & 0x3F
		        IntOp $R1 $R1 | $R4
		    ${Next}
		    
		    ${If} $R6 = 0
		        ${ExitDo}
		    ${EndIf}
		    
		    ;源字串地址增量
		    IntOp $R0 $R0 + $R6
		    ;现在 $R6 用来记录输出的字符长度
		    
		    ${If} $R1 <= 0
		    ${OrIf} $R1 U>= 0x100000
		        ${ExitDo}
		    ${EndIf}
		    
		    ${If} $R1 U>= 0x10000
		        IntOp $R2 $R1 - 0x10000
		        
                IntOp $R3 $R2 >> 10
                IntOp $R3 $R3 & 0x3FF
                IntOp $R3 $R3 | 0xD800
                System::Call /NOUNLOAD "*$R9(&i2 R3)"
                IntOp $R3 $R2 & 0x3FF
                IntOp $R3 $R3 | 0xDC00
                IntOp $R4 $R9 + 2
                System::Call /NOUNLOAD "*$R4(&i2 R3)"
		        StrCpy $R6 4
		    ${Else}
		        System::Call /NOUNLOAD "*$R9(&i2 R1)"
		        StrCpy $R6 2
		    ${EndIf}

		    ;目标字串地址增量
		    IntOp $R9 $R9 + $R6
		    
		${Loop}

		Exch
        Pop $R1
        ;释放分配的缓冲区
		System::Free $R1
		;弹出目标字串的缓冲区地址到 $R0
		Pop $R0

		Pop $R9
		Pop $R7
		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd

	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: ConvertANSIToUTF8
###############################################################
!insertmacro DEFINE_FUNC ConvertANSIToUTF8

!macro CALL_FUNC_ConvertANSIToUTF8 NAME UNFIX OUTPUT CODEPAGE STRING
	Push `${CODEPAGE}`
	Push `${STRING}`
	Call ${UNFIX}${NAME}
	Pop ${OUTPUT}
!macroend

!macro INSERT_FUNC_ConvertANSIToUTF8 NAME UNFIX
	Function ${UNFIX}${NAME}
	    Exch $R0
	    Exch
	    Exch $R1
	    Push $R2
	    Push $R3
	    Push $R4
	    Push $R5
	    Push $R6
	    Push $R9

        ${ConvertANSIToUTF16} $R0 $R1 $R0
        
		;指针地址压入堆栈留给函数返回时释放
		Push $R0

		;给输出分配内存
		System::Alloc /NOUNLOAD ${NSIS_MAX_STRLEN}
		Pop $R9
		;指针地址压入堆栈留给函数返回时释放
		Push $R9

		;循环里对缓冲区字符串编码(UTF-16 -> UTF-8)
		${Do}

		    ;取缓冲区的一个 2 字节整数
			System::Call /NOUNLOAD "*$R0(&i2 .R1)"

			;测试是否结束循环
			${If} $R1 <= 0
			    ${ExitDo}
			${EndIf}

			;$R6 记录 WCHAR 长度
		    ;一个 WCHAR(2 字节)
		    StrCpy $R6 2
		    IntOp $R2 $R1 & 0xFC00
		    ;检测 Unicode 是否是 4 字节类型
		    ${If} $R2 = 0xD800
		        ;指针移动一个 WCHAR 宽度
		        IntOp $R3 $R0 + 2
		        ;读取低位的 WCHAR
		        System::Call /NOUNLOAD "*$R3(&i2 .R4)"
		        IntOp $R5 $R4 & 0xFC00
		        ${If} $R5 = 0xDC00
					;处理 4 字节 Unicode
					IntOp $R1 $R1 & 0x3FF
					IntOp $R1 $R1 << 10
					IntOp $R4 $R4 & 0x3FF
					IntOp $R1 $R1 | $R4
					IntOp $R1 $R1 + 0x10000
					;两个 WCHAR(4 字节)
					StrCpy $R6 4
		        ${EndIf}
		    ${EndIf}
			;$R1 == Unicode 解码后的整数数据

			;UTF-8 编码
			;0x00000000 - 0x0000007F:  0xxxxxxx
			;0x00000080 - 0x000007FF:  110xxxxx 10xxxxxx
			;0x00000800 - 0x0000FFFF:  1110xxxx 10xxxxxx 10xxxxxx
			;0x00010000 - 0x001FFFFF:  11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
			;0x00200000 - 0x03FFFFFF:  111110xx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
			;0x04000000 - 0x7FFFFFFF:  1111110x 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx

			;增量指针
			IntOp $R0 $R0 + $R6

			;$R2 == UTF-16 字符编码后的长度(1 ~ 6)
			${If} $R1 U< 0x80
			    StrCpy $R2 1
			${ElseIf} $R1 U< 0x800
			    StrCpy $R2 2
			${ElseIf} $R1 U< 0x10000
			    StrCpy $R2 3
			${ElseIf} $R1 U< 0x200000
			    StrCpy $R2 4
			${ElseIf} $R1 U< 0x4000000
			    StrCpy $R2 5
			${ElseIf} $R1 U<= 0x7FFFFFFF
			    StrCpy $R2 6
			${Else}
			    ${ExitDo}
			${EndIf}

			${Switch} $R2
			    ${Case} 6
			        IntOp $R4 $R9 + 5
					IntOp $R3 $R1 & 0x3F
					IntOp $R3 $R3 | 0x80
			        System::Call /NOUNLOAD "*$R4(&i1 R3)"
			        IntOp $R1 $R1 >> 6
			        IntOp $R1 $R1 | 0x4000000
			    ${Case} 5
			        IntOp $R4 $R9 + 4
					IntOp $R3 $R1 & 0x3F
					IntOp $R3 $R3 | 0x80
			        System::Call /NOUNLOAD "*$R4(&i1 R3)"
			        IntOp $R1 $R1 >> 6
			        IntOp $R1 $R1 | 0x200000
			    ${Case} 4
			        IntOp $R4 $R9 + 3
					IntOp $R3 $R1 & 0x3F
					IntOp $R3 $R3 | 0x80
			        System::Call /NOUNLOAD "*$R4(&i1 R3)"
			        IntOp $R1 $R1 >> 6
			        IntOp $R1 $R1 | 0x10000
			    ${Case} 3
			        IntOp $R4 $R9 + 2
					IntOp $R3 $R1 & 0x3F
					IntOp $R3 $R3 | 0x80
			        System::Call /NOUNLOAD "*$R4(&i1 R3)"
			        IntOp $R1 $R1 >> 6
			        IntOp $R1 $R1 | 0x800
			    ${Case} 2
			        IntOp $R4 $R9 + 1
					IntOp $R3 $R1 & 0x3F
					IntOp $R3 $R3 | 0x80
			        System::Call /NOUNLOAD "*$R4(&i1 R3)"
			        IntOp $R1 $R1 >> 6
			        IntOp $R1 $R1 | 0xC0
			    ${Case} 1
			        System::Call /NOUNLOAD "*$R9(&i1 R1)"
			${EndSwitch}

			;目标地址增量
			IntOp $R9 $R9 + $R2

		${Loop}

		;弹出缓冲区地址到 $R1
        Pop $R1
		;读取目标字串
        System::Call /NOUNLOAD "*$R1(&t${NSIS_MAX_STRLEN} .R0)"
        ;释放分配的缓冲区
		System::Free /NOUNLOAD $R1
		;弹出缓冲区地址到 $R1
        Pop $R1
        ;释放分配的缓冲区
		System::Free $R1

		Pop $R9
		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd

	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: ConvertUTF8ToANSI
###############################################################
!insertmacro DEFINE_FUNC ConvertUTF8ToANSI

!macro CALL_FUNC_ConvertUTF8ToANSI NAME UNFIX OUTPUT CODEPAGE STRING
	Push `${CODEPAGE}`
	Push `${STRING}`
	Call ${UNFIX}${NAME}
	Pop ${OUTPUT}
!macroend

!macro INSERT_FUNC_ConvertUTF8ToANSI NAME UNFIX
	Function ${UNFIX}${NAME}
	    Exch $R0
	    Exch
	    Exch $R8
	    Push $R1
	    Push $R2
	    Push $R3
	    Push $R4
	    Push $R5
	    Push $R6
	    Push $R7
	    Push $R9

        ;把 UTF-8 载入内存
		System::Call /NOUNLOAD "*(&t${NSIS_MAX_STRLEN} R0) i .R0"
		;指针地址压入堆栈留给函数返回时释放
		Push $R0

		;给输出分配内存
		System::Alloc /NOUNLOAD ${NSIS_MAX_STRLEN}
		Pop $R9
		;指针地址压入堆栈留给函数返回时释放
		Push $R9

		;循环里对缓冲区字符串编码(UTF-8 -> UTF-16)
		${Do}

		    ;取缓冲区的一个 1 字节整数
			System::Call /NOUNLOAD "*$R0(&i1 .R1)"

			;测试是否结束循环
			${If} $R1 <= 0
			    ${ExitDo}
			${EndIf}

			;$R6 记录 UTF-8 字符长度
			${If} $R1 U< 0x80
			    StrCpy $R6 1
			${Else}
			    IntOp $R2 $R1 & 0x80
			    ${If} $R2 = 0
			        StrCpy $R6 1
				${Else}
				    IntOp $R2 $R1 & 0xE0
				    ${If} $R2 = 0xC0
				        StrCpy $R6 2
				    ${Else}
					    IntOp $R2 $R1 & 0xF0
					    ${If} $R2 = 0xE0
					        StrCpy $R6 3
					    ${Else}
						    IntOp $R2 $R1 & 0xF8
						    ${If} $R2 = 0xF0
						        StrCpy $R6 4
						    ${Else}
							    IntOp $R2 $R1 & 0xFC
							    ${If} $R2 = 0xF8
							        StrCpy $R6 5
							    ${Else}
								    IntOp $R2 $R1 & 0xFE
								    ${If} $R2 = 0xFC
								        StrCpy $R6 6
								    ${Else}
								        ${ExitDo}
								    ${EndIf}
							    ${EndIf}
						    ${EndIf}
					    ${EndIf}
				    ${EndIf}
			    ${EndIf}
			${EndIf}

			IntOp $R2 $R1 & 0x1E
			${If} $R2 = 0
			${AndIf} $R6 = 2
			    ${ExitDo}
			${EndIf}

		    ;开始编码
		    ${If} $R6 != 1
		        IntOp $R2 $R6 + 1
		        IntOp $R2 0xFF >> $R2
		        IntOp $R1 $R1 & $R2
		    ${EndIf}

		    IntOp $R2 $R6 - 1
		    ${For} $R3 1 $R2
		        IntOp $R4 $R0 + $R3
		        System::Call /NOUNLOAD "*$R4(&i1 .R5)"
		        IntOp $R4 $R5 & 0xC0
		        ${Unless} $R4 = 0x80
		            StrCpy $R6 0
		            ${ExitFor}
		        ${EndUnless}

		        IntOp $R4 $R5 & 0x7F
		        IntOp $R7 7 - $R6
		        IntOp $R4 $R4 >> $R7
		        ${If} $R1 = 0
		        ${AndIf} $R3 = 2
		        ${AndIf} $R4 = 0
		            StrCpy $R6 0
		            ${ExitFor}
		        ${EndIf}

		        IntOp $R1 $R1 << 6
		        IntOp $R4 $R5 & 0x3F
		        IntOp $R1 $R1 | $R4
		    ${Next}

		    ${If} $R6 = 0
		        ${ExitDo}
		    ${EndIf}

		    ;源字串地址增量
		    IntOp $R0 $R0 + $R6
		    ;现在 $R6 用来记录输出的字符长度

		    ${If} $R1 <= 0
		    ${OrIf} $R1 U>= 0x100000
		        ${ExitDo}
		    ${EndIf}

		    ${If} $R1 U>= 0x10000
		        IntOp $R2 $R1 - 0x10000

                IntOp $R3 $R2 >> 10
                IntOp $R3 $R3 & 0x3FF
                IntOp $R3 $R3 | 0xD800
                System::Call /NOUNLOAD "*$R9(&i2 R3)"
                IntOp $R3 $R2 & 0x3FF
                IntOp $R3 $R3 | 0xDC00
                IntOp $R4 $R9 + 2
                System::Call /NOUNLOAD "*$R4(&i2 R3)"
		        StrCpy $R6 4
		    ${Else}
		        System::Call /NOUNLOAD "*$R9(&i2 R1)"
		        StrCpy $R6 2
		    ${EndIf}

		    ;目标字串地址增量
		    IntOp $R9 $R9 + $R6

		${Loop}

		Pop $R1
		${ConvertUTF16ToANSI} $R0 $R8 $R1
		
        Pop $R1
        ;释放分配的缓冲区
		System::Free $R1
		;弹出目标字串的缓冲区地址到 $R0

		Pop $R9
		Pop $R7
		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Pop $R8
		Exch $R0
	FunctionEnd

	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: CheckFileEncoding
###############################################################
!insertmacro DEFINE_FUNC CheckFileEncoding

!macro CALL_FUNC_CheckFileEncoding NAME UNFIX OUTPUT INPUT_FILE
	Push `${INPUT_FILE}`
	Call ${UNFIX}${NAME}
	Pop ${OUTPUT}
!macroend

!macro INSERT_FUNC_CheckFileEncoding NAME UNFIX
	Function ${UNFIX}${NAME}
		; This fuction is based on the read of the Byte Order Mark (BOM) : a file
		; signature that indicates the file encode (see XML Spec Appendices F1).
		; (This function is a variation of the ChekFileEncoding made for Bluenet,
		; it磗 part of his reg2nsis utility).

		; NOTE :
		; - Little-endian ::: Describes a computer architecture . The PDP-11 and VAX
		; families of computers and Intel microprocessors are little-endian.

		; - Big-endian ::: Describes a computer architecture .The IBM 370 family,
		; the PDP-10, the Motorola microprocessor families, and most of the various
		; RISC designs are big-endian

		; - The term ANSI is used to collectively refer to all the non-Unicode single
		; and multi-byte character sets used in Windows operating systems. These include
		; the single-byte systems for Europe and the "double-byte" systems for Chinese
		; and Japanese which actually use one or two bytes per character

		; - UCS ::: Universal Character Set (UCS-2 => 2 bytes ; UCS-4 => 4 bytes)

		; - UTF ::: Unicode transformation Format (UTF-8 , UTF-16 )

		Exch $R0
		Push $R1
		Push $R2
		Push $R3
		Push $R4


		FileOpen $R0 $R0 r ; the name of the file is not using
		
		FileReadByte $R0 $R1 ;$R1 have the first byte of the file
		FileSeek $R0 1
		FileReadByte $R0 $R2 ;$R2 have the second byte of the file
		FileSeek $R0 2
		FileReadByte $R0 $R3 ;$R3 have the third byte of the file
		FileSeek $R0 3
		FileReadByte $R0 $R4 ;$R4 have the fourth byte of the file

		FileClose $R0

		StrCpy $R0 $R1$R2$R3$R4
		StrCmp $R0 76111167148 0 +3 ;hex = 4C 6F A7 94
		StrCpy $R0 ${BOM_EBCDIC}
		Goto end
		StrCmp $R0 25525400 0 +3 ;hex = FF FE 00 00 (BOM)
		StrCpy $R0 ${BOM_UCS4_LE}
		Goto end
		StrCmp $R0 00254255 0 +3 ;hex = 00 00 FE FF (BOM)
		StrCpy $R0 ${BOM_UCS4_BE}
		Goto end
		StrCmp $R0 060063 0 +3 ;hex = 00 3C 00 3F
		StrCpy $R0 ${BOM_UTF16_BE}
		Goto end
		StrCmp $R0 600630 0 +3 ;hex = 3C 00 3F 00
		StrCpy $R0 ${BOM_UTF16_LE}
		Goto end
		StrCpy $R0 $R1$R2
		StrCmp $R0 255254 0 +3 ;hex = FF FE (BOM)
		StrCpy $R0 ${BOM_UNICODE_LE} ;In Windows Unicode => UTF-16 ? . Least significant byte is written first. ;
		Goto end
		StrCmp $R0 254255 0 +3 ;hex = FE FF (BOM)
		StrCpy $R0 ${BOM_UNICODE_BE} ;In Windows Unicode => UTF-16 ? . Most significant byte is written first.
		Goto end
		StrCpy $R0 $R1$R2$R3
		StrCmp $R0 239187191 0 +3 ;hex = EF BB BF (BOM)
		StrCpy $R0 ${BOM_UTF8} ;A character could be written in one, two or three bytes
		Goto end
		StrCpy $R0 ${BOM_ANSI} ;The Default value should be ANSI, because
		;in ASCII character ANSI = UTF-8,
		;but in Asia language ANSI != UTF-8.
		end:

		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Exch $R0
	FunctionEnd

	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: WriteEnvStr
###############################################################
!insertmacro DEFINE_FUNC WriteEnvStr

!macro CALL_FUNC_WriteEnvStr NAME UNFIX ENV_NAME ENV_VALUE FOR_USER
	Push `${FOR_USER}`
	Push `${ENV_VALUE}`
	Push `${ENV_NAME}`
	Call ${UNFIX}${NAME}
!macroend

!macro INSERT_FUNC_WriteEnvStr NAME UNFIX
	Function ${UNFIX}${NAME}
		Exch $R0 ;name
		Exch
		Exch $R1 ;value
		Exch
		Exch 2
		Exch $R2 ;user
		Push $R3
		Push $R4
		Push $R5
		Push $R6
		Push $R7
		Push $R8
		Push $R9

		${IsWinNT} $R3
		${If} $R3 = ${TRUE}
		
		    ;for all user
		    IntOp $R3 $R2 & ${LOCAL_MACHINE}
		    ${If} $R3 = ${LOCAL_MACHINE}
		        ReadRegStr $R3 HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" $R0
	            GetLabelAddress $R9 back_to_all_user
	            Goto add
	            back_to_all_user:
		        ${If} $R3 != ``
		            WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" $R0 $R3
		        ${EndIf}
		    ${EndIf}
		    
		    ;for current user
		    IntOp $R3 $R2 & ${CURRENT_USER}
		    ${If} $R3 = ${CURRENT_USER}
		        ReadRegStr $R3 HKCU "Environment" $R0
	            GetLabelAddress $R9 back_to_current_user
	            Goto add
	            back_to_current_user:
		        ${If} $R3 != ``
		            WriteRegExpandStr HKCU "Environment" $R0 $R3
		        ${EndIf}
		    ${EndIf}
		    
		    ;发送消息通知设置更改
		    SendMessage ${HWND_BROADCAST} ${WM_SETTINGCHANGE} 0 "STR:Environment" /TIMEOUT=5000

		${Else}
		
		    ;写入 Win9X 环境变量
		    StrCpy $R2 $WINDIR 2
			FileOpen $R2 "$R2\autoexec.bat" r
			;创建临时文件
			GetTempFileName $R4
			Push $R4
			FileOpen $R4 $R4 w
			
			${Do}
			
				ClearErrors
				FileRead $R2 $R3
				${If} ${Errors}
				    ;如果没有找到存在的变量名，则写入新的
				    FileWrite $R4 `$\r$\nSET $R0=$R1$\r$\n`
				    ${ExitDo}
				${EndIf}
				
				StrCpy $R5 $R3
				StrCpy $R6 $R5 4
				${If} $R6 == `SET `
				    StrCpy $R5 $R5 `` 4
				    StrCpy $R6 $R5 1
				    
				    ${While} $R6 == ` `
				        StrCpy $R5 $R5 `` 1
				        StrCpy $R6 $R5 1
				    ${EndWhile}
				    
				    ${StrStrI} $R6 $R5 `=`
				    ${If} $R6 == ``
				        FileWrite $R4 $R3
				        ${Continue}
				    ${EndIf}
				    
				    StrLen $R7 $R6
				    StrLen $R8 $R5
				    IntOp $R7 $R8 - $R7
				    StrCpy $R5 $R5 $R7
				    
				    StrCpy $R7 $R5 `` -1
				    ${While} $R7 == ` `
				        StrCpy $R5 $R5 -1
				        StrCpy $R7 $R5 `` -1
				    ${EndWhile}
				    
				    ;名称不同则继续
				    ${If} $R5 != $R0
				        FileWrite $R4 $R3
				        ${Continue}
				    ${EndIf}
				    
				    StrCpy $R6 $R6 `` 1
				    StrCpy $R5 $R6 1
				    ${While} $R5 == ` `
				        StrCpy $R6 $R6 `` 1
				        StrCpy $R5 $R6 1
				    ${EndWhile}
				    
				    ${TrimRN} $R6
				    StrCpy $R7 $R6 `` -1
				    ${While} $R7 == ` `
				        StrCpy $R6 $R6 -1
				        StrCpy $R7 $R6 `` -1
				    ${EndWhile}

				    StrCpy $R3 $R6
		            GetLabelAddress $R9 back_to_9x_user
		            Goto add
		            back_to_9x_user:
				    FileWrite $R4 `SET $R0=$R3$\r$\n`
				    
			        ${Do}
			            ClearErrors
						FileRead $R2 $R5
						${If} ${Errors}
						    ${ExitDo}
						${EndIf}
						FileWrite $R4 $R5
			        ${Loop}
			        
				    ${ExitDo}
				${EndIf}

			${Loop}
			
			FileClose $R2
			FileClose $R4
			
			Pop $R4
			StrCpy $R2 $WINDIR 2
			${CopyFile} $R4 `$R2\autoexec.bat`
			${DeleteFile} $R4
			SetRebootFlag true
			
		${EndIf}

		Goto end
	    add:
	        ${If} $R3 == ``
	            StrCpy $R3 $R1
	        ${Else}
		        ${StrStrI} $R8 `;$R3;` `;$R1;` ;两边加 ; 以确保搜索的完整性
		        ${If} $R8 == `` ;不存在时才写入
		            StrCpy $R3 `$R3;$R1`
		        ${EndIf}
	        ${EndIf}
	        Goto $R9
		end:
		
		Pop $R9
		Pop $R8
		Pop $R7
		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Pop $R0
	FunctionEnd

	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend

###############################################################
# 函数: DeleteEnvStr
###############################################################
!insertmacro DEFINE_FUNC DeleteEnvStr

!macro CALL_FUNC_DeleteEnvStr NAME UNFIX ENV_NAME ENV_VALUE FOR_USER
	Push `${FOR_USER}`
	Push `${ENV_VALUE}`
	Push `${ENV_NAME}`
	Call ${UNFIX}${NAME}
!macroend

!macro INSERT_FUNC_DeleteEnvStr NAME UNFIX
	Function ${UNFIX}${NAME}
		Exch $R0 ;name
		Exch
		Exch $R1 ;value
		Exch
		Exch 2
		Exch $R2 ;user
		Push $R3
		Push $R4
		Push $R5
		Push $R6
		Push $R7
		Push $R8
		Push $R9

		${IsWinNT} $R3
		${If} $R3 = ${TRUE}

		    ;for all user
		    IntOp $R3 $R2 & ${LOCAL_MACHINE}
		    ${If} $R3 = ${LOCAL_MACHINE}
		        ReadRegStr $R3 HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" $R0
		        ${If} $R3 != ``
		            GetLabelAddress $R9 back_to_all_user
		            Goto remove
		            back_to_all_user:
		            ${If} $R3 == ``
		                DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" $R0
		            ${Else}
		            	WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" $R0 $R3
		            ${EndIf}
	            ${EndIf}
		    ${EndIf}

		    ;for current user
		    IntOp $R3 $R2 & ${CURRENT_USER}
		    ${If} $R3 = ${CURRENT_USER}
		        ReadRegStr $R3 HKCU "Environment" $R0
		        ${If} $R3 != ``
		            GetLabelAddress $R9 back_to_current_user
		            Goto remove
		            back_to_current_user:
		            ${If} $R3 == ``
		                DeleteRegValue HKCU "Environment" $R0
		            ${Else}
		            	WriteRegExpandStr HKCU "Environment" $R0 $R3
		            ${EndIf}
	            ${EndIf}
		    ${EndIf}

		    ;发送消息通知设置更改
		    SendMessage ${HWND_BROADCAST} ${WM_SETTINGCHANGE} 0 "STR:Environment" /TIMEOUT=5000

		${Else}

		    ;移除 Win9X 环境变量
		    StrCpy $R2 $WINDIR 2
			FileOpen $R2 "$R2\autoexec.bat" r
			;创建临时文件
			GetTempFileName $R4
			Push $R4
			FileOpen $R4 $R4 w

			${Do}

				ClearErrors
				FileRead $R2 $R3
				${If} ${Errors}
				    ${ExitDo}
				${EndIf}

				StrCpy $R5 $R3
				StrCpy $R6 $R5 4
				${If} $R6 == `SET `
				    StrCpy $R5 $R5 `` 4
				    StrCpy $R6 $R5 1

				    ${While} $R6 == ` `
				        StrCpy $R5 $R5 `` 1
				        StrCpy $R6 $R5 1
				    ${EndWhile}

				    ${StrStrI} $R6 $R5 `=`
				    ${If} $R6 == ``
				        FileWrite $R4 $R3
				        ${Continue}
				    ${EndIf}

				    StrLen $R7 $R6
				    StrLen $R8 $R5
				    IntOp $R7 $R8 - $R7
				    StrCpy $R5 $R5 $R7

				    StrCpy $R7 $R5 `` -1
				    ${While} $R7 == ` `
				        StrCpy $R5 $R5 -1
				        StrCpy $R7 $R5 `` -1
				    ${EndWhile}

				    ;名称不同则继续
				    ${If} $R5 != $R0
				        FileWrite $R4 $R3
				        ${Continue}
				    ${EndIf}

				    StrCpy $R6 $R6 `` 1
				    StrCpy $R5 $R6 1
				    ${While} $R5 == ` `
				        StrCpy $R6 $R6 `` 1
				        StrCpy $R5 $R6 1
				    ${EndWhile}

				    ${TrimRN} $R6
				    StrCpy $R7 $R6 `` -1
				    ${While} $R7 == ` `
				        StrCpy $R6 $R6 -1
				        StrCpy $R7 $R6 `` -1
				    ${EndWhile}

				    StrCpy $R3 $R6
		            GetLabelAddress $R9 back_to_9x_user
		            Goto remove
		            back_to_9x_user:
				    ${If} $R3 != ``
				    	FileWrite $R4 `SET $R0=$R3$\r$\n`
				    ${EndIf}
				    
			        ${Do}
			            ClearErrors
						FileRead $R2 $R5
						${If} ${Errors}
						    ${ExitDo}
						${EndIf}
						FileWrite $R4 $R5
			        ${Loop}
			        
				    ${ExitDo}
				${EndIf}

			${Loop}

			FileClose $R2
			FileClose $R4

			Pop $R4
			StrCpy $R2 $WINDIR 2
			${CopyFile} $R4 `$R2\autoexec.bat`
			${DeleteFile} $R4
			SetRebootFlag true

		${EndIf}

		Goto end
	    remove:
	        ${If} $R3 == $R1
	        ${OrIf} $R3 == ``
	            StrCpy $R3 ``
	            Goto $R9
	        ${EndIf}

	        ${StrStrI} $R6 `;$R3;` `;$R1;` ;两边加 ; 以确保搜索的完整性
	        ${If} $R6 == ``
	            Goto $R9
	        ${EndIf}

	        StrLen $R7 $R6
	        StrLen $R8 `;$R3;`
	        IntOp $R7 $R8 - $R7
	        ${If} $R7 > 0
	        	IntOp $R7 $R7 - 1
	        ${EndIf}
	        StrCpy $R3 $R3 $R7 ;$R3 == 左边的字串
	        StrCpy $R6 $R6 -1
	        StrCpy $R6 $R6 `` 1
	        ${StrStrI} $R7 $R6 `;`
	        ${If} $R7 != ``
	            ${If} $R3 == ``
	                StrCpy $R7 $R7 `` 1
	            ${EndIf}
	        	StrCpy $R3 `$R3$R7`
	        ${EndIf}
	        Goto $R9
		end:
		
		Pop $R9
		Pop $R8
		Pop $R7
		Pop $R6
		Pop $R5
		Pop $R4
		Pop $R3
		Pop $R2
		Pop $R1
		Pop $R0
	FunctionEnd

	!insertmacro DEFINE_CALL `${NAME}` `${UNFIX}`
!macroend




















!verbose pop
!endif ;end of USEFULLLIB define

