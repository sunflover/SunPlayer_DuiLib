/*
		NSIS 超级按钮&链接&菜单示例

		编写: gfm688
*/

!addplugindir ..\..\Plugins
!addIncludedir ..\..\Include

!include MUI.nsh
!include nsCtrl.nsh

!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit

;!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_COMPONENTS
;!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
;!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "SimpChinese"

Name "NSIS 超级按钮&链接&菜单"
OutFile "nsLink.exe"
ShowInstDetails show

Section Test
	DetailPrint "$$_CLICK 变量恢复为: $_CLICK"
SectionEnd

!define IDM_ABOUT	1000
!define IDC_ABOUT	1300
!define IDC_LINK	1301

Function onGUIInit
	nsLink::Init  					;初始化插件并注册"nsLink"窗口类
	StrCpy $0 $HWNDPARENT		;设置要在其上创建控件的对话框句柄为$HWNDPARENT
	${CreateButton} 10u 201u 50u 14u "关于(&A)" ${IDC_ABOUT}
	${CreateLink} 65u 204u 50u 9u "梦想吧技术论坛" ${IDC_LINK}
; 可选是否绘制焦点, 如果控件没有WS_TABSTOP样式则不绘制焦点
	;${CreateControl} "nsLink" ${DEFAULT_STYLES} 0 65u 204u 50u 9u  ${IDC_LINK}
; 每次创建控件后, 控件句柄都保存在$1

; LM_SETHOVERPARAM 为自定义消息, 用于设置鼠标经过时的颜色和是否有下划线变化效果
; wParam为COLORREF颜色值; lParam为1则有下划线变化效果, 为0则没有
	SendMessage $1 ${LM_SETHOVERPARAM} 0xFF8000 1

; 支持用SetCtlColors改变颜色, 但要绘制焦点或下划线变化效果, 则不能将背景设为透明
;	SetCtlColors $1 /BRANDING 0x000080
;	Call FixBkColor

; 添加关于菜单项
	System::Call User32::GetSystemMenu(i$HWNDPARENT,i0)i.r2
	System::Call User32::AppendMenu(ir2,i${MF_SEPARATOR},i0,i0)
	System::Call User32::AppendMenu(ir2,i${MF_STRING},i${IDM_ABOUT},t"关于安装程序(&A)")

; 给父窗口设置点击按钮或菜单项时的回调函数
	GetFunctionAddress $2 onGUIClick
	System::Call nsLink::OnClick(i$HWNDPARENT,ir2)
FunctionEnd

Function onGUIClick
	${If} $_CLICK = ${IDM_ABOUT}
		MessageBox MB_ICONINFORMATION|MB_OK "关于菜单 by gfm688"
	${ElseIf} $_CLICK = ${IDC_ABOUT}
		MessageBox MB_ICONINFORMATION|MB_OK "关于按钮 by gfm688"
	${ElseIf} $_CLICK = ${IDC_LINK}
	  ExecShell open www.dreams8.com
	  ;GetDlgItem $1 $HWNDPARENT ${IDC_LINK}
	  SendMessage $1 ${WM_SETTEXT} 0 "STR:你已访问梦想吧论坛"
	  ;SendMessage $1 ${LM_SETHOVERPARAM} 0x800080 0
	  SetCtlColors $1 /BRANDING 0x800080
	  Call FixBkColor
	${EndIf}
FunctionEnd

Function FixBkColor
; SetCtlColors用/BRANDING参数, 控件背景还是透明的, 可用SetWindowLong修正下
	System::Call User32::GetWindowLong(ir1,i-21)i.r2
	System::Call *$2(i,i,i0,i,i2,i16|8|4|1)
	System::Call User32::SetWindowLong(ir1,i-21,ir2)
FunctionEnd
