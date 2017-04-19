!include 'MUI2.nsh'

Name "TT4.8在线下载"
OutFile "NSISdl.exe"

ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "SimpChinese"

Section Install

    NSISdl::download /TRANSLATE2 '正在下载 %s' '正在连接...' '(剩余 1 秒)' '(剩余 1 分钟)' '(剩余 1 小时)' '(剩余 %u 秒)' '(剩余 %u 分钟)' '(剩余 %u 小时)' '已完成：%skB(%d%%) 大小：%skB 速度：%u.%01ukB/s' /TIMEOUT=7500 /NOIEPROXY 'http://dl_dir.qq.com/invc/tt/tt4.8setupv892.exe' '$EXEDIR\tt4.8setupv892.exe'
    Pop $R0
    StrCmp $R0 "success" 0 +3
    MessageBox MB_YESNO|MB_ICONQUESTION "TT4.8 已成功下载至：$\r$\n$\t$EXEDIR\tt4.8setupv892.exe$\r$\n是否立即执行安装程序？" IDNO +2
    ExecWait '$EXEDIR\tt4.8setupv892.exe'

SectionEnd