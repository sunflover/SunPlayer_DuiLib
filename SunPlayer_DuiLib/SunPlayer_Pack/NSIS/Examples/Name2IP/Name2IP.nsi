Name "name2ipTest"
OutFile "name2ipTest.exe"

!include "name2ip.nsh"
!include "Sections.nsh"

Var RADIOBUTTON

Page components
Page instfiles


Section "Local machine IPs" Local
	${name2ip::FindFirstIP} "" $0

	loop:
	StrCmp $0 '' close
	MessageBox MB_OKCANCEL '$$0={$0}$\nFind next?' IDCANCEL close
	${name2ip::FindNextIP} $0
	goto loop

	close:
	${name2ip::FindCloseIP}
SectionEnd


Section /o "Remote machine IP" Remote
	${name2ip::FindFirstIP} "is74.ru" $0
	${name2ip::FindCloseIP}

	MessageBox MB_OK '$$0={$0}'
SectionEnd


Function .onInit
	StrCpy $RADIOBUTTON ${Local}
FunctionEnd

Function .onSelChange
	!insertmacro StartRadioButtons $RADIOBUTTON
	!insertmacro RadioButton ${Local}
	!insertmacro RadioButton ${Remote}
	!insertmacro EndRadioButtons
FunctionEnd
