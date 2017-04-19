/*
		修改UI文件使用nsLink示例

		编写: gfm688
*/

;!addplugindir ..\..\Plugins
;!addIncludedir ..\..\Include

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
ChangeUI IDD_INST "UI.exe"

/*
  用ResHacker修改${NSISDIR}\Contrib\UIs\modern.exe
  在105对话框添加如下代码, 编译后另存为UI.exe
	CONTROL "关于(&A)", 1300, BUTTON, BS_PUSHBUTTON | WS_CHILD | WS_VISIBLE | WS_TABSTOP, 10, 201, 50, 14
	CONTROL "梦想吧技术论坛", 1301, "nsLink", 0x5001000B, 65, 204, 59, 9
*/

Section Test
	DetailPrint "$$_CLICK 变量恢复为: $_CLICK"
SectionEnd

!define IDM_ABOUT	1000
!define IDC_ABOUT	1300
!define IDC_LINK	1301

Function .onInit
	nsLink::Init  	
FunctionEnd

Function onGUIInit
; 修改UI添加的控件, 系统会自动创建, 而且是在调用.onGUIInit之前创建的, 所以必须在.onInit注册nsLink类

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
	${EndIf}
FunctionEnd
