/*
<NSIS图片水纹特效脚本>
脚本编写：zhfi
特别感谢：Restools，X-Star

提示:水纹底图必须是翻转的图片，显示的时候会翻转图片来显示。
*/

!include MUI.nsh ;插入需要使用的头文件
; --------------------------------------------------
; General settings.

Name "WaterCtrl_Test Example"
OutFile "WaterCtrl_Test.exe"
SetCompressor /SOLID lzma
    
;添加保留文件, 一般是安装程序自身需要使用的或者是提前释放的资源/插件等文件
ReserveFile "${NSISDIR}\Plugins\System.dll"
ReserveFile "${NSISDIR}\Plugins\WaterCtrl.dll"

; --------------------------------------------------
; MUI interface settings.
!define MUI_FINISHPAGE_NOAUTOCLOSE  ;不自动进入完成页面
; --------------------------------------------------
; Insert MUI pages.
!define MUI_WELCOMEFINISHPAGE_BITMAP  "${NSISDIR}\Contrib\Graphics\Wizard\win.bmp"

; Installer pages  ;添加页面自定义函数
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

Function .onInit  ;程序初始化函数, 一般是释放需要用到的插件等资源
  InitPluginsDir  ;初始化临时插件目录
  File "/oname=$PLUGINSDIR\WaterCtrl.dll" "${NSISDIR}\Plugins\WaterCtrl.dll" ;释放水纹插件到临时插件目录
FunctionEnd

Function .onGUIEnd  ;程序关闭函数, 一般是释放所用的插件, 以便于安装程序在退出时清空自己的临时目录
  WaterCtrl::disablewater
  System::Free
FunctionEnd

Function Pre   ;定义的页面预处理函数. 在这里, 这个函数不需要使用
  ;如果需要跳过此页面, 在此函数中添加Abort终止即可
FunctionEnd

Function Show   ;自定义的页面显示函数, 一般是用于定制当前页面的内容
  System::Call 'user32::LoadImage(i,t,i,i,i,i,) i (0,"$PLUGINSDIR\modern-wizard.bmp",0,0,0,0x2010) .s' ;将位图载入内存中
  Pop $R0  ;如果载入成功, 这里弹出的是内存中位图的句柄
  !insertmacro INSTALLOPTIONS_READ $R1 "ioSpecial.ini" "Field 1" "HWND"  ;读取图片容器的句柄
  System::Call '$PLUGINSDIR\WaterCtrl::enablewater(i,i,i,i,i,i) i ($R1,0,0,$R0,3,50)'  ;开始水纹特效
  System::Call '$PLUGINSDIR\WaterCtrl::setwaterparent(i $R1)'  ;设置图片的句柄为图片容器
  System::Call '$PLUGINSDIR\WaterCtrl::flattenwater()'
  System::Call '$PLUGINSDIR\WaterCtrl::waterblob(i,i,i,i) i (70,198,10,1000)'
FunctionEnd

Function Leave   ;自定义的页面离开函数, 一般用于当前页面的收尾工作
  System::Call '$PLUGINSDIR\WaterCtrl::disablewater()' ;停止水纹波动
FunctionEnd
