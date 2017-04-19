;把原版插件中的下载进度条从中间移到了下面，并且隐藏了原来的取消按钮。
;测试请先把Plugins目录中的inetc(Modify).dll重命名为inetc.dll再编译。

XPStyle on
Name "Inetc Test"
OutFile "Inetc.exe"

!include "MUI.nsh"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

ShowInstDetails nevershow

Section "Dummy Section" SecDummy
  inetc::get /TRANSLATE "正在下载 %s" "正在连接..." 秒 分 时 s "已完成：%dkB (%d%%) 大小：%dkB  速度：%d.%01dkB/s" "(剩余：%d %s%s)" 'http://appldnld.apple.com/iTunes10/041-6239.20120611.Cdre4/iTunesSetup.exe' '$TEMP\iTunesSetup.exe'
  ExecWait '$TEMP\iTunesSetup.exe /quiet /norestart' $R1
  Delete "$TEMP\iTunesSetup.exe"
SectionEnd


