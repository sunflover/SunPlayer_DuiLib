#       ExtractDllEx Example
#       By Ansifa
#       2008.12.12

;将此文件夹下*.exe压缩到此文件夹下Output\pack.7z_,以备程序解压
;CompressFile.exe 命令行:
;	CompressFile.exe "输出已压缩的文件" "输入未经压缩的文件"
!system "md Output"
!system "cd Output"
!system "CompressFile.exe Output\pack.7z_ *.exe"

SetCompressor /SOLID lzma
SetCompress force
XPStyle on
SetFont /LANG=2052 "tahoma" 8
LoadLanguageFile "${NSISDIR}\Contrib\Language files\SimpChinese.nlf"

ShowInstDetails show
OutFile "Output\ExtractDllEx.EXE"
Name "Extractdll Test"
Section

;ExtractDllEx::extract "已解压,但是待分割的临时文件" "输入已经压缩的文件"
ExtractDllEx::extract "pack.tmp" "pack.7z_"
Pop $0
StrCmp $0 "success" +1 +2
MessageBox MB_ICONINFORMATION|MB_OK '解压成功!'

DetailPrint '返回值:$0'
SectionEnd
