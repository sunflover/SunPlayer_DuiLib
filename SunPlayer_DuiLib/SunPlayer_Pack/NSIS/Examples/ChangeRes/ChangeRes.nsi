#   ChangeRes Test
#   By Ansifa
#   2008-12-12
SetCompressor /SOLID lzma
SetCompress force
XPStyle on
SetFont /LANG=2052 "tahoma" 8
LoadLanguageFile "${NSISDIR}\Contrib\Language files\SimpChinese.nlf"
OutFile "ChangeRes.EXE"
Name "ChangeRes Test"
Section
;ChangeRes::ChangeResolution 宽度 高度 色深 刷新率
ChangeRes::ChangeResolution 1152 864 32 72
SectionEnd
