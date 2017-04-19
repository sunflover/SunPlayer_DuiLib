/*
		nsCtrl 实例

		编写: gfm688
*/

!addplugindir ..\..\Plugins
!addIncludedir ..\..\Include

!include MUI.nsh
!include nsCtrl.nsh

!define MUI_CUSTOMFUNCTION_GUIINIT myGUIInit
;!define MUI_CUSTOMFUNCTION_UNGUIINIT un.myGUIInit

;!insertmacro MUI_PAGE_WELCOME
!define MUI_PAGE_CUSTOMFUNCTION_SHOW CompShow
!insertmacro MUI_PAGE_COMPONENTS
!define MUI_PAGE_CUSTOMFUNCTION_SHOW DirShow
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE DirLeave
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
;!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "SimpChinese"

OutFile "nsCtrl.exe"
Name "NSIS 超级按钮&链接&菜单&复选框&单选框"
DirText "程序安装目录" " " "浏览(&B)" "请选择安装路径"
InstallDir "$PROGRAMFILES\QQ\"
ShowInstDetails show
ShowUnInstDetails show
SetFont Tahoma 8

!define IDM_ABOUT			1100
!define IDC_ABOUT			1300
!define IDC_LINK1			1301
!define IDC_LINK2			1302
!define IDC_CHECK			1303
!define IDC_RADIO1		1305
!define IDC_RADIO2		1306
!define IDC_RADIO3		1307
!define IDC_DIR2			1308
!define IDC_BROWSE2		1309

Section Test
	ReserveFile ..\..\Docs\nsLink\ReadMe.txt
	DetailPrint "$$_CLICK 变量恢复为: $_CLICK"
	DetailPrint "安装目录: $INSTDIR"
	DetailPrint "个人文件夹: $R0"
	WriteUninstaller $EXEDIR\unist.exe
SectionEnd

Function .onInit
	StrCpy $R0 "$DOCUMENTS\Tencent Files"
	StrCpy $R1 "${IDC_RADIO1}"
FunctionEnd


	Function myGUIInit
		nsLink::Init
		StrCpy $0 $HWNDPARENT
		${CreateButton} 10u 201u 50u 14u "关于(&A)" ${IDC_ABOUT}
		${CreateLink} 65u 204u 50 9u "梦想吧技术论坛" ${IDC_LINK1}
		${CreateCheckBox} 125u 204u 50u 9u "复选框" ${IDC_CHECK}
		${NSD_Check} $1

		System::Call User32::GetSystemMenu(i$HWNDPARENT,i0)i.r2
		System::Call User32::AppendMenu(ir2,i${MF_SEPARATOR},i0,i0)
		System::Call User32::AppendMenu(ir2,i${MF_STRING},i${IDM_ABOUT},t"关于安装程序(&A)")

		GetFunctionAddress $2 onGUIClick
		System::Call nsLink::OnClick(i$HWNDPARENT,ir2)
	FunctionEnd

	Function onGUIClick
		${If} $_CLICK = ${IDM_ABOUT}
			MessageBox MB_ICONINFORMATION|MB_OK "关于菜单 by gfm688"
		${ElseIf} $_CLICK = ${IDC_ABOUT}
			MessageBox MB_ICONINFORMATION|MB_OK "关于按钮 by gfm688"
		${ElseIf} $_CLICK = ${IDC_LINK1}
		  ExecShell open www.dreams8.com
	 	${ElseIf} $_CLICK = ${IDC_CHECK}
	 		MessageBox MB_ICONINFORMATION|MB_OK "你想干嘛？"
		${EndIf}
	FunctionEnd


Function CompShow
	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $1 $0 ${IDC_TEXT1}
	${DestroyControl} $1
	${MoveDlgItem} $0 ${IDC_TEXT2} "0, 30, 95, 65"
	${MoveDlgItem} $0 ${IDC_SPACEREQUIRED} "0, 112, 100, 10"
	${MoveDlgItem} $0 ${IDC_TREE1} "102, 29, 98, 90"
	${MoveDlgItem} $0 1042 "210, 25, 89, 94"  ;GROUPBOX
	${MoveDlgItem} $0 1043 "215, 35, 78, 79"

	${CreateCheckBox} 0 129u 152 10u "我已经阅读并且同意接受" ${IDC_LICENSEAGREE}
	${NSD_Check} $1
	${CreateLink} 153 129u 100 10u "《最终用户使用协议》" ${IDC_LINK2}
	CreateFont $2 $(^Font) $(^FontSize) 400 /UNDERLINE
	SendMessage $1 ${WM_SETFONT} $2 0
	SendMessage $1 ${LM_SETHOVERPARAM} 0xFF0000 0
	
	GetFunctionAddress $2 onPageClick1
	System::Call nsLink::OnClick(i$0,ir2)
FunctionEnd

Function DirShow
	FindWindow $0 "#32770" "" $HWNDPARENT
	${MoveDlgItem} $0 ${IDC_INTROTEXT} "5, 1, 175, 11"
	${MoveDlgItem} $0 ${IDC_BROWSE} "238, 15, 46, 14"
	${MoveDlgItem} $0 ${IDC_DIR} "18, 16, 217, 12"
	${MoveDlgItem} $0 ${IDC_SPACEREQUIRED} "18, 34, 82, 10"
	${MoveDlgItem} $0 ${IDC_SPACEAVAILABLE} "109, 34, 90, 9"
	${CreateLabel} 5u 60u 175u 11u "个人文件夹" ${IDC_STATIC}
	${CreateLabel} 19u 73u 307u 11u "请选择个人文件夹" ${IDC_STATIC}
	${CreateRadioButton} 19u 85u 100u 10u "保存到安装目录下" ${IDC_RADIO1}
	${NSD_Check} $1
	${CreateRadioButton} 19u 97u 102u 10u '保存到"我的文档"(推荐)' ${IDC_RADIO2}
	${CreateRadioButton} 19u 109u 40u 10u "自定义" ${IDC_RADIO3}
	System::Call User32::CheckRadioButton(ir0,i${IDC_RADIO1},i${IDC_RADIO3},iR1)
	${CreateControl} "EDIT" 0x40010080 ${WS_EX_CLIENTEDGE} 31u 121u 204u 12u "$R0" ${IDC_DIR2}
	System::Call Shlwapi::SHAutoComplete(ir1,i1)
	${IfThen} $R1 = ${IDC_RADIO3} ${|} ShowWindow $1 ${SW_SHOWNA} ${|}
	${CreateControl} "BUTTON" 0x40010000 0 238u 120u 46u 14u "浏览(&O)" ${IDC_BROWSE2}
	${IfThen} $R1 = ${IDC_RADIO3} ${|} ShowWindow $1 ${SW_SHOWNA} ${|}
	GetDlgItem $1 $0 ${IDC_SELDIRTEXT}   ;GROUPBOX
	${DestroyControl} $1

	GetFunctionAddress $2 onPageClick2
	System::Call nsLink::OnClick(i$0,ir2)
FunctionEnd

Function DirLeave
  System::Call User32::IsDlgButtonChecked(ir0,i${IDC_RADIO1})i.r2
  StrCmp $2 ${BST_UNCHECKED} +3
  StrCpy $R0 "$INSTDIR\Users"
  Goto _leave
  System::Call User32::IsDlgButtonChecked(ir0,i${IDC_RADIO2})i.r2
  StrCmp $2 ${BST_UNCHECKED} +3
  StrCpy $R0 "$DOCUMENTS\Tencent Files"
  Goto _leave
	Call CheckPath
_leave:
FunctionEnd

Function onPageClick1
	${If} $_CLICK = ${IDC_LICENSEAGREE}
		GetDlgItem $1 $0 $_CLICK
		${NSD_GetState} $1 $2
		GetDlgItem $1 $HWNDPARENT 1
		EnableWindow $1 $2
 	${ElseIf} $_CLICK = ${IDC_LINK2}
		File /oname=$PLUGINSDIR\ReadMe.txt ..\..\Docs\nsLink\ReadMe.txt
		ExecShell open $PLUGINSDIR\ReadMe.txt
	${EndIf}
FunctionEnd

Function onPageClick2
	${If} $_CLICK = ${IDC_RADIO1}
	${OrIf} $_CLICK = ${IDC_RADIO2}
	${OrIf} $_CLICK = ${IDC_RADIO3}
	  StrCpy $R1 $_CLICK
		GetDlgItem $1 $0 ${IDC_RADIO3}
		${NSD_GetState} $1 $2
	  ${ShowDlgItem} $0 ${IDC_DIR2} $2
		${ShowDlgItem} $0 ${IDC_BROWSE2} $2
	${ElseIf} $_CLICK = ${IDC_BROWSE2}
	  GetDlgItem $1 $0 ${IDC_DIR2}
	  ${NSD_GetText} $1 $R0
		Call SelectFolderDialog
		StrCmp $R0 "" +2
		${NSD_SetText} $1 $R0
	${EndIf}
FunctionEnd

Function SelectFolderDialog
	System::Get "(i.r3, i.r4, i, i) ir5s"
	Pop $2
	System::Call '*(i$HWNDPARENT,i,t,t"选择个人文件夹",i0x0x0045,kr2,i,i)i.r6'
	System::Call Shell32::SHBrowseForFolder(ir6)i.r7
	${Do}
	  Pop $5
		${IfThen} $5 == 0 ${|} ${ExitDo} ${|}
		StrCmp $4 1 0 +2
		System::Call User32::SendMessage(ir3,i0x466,i1,tR0)
		StrCpy $5 0
		System::Call "$2"
	${Loop}
	System::Free $2
	System::Free $6
  System::Call Shell32::SHGetPathFromIDList(ir7,t.R0)
  System::Call ole32::CoTaskMemFree(ir7)
FunctionEnd

# 检测路径是否合法
Function CheckPath
	System::Call User32::GetDlgItemText(ir0,i1308,t.R0,i260) 
	System::Call Shlwapi::PathStripToRoot(tR0r2)i.r3
  StrCmp $3 0 _bad
  System::Call Shlwapi::PathFileExists(tr2)i.r3
	StrCmp $3 0 _bad
	System::Call Shlwapi::PathSearchAndQualify(tR0,t.R0,i260)
	StrLen $3 $R0
	StrCmp $3 3 0 +3
		MessageBox MB_ICONEXCLAMATION|MB_OK "个人文件夹不能为磁盘根目录!"
		Abort
  System::Call Kernel32::GetDiskFreeSpaceEx(tr2,*l.r3,*l,*l)
  System::Int64Op $3 < 50000000
  Pop $3
	StrCmp $3 1 0 _end
		MessageBox MB_ICONEXCLAMATION|MB_OK "个人文件夹所在磁盘空间不足!"
		Abort
_bad:
	MessageBox MB_ICONEXCLAMATION|MB_OK "个人文件夹路径不合法!"
	Abort
_end:
FunctionEnd

Section Uninstall
  DetailPrint "$$_CLICK 变量恢复为: $_CLICK"
	GetDlgItem $2 $HWNDPARENT ${IDC_CHECK1}
	${NSD_GetState} $2 $2
	DetailPrint "复选框状态: $2"
SectionEnd


