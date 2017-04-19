Name "Output"
OutFile "Output.exe"

!include "FileFunc.nsh"
!insertmacro Locate

Section
	nxs::Show /NOUNLOAD `$(^Name) Setup` /top `Setup searching something$\nPlease wait$\nIf you can...` /h 1 /can 1 /end
        Sleep 200
	${Locate} "C:\WINDOWS" "/L=F /M=*.* /B=1" "LocateCallback"
	nxs::Destroy
SectionEnd

Function LocateCallback
	StrCmp $R0 $R8 abortcheck
	StrCpy $R0 $R8
	nxs::Update /NOUNLOAD /sub "$R8" /pos 78 /end

	abortcheck:
	nxs::HasUserAborted /NOUNLOAD
	Pop $0
	StrCmp $0 1 0 +2
	StrCpy $0 StopLocate

	StrCmp $R9 '' end
	;...

	end:
	Push $0
FunctionEnd