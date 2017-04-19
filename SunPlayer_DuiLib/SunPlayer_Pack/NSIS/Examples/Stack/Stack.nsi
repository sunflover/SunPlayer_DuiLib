Name "StackTest"
OutFile "StackTest.exe"

!include "Stack.nsh"
!include "Sections.nsh"

Var RADIOBUTTON

Page components
Page instfiles


Section "Basic stack functions" Basic
	### NSIS stack operations test ###

	${stack::ns_push_front} "1a"      ;// 1a
	${stack::ns_push_front} "2a"      ;// 1a 2a
	${stack::ns_push_back} "3a"       ;// 3a 1a 2a
	${stack::ns_push_front} "4a"      ;// 3a 1a 2a 4a

	${stack::ns_pop_front} $R1 $R0    ;// 3a 1a 2a   (4a)
	${stack::ns_read} "3" $R1 $R0     ;// (3a) 1a 2a
	${stack::ns_write} "2b" "2" $R0   ;// 3a (2b) 2a
	${stack::ns_size} $R0         ;// 3
	${stack::Debug} "0"

	${stack::ns_pop_front} $6 $R0     ;// 3a 2b   (2a)
	${stack::ns_pop_front} $7 $R0     ;// 3a      (2b)
	${stack::ns_pop_front} $8 $R0     ;//         (3a)
	${stack::ns_pop_front} $9 $R0     ;//         ()

	### Private stack operations test ###

	${stack::dll_create} $0

	${stack::dll_insert} "$0" "1a" "-1" $R0     ;// 1a
	${stack::dll_insert} "$0" "2a" "-1" $R0     ;// 2a 1a
	${stack::dll_insert} "$0" "3a" "1" $R0      ;// 2a 1a 3a
	${stack::dll_insert} "$0" "4a" "-1" $R0     ;// 4a 2a 1a 3a
	${stack::dll_insert} "$0" "5a" "1" $R0      ;// 4a 2a 1a 3a 5a

	${stack::dll_read} "$0" "2" $R1 $R0             ;// 4a 2a 1a (3a) 5a
	${stack::dll_read} "$0" "-2" $R1 $R0            ;// 4a (2a) 1a 3a 5a
	${stack::dll_delete} "$0" "2" $R1 $R0           ;// 4a 2a 1a 5a      (3a)
	${stack::dll_insert} "$0" "1b" "3" $R0          ;// 4a 2a 1b 1a 5a
	${stack::dll_write} "$0" "2b" "-1" $R0          ;// (2b) 2a 1b 1a 5a
	${stack::dll_exchange} "$0" "-2" "1" $R0        ;// 2b 5a 1b 1a 2a
	${stack::dll_reverse_range} "$0" "-1" "1" $R0   ;// 2a 1a 1b 5a 2b
	${stack::dll_move} "$0" "4" "2" $R0             ;// 2a 1b 5a 1a 2b
	${stack::dll_move_range} "$0" "-1" "2" "1" $R0  ;// 2b 2a 1b 5a 1a
	${stack::dll_push_sort} "$0" "3a" "1"           ;// 2b 2a 1b 5a 3a 1a
	${stack::dll_delete_range} "$0" "-1" "-3" $R0   ;// 5a 3a 1a         (2b 2a 1b)
	${stack::dll_sort_all} "$0" "-1"                ;// 1a 3a 5a
	${stack::dll_size} "$0" $R0                 ;// 3
	${stack::Debug} "$0"

	${stack::dll_delete} "$0" "1" $R1 $R0       ;// 1a 3a    (5a)
	${stack::dll_delete} "$0" "-1" $R1 $R0      ;// 3a       (1a)
	${stack::dll_delete} "$0" "1" $R1 $R0       ;//          (3a)
	${stack::dll_delete} "$0" "1" $R1 $R0       ;//          ()

	${stack::dll_destroy} "$0"
	${stack::Unload}
SectionEnd


Section /o "Sort integers" SortInt
	${stack::dll_create} $0

	${stack::dll_insert} "$0" "2" "-1" $R0
	${stack::dll_insert} "$0" "1" "-1" $R0
	${stack::dll_insert} "$0" "111" "-1" $R0
	${stack::dll_insert} "$0" "222" "-1" $R0
	${stack::dll_insert} "$0" "22" "-1" $R0
	${stack::dll_insert} "$0" "11" "-1" $R0
	${stack::dll_sort_all_int} "$0" "1"

	${stack::Debug} "$0"

	${stack::dll_clear} "$0"
	${stack::dll_push_sort_int} "$0" "2" "-1"
	${stack::dll_push_sort_int} "$0" "1" "-1"
	${stack::dll_push_sort_int} "$0" "111" "-1"
	${stack::dll_push_sort_int} "$0" "222" "-1"
	${stack::dll_push_sort_int} "$0" "22" "-1"
	${stack::dll_push_sort_int} "$0" "11" "-1"

	${stack::Debug} "$0"

	${stack::dll_clear} "$0"
	${stack::dll_destroy} "$0"
	${stack::Unload}
SectionEnd


Section /o "Sort lines in text file" SortLines
	StrCpy $R0 "$WINDIR\SYSTEM.INI"       #Text file with unsorted lines
	StrCpy $R1 "$TEMP\SYSTEM_SORTED.INI"  #Result text file with sorted lines


	#Read lines to stack
	${stack::dll_create} $0
	FileOpen $R2 $R0 r

	read:
	FileRead $R2 $R3
	IfErrors closeread
	${stack::dll_push_sort} "$0" "$R3" "1"
	goto read
	closeread:
	FileClose $R2

	#Write lines to file
	FileOpen $R2 $R1 w

	write:
	${stack::dll_delete} "$0" "1" $R3 $R4
	StrCmp $R4 1 closewrite
	FileWrite $R2 "$R3"
	goto write
	closewrite:
	FileClose $R2

	${stack::dll_destroy} "$0"
	${stack::Unload}

	#Open file
	Exec '"notepad.exe" "$R1"'
SectionEnd


Function .onInit
	StrCpy $RADIOBUTTON ${Basic}
FunctionEnd

Function .onSelChange
	!insertmacro StartRadioButtons $RADIOBUTTON
	!insertmacro RadioButton ${Basic}
	!insertmacro RadioButton ${SortInt}
	!insertmacro RadioButton ${SortLines}
	!insertmacro EndRadioButtons
FunctionEnd
