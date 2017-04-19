/*
<NSIS图片火焰特效脚本>
脚本编写：zhfi
特别感谢：Restools，X-Star

提示:火焰底图必须是翻转的图片，显示的时候会翻转图片来显示。
*/
;更详细的注解说明, 请查看水纹插件的脚本范例: WaterCtrl.nsi

!include MUI.nsh
; --------------------------------------------------
; General settings.
Name "FireCtrl_Test Example"
OutFile "FireCtrl_Test.exe"
SetCompressor /SOLID lzma     

ReserveFile "${NSISDIR}\Plugins\System.dll"
ReserveFile "${NSISDIR}\Plugins\FireCtrl.dll"

SetFont Tahoma 8
; --------------------------------------------------
; MUI interface settings.
!define MUI_FINISHPAGE_NOAUTOCLOSE
; --------------------------------------------------
; Insert MUI pages.
!define MUI_WELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\win.bmp"

; Installer pages
!define MUI_PAGE_CUSTOMFUNCTION_PRE Pre
!define MUI_PAGE_CUSTOMFUNCTION_SHOW Show
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE Leave
!insertmacro MUI_PAGE_WELCOME

!insertmacro MUI_PAGE_INSTFILES

!define MUI_PAGE_CUSTOMFUNCTION_Pre Pre
!define MUI_PAGE_CUSTOMFUNCTION_SHOW Show
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE Leave
!insertmacro MUI_PAGE_FINISH
; --------------------------------------------------
; Languages.
!insertmacro MUI_LANGUAGE "SimpChinese"

Section ""
SectionEnd

Function .onInit
  InitPluginsDir
  File "/oname=$PLUGINSDIR\FireCtrl.dll" "${NSISDIR}\Plugins\FireCtrl.dll"
FunctionEnd

Function .onGUIEnd
  FireCtrl::disablefire
  System::Free
FunctionEnd

Function Pre
FunctionEnd

Function Show
  System::Call 'user32::LoadImage(i,t,i,i,i,i,) i (0,"$PLUGINSDIR\modern-wizard.bmp",0,0,0,0x2010) .s'
  Pop $R0
  !insertmacro INSTALLOPTIONS_READ $R1 "ioSpecial.ini" "Field 1" "HWND"
  System::Call '$PLUGINSDIR\FireCtrl::enablefire(i,i,i,i,i) i ($R1,0,0,$R0,50)'
FunctionEnd

Function Leave
  System::Call '$PLUGINSDIR\FireCtrl::disablefire()'
FunctionEnd
