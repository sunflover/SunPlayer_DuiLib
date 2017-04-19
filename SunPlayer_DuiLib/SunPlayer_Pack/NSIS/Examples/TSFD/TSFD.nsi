SetCompressor /SOLID lzma
SetCompress force
XPStyle on
OutFile "TSFD Example.EXE"
Name "TSFD Example.EXE"
Function .onInit
SetSilent silent
FunctionEnd
Section
tSFD::SelectFileDialog /NOUNLOAD open $EXEDIR "指定文件 TSFD.nsi|TSFD.nsi|NSIS脚本 (*.nsi)|*.nsi|程序文件 (*.exe)|*.exe|所有文件 (*.*)|*.*"
Pop $0
tSFD::SelectFileDialog /NOUNLOAD save $EXEDIR "指定文件 TSFD.nsi|TSFD.nsi|NSIS脚本 (*.nsi)|*.nsi|程序文件 (*.exe)|*.exe|所有文件 (*.*)|*.*"
Pop $1
MessageBox MB_ICONINFORMATION|MB_OK 'Open Result:$0$\r$\nSave Result:$1$\r$\n$\r$\nTSFD Example by Ansifa$\r$\n2008.12.12'
SectionEnd
