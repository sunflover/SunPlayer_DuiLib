; Copyright (C) 2001 Robert Rainwater

Name "NSIS OS Extension Example"
OutFile "example.exe"

InstallDir $TEMP\nsisos

ShowInstDetails show
AutoCloseWindow false


Section -
	File /oname=$TEMP\nsisos.dll nsisos.dll
	CallInstDLL $TEMP\nsisos.dll osversion
	StrCpy $R0 $0
	StrCpy $R1 $1
	CallInstDLL $TEMP\nsisos.dll osplatform
	StrCpy $R2 $0
	MessageBox MB_OK "Major Version: $R0 $\nMinor Version: $R1 $\nPlatform: $R2"
	Delete $TEMP\nsisos.dll
SectionEnd
