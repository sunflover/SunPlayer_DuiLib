/*
#脚本范例<RadioButton.nsi>#
编写：X-Star, zhfi
描述：利用插件与头文件创建单选按钮，无需修改UI即可实现
资源：插件 "Buttonlinker.dll"、"System.dll" 及头文件 "UseFulLib.nsh"
*/

!AddPluginDir ".\"
!AddIncludeDir ".\"

!include MUI2.nsh
!include UseFulLib.nsh

; --------------------------------------------------
; General settings.

Name "RadioButton Example"
OutFile "RadioButtonMUI.exe"
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
!define MUI_PAGE_WELCOME_SHOW InstFilesShow

 !insertmacro MUI_PAGE_LICENSE RadioButton.nsi

 !insertmacro MUI_PAGE_Directory

 ;!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesShow
 !insertmacro MUI_PAGE_INSTFILES

; UnInstaller pages
!define MUI_CUSTOMFUNCTION_UnGUIINIT Un.MyGUIInit
 !insertmacro MUI_UnPAGE_INSTFILES

; --------------------------------------------------
; Languages.

 !insertmacro MUI_LANGUAGE "SimpChinese"

; --------------------------------------------------

/*定义要创建的控件ID*/
;注意：ID不能重复，否则会产生未知错误！
;定义关于按钮
!ifndef IDC_RadioButton1
!define IDC_RadioButton1 			1231
!endif
!ifndef IDC_RadioButton2
!define IDC_RadioButton2 			1232
!endif
!ifndef IDC_RadioButton3
!define IDC_RadioButton3 			1233
!endif

; 创建公共函数
!macro MYMACRO un

Function ${un}.RadioButton3
MessageBox MB_OK RadioButton3
FunctionEnd


Function ${un}.MyGUIInit
InitPluginsDir

Pop $0
Pop $1
Pop $2
Pop $3

/*创建单选按钮组*/
	;获取“取消”按钮的位置
    ${GetDlgItemRect} $0 $1 $2 $3 $HWNDPARENT ${IDC_CANCEL}
	IntOp $2 $3 - $1
	;创建单选按钮组：${CreateRadioButtonGroup} 显示文本 X轴位置 Y轴位置 宽度 高度 父窗口窗口句柄 控件ID 控件状态(0/1)
	;创建单选按钮组：${CreateRadioButtonGroup2} 显示文本 X轴位置 Y轴位置 宽度 高度 父窗口窗口句柄 控件ID 控件状态(0/1) 目标函数
	;创建单选按钮组(附属于CreateRadioButtonGroup创建的圆钮)：${CreateRadioButton} 显示文本 X轴位置 Y轴位置 宽度 高度 父窗口窗口句柄 控件ID 控件状态(0/1)
	;创建单选按钮组(附属于CreateRadioButtonGroup创建的圆钮)：${CreateRadioButton2} 显示文本 X轴位置 Y轴位置 宽度 高度 父窗口窗口句柄 控件ID 控件状态(0/1) 目标函数
	;参考“取消”的位置来创建单选按钮
	${CreateRadioButtonGroup} "RadioButton1" 20 $1 100 $2 $HWNDPARENT ${IDC_RadioButton1} 0
	${CreateRadioButton} "RadioButton2" 120 $1 100 $2 $HWNDPARENT ${IDC_RadioButton2} 0
	${CreateRadioButton2} "RadioButton3" 220 $1 100 $2 $HWNDPARENT ${IDC_RadioButton3} 0 ${un}.RadioButton3

	;用法：${CheckRadioButton} 父窗口窗口句柄 组中第一个单选按钮ID  组中最后一个单选按钮ID 要勾选的单选按钮ID
	${CheckRadioButton} $HWNDPARENT ${IDC_RadioButton1} ${IDC_RadioButton3} ${IDC_RadioButton2}
 
FunctionEnd

Function ${un}.onGUIEnd
ButtonLinker::unload
FunctionEnd

; --------------------------------------
!macroend

; 插入安装/卸载函数
!insertmacro MYMACRO ""
!insertmacro MYMACRO "un"

 Section "Dummy" SecDummy
/*获取控件状态*/
	;用法：${GetButtonState} 输出变量(0/1/error) 父窗口窗口句柄 控件ID
	${GetButtonState} $0 $HWNDPARENT ${IDC_RadioButton2}
StrCmp $0 1 0 +2
	Messagebox MB_OK "你想干嘛？"
  Sleep 1000
WriteUninstaller "$Exedir\uninst.exe"
 SectionEnd

Section Uninstall
Delete "$Instdir\Uninst.exe"
SectionEnd

