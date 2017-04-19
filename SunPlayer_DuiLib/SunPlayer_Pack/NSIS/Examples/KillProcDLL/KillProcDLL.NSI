#	KillProc Example
#   By Ansifa
#   2008-12-12

OutFile "KillProc.EXE"
Name "KillProc Test"
SetFont /LANG=2052 "tahoma" 8
LoadLanguageFile "${NSISDIR}\Contrib\Language files\SimpChinese.nlf"

Section

#	用法:
#	KillProcDLL::KillProc "进程名"
#	返回值直接在$R0,不需要Pop $R0之类.

KillProcDLL::KillProc "taskmgr.exe"
StrCmp $R0 0 +1 +2
MessageBox MB_ICONINFORMATION|MB_OK 'Windows进程管理器成功结束!'
StrCmp $R0 603 +1 +2
MessageBox MB_ICONINFORMATION|MB_OK 'Windows进程管理器并未运行!'
SectionEnd
