Name "TimeTest"
OutFile "TimeTest.exe"

!include "Time.nsh"
!include "Sections.nsh"

Var RADIOBUTTON

Page components
Page instfiles


Section "Mathematical operations test" MathTime
	#Compare times:
	${time::MathTime} "second(29.12.2005 0:0:0) - second(30.12.2005 0:0:0) =" $0
	IntCmp $0 0 0 +2 +3
	MessageBox MB_OK 'Time are equal' IDOK dayofweek
	MessageBox MB_OK 'Second time is later than first time' IDOK dayofweek
	MessageBox MB_OK 'First time is later than second time' IDOK dayofweek

	dayofweek:
	#Calculate day of the week:
	${time::MathTime} "day(29.12.2005 0:0:0) + 5 % 7 =" $0
	MessageBox MB_OK 'day of the week$\n$$0={$0}'

	#Calculate date after 60 days:
	${time::MathTime} "date(29.12.2005 0:0:0) + date(60.0.0 0:0:0) = date" $0
	MessageBox MB_OK 'date after 60 days$\n$$0={$0}'

	#Calculate how many days between dates:
	${time::MathTime} "second(29.12.2005 0:0:0) - second(15.09.1996 0:0:0) = day" $0
	MessageBox MB_OK 'how many days between dates$\n$$0={$0}'

	#Calculate how many days in 1234567890 seconds:
	${time::MathTime} "second(1.1.0 0:0:0) + 1234567890 = day" $0
	MessageBox MB_OK 'how many days in 1234567890 seconds$\n$$0={$0}'

	#Is this date a valid date:
	StrCpy $0 "31.02.2005 0:0:0"
	${time::MathTime} "date($0) = date" $1
	StrCmp $0 $1 0 +2
	MessageBox MB_OK '$0 is valid date' IDOK unload
	MessageBox MB_OK '$0 is invalid date$\n(valid is $1)' IDOK unload

	unload:
	${time::Unload}
SectionEnd

Section /o "Local time test" LocalTime
	${time::GetLocalTime} $0
	MessageBox MB_OK 'time::GetLocalTime$\n$$0={$0}'

	${time::SetLocalTime} "05.05.1995 05:55:55" $R0
	MessageBox MB_OK 'time::SetLocalTime$\n$$R0={$R0}$\n$\nLocal time has changed. Click OK to change it back'

	${time::SetLocalTime} "$0" $R0
	MessageBox MB_OK 'time::SetLocalTime$\n$$R0={$R0}'

	${time::Unload}
SectionEnd

Section /o "File time test" FileTime
	${time::GetFileTime} "$WINDIR\system.ini" $0 $1 $2
	MessageBox MB_OK 'time::GetFileTime$\n$$0={$0}$\n$$1={$1}$\n$$2={$2}'

	${time::SetFileTime} "$WINDIR\system.ini" "01.01.2000 20:30:40" "01.01.2001 21:31:41" "01.01.2002 22:32:42" $R0
	MessageBox MB_OK 'time::SetFileTime$\n$$R0={$R0}'

	${time::GetFileTime} "$WINDIR\system.ini" $3 $4 $5
	MessageBox MB_OK 'time::GetFileTime$\n$$3={$3}$\n$$4={$4}$\n$$5={$5}$\n$\nFile time has changed. Click OK to change it back'

	${time::SetFileTime} "$WINDIR\system.ini" "$0" "$1" "$2" $R0
	MessageBox MB_OK 'time::SetFileTime$\n$$R0={$R0}'

	${time::GetFileTime} "$WINDIR\system.ini" $0 $1 $2
	MessageBox MB_OK 'time::GetFileTime$\n$$0={$0}$\n$$1={$1}$\n$$2={$2}'

	${time::Unload}
SectionEnd

Section /o "Time string test" TimeString
	${time::GetLocalTime} $R0

	${time::TimeString} "$R0" $0 $1 $2 $3 $4 $5
	MessageBox MB_OK 'time::TimeString$\n$0/$1/$2 $3-$4-$5'

	${time::Unload}
SectionEnd


Function .onInit
	StrCpy $RADIOBUTTON ${MathTime}
FunctionEnd

Function .onSelChange
	!insertmacro StartRadioButtons $RADIOBUTTON
	!insertmacro RadioButton ${MathTime}
	!insertmacro RadioButton ${LocalTime}
	!insertmacro RadioButton ${FileTime}
	!insertmacro RadioButton ${TimeString}
	!insertmacro EndRadioButtons
FunctionEnd
