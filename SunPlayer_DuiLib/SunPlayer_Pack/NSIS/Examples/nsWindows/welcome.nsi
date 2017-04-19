!addincludedir "..\..\include"

!include MUI.nsh
!include LogicLib.nsh
!include WinMessages.nsh
!include FileFunc.nsh

!include nsWindows.nsh

Name "nsWindows Welcome"
OutFile "nsWindows Welcome.exe"

;!insertmacro MUI_PAGE_WELCOME
Page custom nsWindowsWelcome  ;将 nsWindowsWelcome 函数作为自定义页面调用, 事实上会自动跳转到下页(因为它并不存在^^)
;Page custom nsWindowsDirectory
;!insertmacro MUI_PAGE_CUSTOMFUNCTION_PRE nsWindowsWelcome
;!insertmacro MUI_PAGE_CUSTOMFUNCTION_LEAVE nsWindowsDirectory

!insertmacro MUI_PAGE_INSTFILES  ;安装过程页面
Page custom nsWindowsDirectory  ;与上类似
!insertmacro MUI_PAGE_FINISH    ;完成页面

!insertmacro MUI_LANGUAGE SimpChinese  ;语言

;变量
Var WINDOW
;Var DIALOG
Var HEADLINE
Var TEXT
Var IMAGECTL
Var IMAGE
Var DIRECTORY
Var FREESPACE

Var HEADLINE_FONT

Function .onInit

	InitPluginsDir  ;初始化插件目录
	
	CreateFont $HEADLINE_FONT "$(^Font)" "14" "700"  ;创建字体

  ;释放图片文件
	File /oname=$PLUGINSDIR\welcome.bmp "${NSISDIR}\Contrib\Graphics\Wizard\orange-nsis.bmp"

FunctionEnd

Function nsWindowsWelcome

	${NSW_CreateWindow} $WINDOW "nsWindowsWelcome" 1044  ;创建窗口
;	nsWindows::Create 1044

	${NSW_CreateBitmap} 0 0 109u 193u ""  ;创建位图容器控件, 用于容纳图片
	Pop $IMAGECTL

  ;创建位图
	StrCpy $0 $PLUGINSDIR\welcome.bmp
	System::Call 'user32::LoadImage(i 0, t r0, i ${IMAGE_BITMAP}, i 0, i 0, i ${LR_LOADFROMFILE}) i.s'
	Pop $IMAGE
	
	;将位图放入位图容器控件中
	SendMessage $IMAGECTL ${STM_SETIMAGE} ${IMAGE_BITMAP} $IMAGE

	${NSW_CreateLabel} 120u 10u -130u 20u "Welcome to nsWindows!"
	Pop $HEADLINE

	SendMessage $HEADLINE ${WM_SETFONT} $HEADLINE_FONT 0   ;设置字体

	${NSW_CreateLabel} 120u 32u -130u -32u "nsWindows is the next generation of user interfaces in NSIS. It gives the developer full control over custom pages. Some of the features include control text containing variables, callbacks directly into script functions and creation of any type of control. Create boring old edit boxes or load some external library and create custom controls with no need of creating your own plug-in.$\r$\n$\r$\nUnlike InstallOptions, nsWindows doesn't use INI files to communicate with the script. By interacting directly with the script, nsWindows can perform much faster without the need of costly, old and inefficient INI operations. Direct interaction also allows direct calls to functions defined in the script and removes the need of conversion functions like Io2Nsis.$\r$\n$\r$\nHit the Next button to see how it all fits into a mock directory page."
	Pop $TEXT

	SetCtlColors $WINDOW "" 0xffffff    ;设置颜色
;	SetCtlColors $DIALOG "" 0xffffff
	SetCtlColors $HEADLINE "" 0xffffff
	SetCtlColors $TEXT "" 0xffffff

;	Call HideControls

	${NSW_Show}    ;显示窗口
;	nsWindows::Show

;	Call ShowControls

;	System::Call gdi32::DeleteObject(i$IMAGE)

FunctionEnd

!define SHACF_FILESYSTEM 1

Function nsWindowsDirectory

	!insertmacro MUI_HEADER_TEXT "Choose Install Location" "Choose the folder in which to install $(^NameDA)."

	GetDlgItem $0 $HWNDPARENT 1    ;获取控件句柄, 这里得到的是"下一步"按钮
	EnableWindow $0 0              ;禁用/启用控件

;	nsWindows::Create 1018
	${NSW_CreateWindow} $WINDOW "nsWindowsDirectory" 1018

	${NSW_CreateLabel} 0 0 100% 30 "Directory page"
	Pop $HEADLINE

	SendMessage $HEADLINE ${WM_SETFONT} $HEADLINE_FONT 0

	${NSW_CreateLabel} 0 30 100% 40 "Select the installation directory of NSIS to continue. $_CLICK"
	Pop $TEXT

	${NSW_CreateText} 0 75 100% 12u ""
	Pop $DIRECTORY

	SendMessage $HWNDPARENT ${WM_NEXTDLGCTL} $DIRECTORY 1

	${NSW_OnChange} $DIRECTORY DirChange   ;添加控件更改事件, 一般用于Text, 在用户输入内容的时候执行

	System::Call shlwapi::SHAutoComplete(i$DIRECTORY,i${SHACF_FILESYSTEM})  ;自动添加该路径下的子文件夹列表

	${NSW_CreateLabel} 0 -10u 100% 10u ""
	Pop $FREESPACE

	Call UpdateFreeSpace  ; 更新磁盘空余区间信息

	${NSW_Show}
;	nsWindows::Show

FunctionEnd

Function UpdateFreeSpace   ; 更新磁盘空余区间信息

	${GetRoot} $INSTDIR $0
	StrCpy $1 " bytes"

	System::Call kernel32::GetDiskFreeSpaceEx(tr0,*l,*l,*l.r0)

	${If} $0 > 1024
	${OrIf} $0 < 0
		System::Int64Op $0 / 1024
		Pop $0
		StrCpy $1 "kb"
		${If} $0 > 1024
		${OrIf} $0 < 0
			System::Int64Op $0 / 1024
			Pop $0
			StrCpy $1 "mb"
			${If} $0 > 1024
			${OrIf} $0 < 0
				System::Int64Op $0 / 1024
				Pop $0
				StrCpy $1 "gb"
			${EndIf}
		${EndIf}
	${EndIf}

	SendMessage $FREESPACE ${WM_SETTEXT} 0 "STR:Free space: $0$1"

FunctionEnd

Function DirChange

	Pop $0 # dir hwnd

	GetDlgItem $0 $HWNDPARENT 1

	System::Call user32::GetWindowText(i$DIRECTORY,t.d,i${NSIS_MAX_STRLEN})

	${If} ${FileExists} $INSTDIR\makensis.exe
		EnableWindow $0 1
	${Else}
		EnableWindow $0 0
	${EndIf}

	Call UpdateFreeSpace

FunctionEnd

Section
  SetAutoClose False
SectionEnd
