!include "WordFunc.nsh"
!include "nsWindows.nsh"
!ifndef HWNDAboutWindow
var HWNDAboutWindow
!define HWNDAboutWindow
!endif

!macro Func un
Function ${un}GUIInit
;窗口置顶
System::Call "user32::SetWindowPos(i $HWNDPARENT, i -1, i0, i0, i0, i0, i 3)"

;设置透明度(请放于GUIInit)
StrCpy $R2 220  ;透明度（0-255）
System::Call 'User32::GetWindowLong(i $HWNDPARENT, i -20) .iR0'
IntOp $R0 $R0 + 0x80000
System::Call 'User32::SetWindowLong(i $HWNDPARENT, i -20, i R0) .iR1'
System::Call 'User32::SetLayeredWindowAttributes(i $HWNDPARENT, i 0, i R2, i 2) .i R0'
;检查更新按钮
GetFunctionAddress $R0 ${un}CheckUpdate
ButtonEvent::AddEventHandler /NOUNLOAD 10 $R0
FunctionEnd


Function ${un}CheckUpdate
${NSW_CreateWindow} $HWNDAboutWindow "关于 $(^NameDA) v${VERSION}" 1018
SetCtlColors $HWNDAboutWindow ""   0xFFFFFF
${NSW_SetWindowSize} $HWNDAboutWindow 250 250
${NSW_CenterWindow} $HWNDAboutWindow $hwndparent
${NSW_SetTransparent} $HWNDAboutWindow 95
${NSW_OnBack} ${un}AboutClose

${NSW_CreateLabel} 5% 5% 90% 25% "NSIS插件及代码资源合集$\r$\n代码编写：Ansifa$\r$\n编译日期：${__TIMESTAMP__}$\r$\n版本：${VersionS}(${Version})"
Pop $R0
SetCtlColors $R0 0x000000 0xFFFFFF

${NSW_CreateLabel} 5% 31% 90% 35% "本扩展包包含了大部分NSIS官方网站上的插件并且按照标准格式整理好。并且基本每个插件都有至少一个官方或自己编写的例子，便于新手学习。同时也加入了一些较常用或较有价值的代码例子，大家可以参考下。"
Pop $R0
SetCtlColors $R0 0x00468C 0xFFFFFF

${NSW_CreateLabel} 5% 68% 90% 12% "本资源合集最新版本可以在此软件的SVN网址上找到。详细地址是："
Pop $R0
SetCtlColors $R0 0x3399FF 0xFFFFFF

${NSW_CreateLink} 5% 82% 90% 12% "NSIS Extend Pack Project"
Pop $R0
SetCtlColors $R0 0xFF0080 0xFFFFFF
${NSW_OnClick} $R0 ${un}UpdateLink

StrCpy $0 100
StrCpy $1 12

${NSW_Show}

ShowWindow $HWNDAboutWindow ${SW_SHOW}
EnableWindow $HWNDPARENT 0
FunctionEnd

Function ${un}AboutClose
${NSW_CloseWindow} $HWNDAboutWindow
EnableWindow $HWNDPARENT 1
BringToFront
FunctionEnd

Function ${un}UpdateLink
ExecShell open "http://nsisfans.googlecode.com/svn/trunk/NSISExtendPack/Build" SW_SHOWMAXIMIZED
FunctionEnd
!macroend

!insertmacro Func ""
!insertmacro Func "Un."


Function PRE
;在页面预加载时载入flash
System::Call 'user32::LoadImage(i,t,i,i,i,i,) i (0,"$PLUGINSDIR\modern-wizard.bmp",0,0,0,0x2010) .s'
Pop $R0
System::Call '$PLUGINSDIR\FlashLib::FlashLibInit(i,i,i,i,i,i,i) i (0,0,164,291,$HWNDPARENT,$R0,true) .s'
Pop $hBitmap
System::Call '$PLUGINSDIR\FlashLib::FlashLoadMovie(i,t) i ($hBitmap,"$PLUGINSDIR\1.swf")'
FunctionEnd

Function LEAVE
;页面结束时卸载插件
System::Call '$PLUGINSDIR\FlashLib::FlashLibFree(i $hBitmap)'
FunctionEnd

Function INSTFILE_SHOW
w7tbp::Start
titprog::Start
FunctionEnd

