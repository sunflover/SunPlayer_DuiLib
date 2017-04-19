#	FindProc Example
#   By Ansifa
#   2008-12-12

OutFile "FindProc.EXE"
Name "FindProc Test"
SetFont /LANG=2052 "tahoma" 8
LoadLanguageFile "${NSISDIR}\Contrib\Language files\SimpChinese.nlf"

Section

#	用法:
#	FindProcDLL::FindProc "进程名"
#	返回值直接在$R0,不需要Pop $R0之类.

FindProcDLL::FindProc "taskmgr.exe"
StrCmp $R0 1 +1 +2
MessageBox MB_ICONINFORMATION|MB_OK 'Windows进程管理器正在运行!'
SectionEnd
