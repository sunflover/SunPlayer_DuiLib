Name "DumpLogTest"
OutFile "DumpLogTest.exe"

Section
	StrCpy $0 0

	loop:
	DetailPrint "$0"
	IntOp $0 $0 + 1
	StrCmp $0 100 0 loop

	DumpLog::DumpLog "log.txt" .R0

	MessageBox MB_OK "DumpLog::DumpLog$\n$\n\
			Errorlevel: [$R0]"
SectionEnd