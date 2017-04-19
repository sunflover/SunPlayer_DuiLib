/*
#脚本范例<ButtonLinker.nsi>#
编写：X-Star, zhfi
描述：利用插件与头文件创建超级按钮&链接&菜单，无需修改UI即可实现
资源：插件 "ButtonLinker.dll"、"System.dll" 及头文件 "UseFulLib.nsh"
*/

!AddPluginDir ".\"
!AddIncludeDir ".\"

!include MUI2.nsh
;!include ButtonLinkerLib.nsh
!include UsefulLib.nsh

; --------------------------------------------------
; General settings.

Name "ButtonLinker Example"
OutFile "ButtonLinkerMUI.exe"
SetCompressor /SOLID lzma

ReserveFile "${NSISDIR}\Plugins\ButtonLinker.dll"

InstallDir $ExeDir

; --------------------------------------------------
; MUI interface settings.

 # We want to use our own UI with custom buttons!
 # The event handler for our parent button is added in MyGUIInit.
 !define MUI_CUSTOMFUNCTION_GUIINIT .MyGUIInit
# Don't skip to the finish page.
 !define MUI_FINISHPAGE_NOAUTOCLOSE

; --------------------------------------------------
; Insert MUI pages.

; Installer pages
 !insertmacro MUI_PAGE_WELCOME

 !insertmacro MUI_PAGE_LICENSE ButtonLinker.nsi

 !insertmacro MUI_PAGE_Directory

 !insertmacro MUI_PAGE_INSTFILES      

!define MUI_PAGE_CUSTOMFUNCTION_PRE Finish
 !insertmacro MUI_PAGE_Finish
; UnInstaller pages
!define MUI_CUSTOMFUNCTION_UnGUIINIT Un.MyGUIInit
 !insertmacro MUI_UnPAGE_WELCOME
 !insertmacro MUI_UnPAGE_INSTFILES

; --------------------------------------------------
; Languages.

 !insertmacro MUI_LANGUAGE "SimpChinese"

/*定义要创建的控件ID*/
;注意：ID不能重复，否则会产生未知错误！
;定义关于按钮
!ifndef IDC_BUTTON
!define IDC_BUTTON 			1190
!endif
;定义链接
!ifndef IDC_LINKER
!define IDC_LINKER 			1200
!endif
;定义复选框CheckBox2
!ifndef IDC_CheckBox2
!define IDC_CheckBox2 		1210
!endif
;定义复选框CheckBox3
!ifndef IDC_CheckBox3
!define IDC_CheckBox3 		1220
!endif
;定义关于菜单1       
!ifndef IDM_SEPARATOR
!define IDM_SEPARATOR 			1300
!endif
!ifndef IDM_ABOUT1
!define IDM_ABOUT1 			1301
!endif
;定义关于菜单2
!ifndef IDM_ABOUT2
!define IDM_ABOUT2 			1302
!endif

; --------------------------------------------------
; 创建公共函数
!macro MYMACRO un

Function ${un}.AboutButton
	MessageBox MB_OK|MB_ICONINFORMATION "关于按钮!"
FunctionEnd

Function ${un}.AboutMenu1
  MessageBox MB_OK|MB_ICONINFORMATION "关于菜单1!"
FunctionEnd
Function ${un}.AboutMenu2
  MessageBox MB_OK|MB_ICONINFORMATION "关于菜单2!"
FunctionEnd

Function ${un}.CheckBox3
/*获取控件状态*/
	;用法：${GetButtonState} 输出变量(0/1/error) 父窗口窗口句柄 控件ID
	${GetButtonState} $0 $HWNDPARENT ${IDC_CheckBox3}
;  MessageBox MB_OK|MB_ICONINFORMATION "$0"
${if} $0 == 0
  MessageBox MB_yesno|MB_ICONINFORMATION "取消选择？" idyes true idno false
true:
	${SetButtonState} 0 $HWNDPARENT ${IDC_CheckBox3}
goto End
false:
	${SetButtonState} 1 $HWNDPARENT ${IDC_CheckBox3}
goto End
${elseif} $0 == 1
  MessageBox MB_yesno|MB_ICONINFORMATION "选择？" idyes true2 idno false2
true2:
	${SetButtonState} 1 $HWNDPARENT ${IDC_CheckBox3}
goto End
false2:
	${SetButtonState} 0 $HWNDPARENT ${IDC_CheckBox3}
goto End
${else}
  MessageBox MB_OK|MB_ICONINFORMATION "$0!"
${endif}
End:
FunctionEnd

Function ${un}.MyGUIInit
InitPluginsDir

Pop $0
Pop $1
Pop $2
Pop $3

/*创建超级按钮*/
	;获取“取消”按钮的位置
    ${GetDlgItemRect} $0 $1 $2 $3 $HWNDPARENT ${IDC_CANCEL}
	IntOp $2 $3 - $1
	;用法：${CreateButton2} 显示文本 X轴位置 Y轴位置 宽度 高度 父窗口窗口句柄 控件ID 目标函数
	;参考“取消”的位置来创建超级按钮
	${CreateButton2} "关于(&A)" 20 $1 80 $2 $HWNDPARENT ${IDC_BUTTON} ${un}.AboutButton

/*创建超级链接*/
	;获取“取消”按钮的位置
    ${GetDlgItemRect} $0 $1 $2 $3 $HWNDPARENT ${IDC_CANCEL}
	IntOp $2 $3 - $1
	IntOp $1 $1 + 4
	IntOp $2 $2 - 1
	;用法：${CreateLinker2} 显示文本 X轴位置 Y轴位置 宽度 高度 父窗口窗口句柄 控件ID 链接地址
	;参考“取消”的位置来创建超级链接
	${CreateLinker2} "访问我的主页" 120 $1 80 $2 $HWNDPARENT ${IDC_LINKER} "http://hi.baidu.com/xstar2008"

/*创建超级复选框*/
	;获取“取消”按钮的位置
    ${GetDlgItemRect} $0 $1 $2 $3 $HWNDPARENT ${IDC_CANCEL}
	IntOp $2 $3 - $1
	IntOp $1 $1 + 4
	IntOp $2 $2 - 1
	;用法：${CreateCheckBox2} 显示文本 X轴位置 Y轴位置 宽度 高度 父窗口窗口句柄 控件ID 控件状态(0/1)
	;参考“取消”的位置来创建超级复选框
	${CreateCheckBox2} "CheckBox2" 200 $1 50 $2 $HWNDPARENT ${IDC_CheckBox2} 1

	;用法：${CreateCheckBox3} 显示文本 X轴位置 Y轴位置 宽度 高度 父窗口窗口句柄 控件ID 控件状态(0/1) 目标函数
	;参考“取消”的位置来创建超级复选框
	${CreateCheckBox3} "CheckBox3" 250 $1 50 $2 $HWNDPARENT ${IDC_CheckBox3} 0 ${un}.CheckBox3


/*创建超级菜单*/
	;用法：${CreateMenu2} 显示文本 菜单类型 父窗口窗口句柄 菜单ID
	${CreateMenu} 0 ${MF_SEPARATOR} $HWNDPARENT ${IDM_SEPARATOR}
	;用法：${CreateMenu2} 显示文本 菜单类型 父窗口窗口句柄 菜单ID 目标函数
	${CreateMenu2} "关于菜单1(&A)" ${MF_STRING} $HWNDPARENT ${IDM_ABOUT1} ${un}.AboutMenu1
	${CreateMenu2} "关于菜单2(&A)" ${MF_STRING} $HWNDPARENT ${IDM_ABOUT2} ${un}.AboutMenu2

FunctionEnd

Function ${un}.onGUIEnd
ButtonLinker::unload
FunctionEnd

; --------------------------------------
!macroend

; 插入安装/卸载函数
!insertmacro MYMACRO ""
!insertmacro MYMACRO "un"

Function ${un}.Love
  MessageBox MB_OK|MB_ICONINFORMATION "爱你一万年!"
FunctionEnd

 Section "Dummy" SecDummy
${DeleteMenu2} $HWNDPARENT ${IDM_ABOUT1}
  Sleep 1000
/*获取控件状态*/
	;用法：${GetButtonState} 输出变量(0/1/error) 父窗口窗口句柄 控件ID
	${GetButtonState} $0 $HWNDPARENT ${IDC_CheckBox2}
StrCmp $0 1 0 +2
	Messagebox MB_OK "你想干嘛？"
  Sleep 1000
WriteUninstaller "$Exedir\uninst.exe"

${ModifyMenu2} $HWNDPARENT ${IDM_ABOUT2} "我爱你" ${un}.Love
 SectionEnd

Section Uninstall
Delete "$Instdir\Uninst.exe"
SectionEnd

Function Finish
${DeleteMenu2} $HWNDPARENT ${IDM_ABOUT2}
${DeleteMenu} $HWNDPARENT ${IDM_SEPARATOR}
${DestroyWindow} $HWNDPARENT ${IDC_BACK}
${DestroyWindow} $HWNDPARENT ${IDC_CANCEL}
FunctionEnd

