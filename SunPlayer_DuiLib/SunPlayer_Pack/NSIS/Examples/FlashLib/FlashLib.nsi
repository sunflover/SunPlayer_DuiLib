/*
<NSIS图片Flash特效脚本>
脚本编写：zhfi
特别感谢：风铃夜思雨，Restools，X-Star
*/
;更详细的注解说明, 请查看水纹插件的脚本范例: WaterCtrl.nsi

Var hFlash ;定义Flash句柄变量

!include MUI.nsh
; --------------------------------------------------
; General settings.
Name "FlashLib_Test Example"
OutFile "FlashLib_Test.exe"
SetCompressor /SOLID lzma     

ReserveFile "${NSISDIR}\Plugins\System.dll"
ReserveFile "${NSISDIR}\Plugins\FlashLib.dll"
ReserveFile "${NSISDIR}\Examples\FlashLib\1.swf"
; --------------------------------------------------
; MUI interface settings.
!define MUI_FINISHPAGE_NOAUTOCLOSE

; --------------------------------------------------
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
; --------------------------------------------------
Section ""
SectionEnd

Function .onInit
  InitPluginsDir
!define MySWF "$PLUGINSDIR\1.swf"
  File "/oname=${MySWF}" "${NSISDIR}\Examples\FlashLib\1.swf"
  File "/oname=$PLUGINSDIR\FlashLib.dll" "${NSISDIR}\Plugins\FlashLib.dll"
FunctionEnd

Function Pre
FunctionEnd

Function Show
  System::Call 'user32::LoadImage(i,t,i,i,i,i,) i (0,"$PLUGINSDIR\modern-wizard.bmp",0,0,0,0x2010) .s'
  Pop $R0
  !insertmacro INSTALLOPTIONS_READ $R1 "ioSpecial.ini" "Field 1" "HWND"  ;读取图片容器的句柄
  System::Call '$PLUGINSDIR\FlashLib::FlashLibInit(i,i,i,i,i,i,i) i (0,0,164,291,$R1,$R0,true) .s'
  Pop $hFlash
  System::Call '$PLUGINSDIR\FlashLib::FlashLoadMovie(i,t) i ($hFlash, "${MySWF}")'
FunctionEnd

Function Leave
  System::Call '$PLUGINSDIR\FlashLib::FlashLibFree(i $hFlash)'
FunctionEnd

Function .onGUIEnd
  System::Call '$PLUGINSDIR\FlashLib::FlashLibFree(i $hFlash)'
  System::Free
  ;由于FlashLib插件并不是原生的NSIS插件, 因此最后的释放函数可能并不适用
  ;需要将文件设置为重启删除, 避免临时插件残留
  Delete /REBOOTOK "$PLUGINSDIR\FlashLib.dll"
  RMDIR /REBOOTOK "$PLUGINSDIR"
FunctionEnd
