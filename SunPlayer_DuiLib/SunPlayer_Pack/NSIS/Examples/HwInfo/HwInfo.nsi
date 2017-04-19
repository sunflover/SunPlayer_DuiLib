;	HwInfo Exmple
;	by Ansifa
;	2008-12-12

ShowInstDetails show
OutFile "HwInfo.EXE"
Name "HwInfo Test"
SetFont /LANG=2052 "tahoma" 8
LoadLanguageFile "${NSISDIR}\Contrib\Language files\SimpChinese.nlf"

Section
HwInfo::GetCpuSpeed
DetailPrint 'CPU 速度 : $0'

HwInfo::GetSystemMemory
DetailPrint '系统内存 : $0MB'

HwInfo::GetVideoCardName
DetailPrint '显卡名称 : $0'

HwInfo::GetVideoCardMemory
DetailPrint '显存大小 : $0MB'
SectionEnd
