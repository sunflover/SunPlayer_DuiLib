#       Extractdll Example
#       By Ansifa
#       2008.12.12

;将..\..\Plugins\ExtractDLL.dll压缩到此文件夹下ExtractDLL.dl_,以备运行正确
;CompressFile.exe 命令行:
;	CompressFile.exe "输出已压缩的文件" "输入未经压缩的文件"
!system "CompressFile.exe ..\..\Plugins\ExtractDLL.dll ExtractDLL.dl_"



SetCompressor /SOLID lzma
SetCompress force
XPStyle on
SetFont /LANG=2052 "tahoma" 8
LoadLanguageFile "${NSISDIR}\Contrib\Language files\SimpChinese.nlf"
ShowInstDetails show
OutFile "Extractdll.EXE"
Name "Extractdll Test"
Section

;ExtractDLL::extract "输出未压缩的文件" "输入已经压缩的文件"

ExtractDLL::extract "$EXEDIR\ExtractDLL.dll" "$EXEDIR\ExtractDLL.dl_"
Pop $0

StrCmp $0 "success" +1 +2
MessageBox MB_ICONINFORMATION|MB_OK '解压成功!'

DetailPrint '返回值:$0'
SectionEnd
