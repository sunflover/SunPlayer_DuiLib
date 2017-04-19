; xID Example by gfm688

SetCompressor lzma
XPStyle on

OutFile "Test.exe"
Name "xID Example"
ShowInstDetails show

Section
System::Call $PLUGINSDIR\xID.dll::GetHardDiskID(t.r0)
DetailPrint "HardDisk Serial: $0"
System::Call xID::GetNetCardID(t"%02X-%02X-%02X-%02X-%02X-%02X",t.r0)?u
DetailPrint "NetCard MAC: $0"
SectionEnd

Function .onInit
	InitPluginsDir
	File /oname=$PLUGINSDIR\xID.dll xID.dll
FunctionEnd
