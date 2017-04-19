SetCompressor /SOLID lzma
SetCompressorDictSize 32
XPStyle on
SilentInstall silent
Icon "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"

!include "LogicLib.nsh"
!AddPluginDir .

Caption "GetHardDisk"
OutFile "GetHardDisk.exe"

Section
	StrCpy $0 0
${Do}
	HddInfo::GetModelNumber $0
	Pop $1
	${IfThen} $1 == "" ${|} ${ExitDo} ${|}
	HddInfo::GetSerialNumber $0
	Pop $2
	HddInfo::GetBufferSize $0
	Pop $3
	HddInfo::GetDiskSize $0
	Pop $4
	Call GetDiskPos
	MessageBox MB_ICONINFORMATION|MB_OK "硬盘(hd$0)的型号是: $1 $\r$\n\
										 序列号: $2 $\r$\n\
										 缓存大小: $3 $\r$\n\
	                                     硬盘大小: $4 $\r$\n\
										 位置: $R0"
	IntOp $0 $0 + 1
${Loop}
SectionEnd

Function GetDiskPos
	Intop $R0 $0 / 2
	${Select} $R0
	${Case} "0"
		StrCpy $R1 "Primary"
	${Case} "1"
	    StrCpy $R1 "Secondary"
	${Case} "2"
	    StrCpy $R1 "Tertiary"
	${Case} "3"
	    StrCpy $R1 "Quaternary"
	${EndSelect}
	
	Intop $R0 $0 % 2
	${Select} $R0
	${Case} "0"
		StrCpy $R0 "Master"
	${Case} "1"
	    StrCpy $R0 "Slave"
 	${EndSelect}
 	StrCpy $R0 "$R1 $R0"
FunctionEnd

