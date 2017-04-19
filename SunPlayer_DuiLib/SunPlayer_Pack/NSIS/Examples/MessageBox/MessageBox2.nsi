SetCompressor /SOLID lzma
SetCompress force
XPStyle on

OutFile "Test.EXE"
Name "Test"
Section "Test"
messagebox::show MB_ICONINFORMATION "messagebox::show" "" "插件 messagebox" "我知道啦"
SectionEnd
