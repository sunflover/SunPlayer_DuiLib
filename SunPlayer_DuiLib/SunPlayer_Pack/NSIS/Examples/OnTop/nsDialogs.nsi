!include nsDialogs.nsh
!include LogicLib.nsh

Name "OnTop nsDialogs Example"
OutFile "nsDialogs Example.exe"

LoadLanguageFile "${NSISDIR}\Contrib\Language files\SimpChinese.nlf"
LangString Name 2052 "Simplified Chinese"

XPStyle on

Page custom nsDialogsPage

Var BUTTON
Var CHECKBOX

Function nsDialogsPage

	nsDialogs::Create /NOUNLOAD 1018
	Pop $0

	${NSD_CreateButton} 0 10 100% 15u '取消窗口置顶'
	Pop $BUTTON
	GetFunctionAddress $0 OnClick
	nsDialogs::OnClick /NOUNLOAD $BUTTON $0

	${NSD_CreateCheckbox} 0 -50 100% 10u '窗口置顶'
	Pop $CHECKBOX
	GetFunctionAddress $0 OnCheckbox
	nsDialogs::OnClick /NOUNLOAD $CHECKBOX $0

	${NSD_CreateLabel} 0 40u 75% 40u "* Demo程序默认窗口置顶$\n$\n* 更改Checkbox选取状态进行窗体置顶切换"
	Pop $0

	nsDialogs::Show

FunctionEnd

Function OnClick

  ;取消窗口置顶
   OnTop::OffTop
  ;取消checkbox的选择状态
   ${NSD_SetState} $CHECKBOX ${BST_UNCHECKED}
   
FunctionEnd




Function OnCheckbox

  ${NSD_GetState} $CHECKBOX $0
  ${If} $0 == ${BST_CHECKED}
   	OnTop::OnTop
  ${Else}
    OnTop::OffTop
  ${EndIf}

FunctionEnd

Function .onGUIInit

  ;窗口置顶
  OnTop::OnTop
  
FunctionEnd

Section '-形式需要'
SectionEnd
