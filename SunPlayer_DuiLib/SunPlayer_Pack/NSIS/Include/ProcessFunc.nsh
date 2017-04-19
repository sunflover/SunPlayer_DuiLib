/*
_____________________________________________________________________________

                       Process Functions Header v1.0
_____________________________________________________________________________

 Copyright (C) 2010 - 2011 by gfm688

*/

!ifndef PROCESSFUNC_INCLUDED
!define PROCESSFUNC_INCLUDED
!verbose push
!verbose 3

!include "LogicLib.nsh"
!include "Util.nsh"

!ifdef NSIS_UNICODE
	!define PROCESSENTRY32 "(i556,i,i,i,i,i,i,i,i,&t260)i"
	!define MODULEENTRY32 "(i1064,i,i,i,i,*i,i,i,&t256,&t260)i"
	!define Process32First "Kernel32::Process32FirstW(i,i)i"
	!define Process32Next "Kernel32::Process32NextW(i,i)i"
	!define Module32First "Kernel32::Module32FirstW(i,i)i"
	!define Module32Next "Kernel32::Module32NextW(i,i)i"
!else
	!define PROCESSENTRY32 "(i296,i,i,i,i,i,i,i,i,&t260)i"
	!define MODULEENTRY32 "(i548,i,i,i,i,*i,i,i,&t256,&t260)i"
	!define Process32First "Kernel32::Process32First(i,i)i"
	!define Process32Next "Kernel32::Process32Next(i,i)i"
	!define Module32First "Kernel32::Module32First(i,i)i"
	!define Module32Next "Kernel32::Module32Next(i,i)i"
!endif

#define PROCESS_ALL_ACCESS		0x001F0FFF

!define KillProcess `!insertmacro KillProcess`

!macro KillProcess _PID
	#define PROCESS_TERMINATE         (0x0001)
	System::Call Kernel32::OpenProcess(i0x0001,i,i${_PID})i.s
	System::Call Kernel32::TerminateProcess(iss,i0)
	System::Call Kernel32::CloseHandle(is)
!macroend

!macro FindProcessCall _PNAME _RESULT
	Push ${_PNAME}
	${CallArtificialFunction} FindProcess_
	Pop ${_RESULT}
!macroend

!define FindProcess `!insertmacro FindProcessCall`

!macro FindProcess_
	Exch $0
	Push $1
	Push $2
	Push $3
	#define TH32CS_SNAPPROCESS 0x00000002
	System::Call Kernel32::CreateToolhelp32Snapshot(i0x2,i0)i.r1
	${If} $1 = -1
	${OrIf} $1 == "error"
	    StrCpy $0 $1
	${Else}
		System::Call "*${PROCESSENTRY32}.r2"
		System::Call "${Process32First}(r1,r2).r3"
		${Unless} $3 = 0
			${Do}
				System::Call "${Process32Next}(r1,r2).r3"
				${IfThen} $3 = 0 ${|} ${ExitDo} ${|}
				System::Call "*$2${PROCESSENTRY32}(,,,,,,,,,.r3)"
				${If} $3 == $0
					System::Call "*$2${PROCESSENTRY32}(,,.r3,_)"
					${ExitDo}
				${EndIf}
			${Loop}
		${EndUnless}
	    System::Call Kernel32::CloseHandle(ir1)
		System::Free $2
		StrCpy $0 $3
	${EndIf}
	Pop $3
	Pop $2
	Pop $1
	Exch $0
!macroend


!macro EnumProcessCall _FUNC
	Push $0
	GetFunctionAddress $0 ${_FUNC}
	${CallArtificialFunction} EnumProcess_
!macroend

!define EnumProcess `!insertmacro EnumProcessCall`

!macro EnumProcess_
	Push $1
	Push $2
	Push $3
	Push $4
	System::Call Kernel32::CreateToolhelp32Snapshot(i0x2,i0)i.r1
	${Unless} $1 = -1
	${AndUnless} $1 == "error"
		System::Call "*${PROCESSENTRY32}.r2"
		System::Call "${Process32First}(r1,r2).r3"
		${Do}
			${IfThen} $3 = 0 ${|} ${ExitDo} ${|}
			System::Call "*$2${PROCESSENTRY32}(,,.r3,,,,,,,.r4)"
			Call $0
			${IfThen} $0 == "Stop" ${|} ${ExitDo} ${|}
			System::Call "${Process32Next}(r1,r2).r3"
		${Loop}
	    System::Call Kernel32::CloseHandle(ir1)
		System::Free $2
	${EndUnless}
	Pop $4
	Pop $3
	Pop $2
	Pop $1
	Pop $0
!macroend


!macro EnumProcessModuleCall _PID _FUNC
	Push $0
	Push ${_PID}
	GetFunctionAddress $0 ${_FUNC}
	${CallArtificialFunction} EnumProcessModule_
!macroend

!define EnumProcessModule `!insertmacro EnumProcessModuleCall`

!macro EnumProcessModule_
	Exch $1
	Push $2
	Push $3
	#define TH32CS_SNAPMODULE 0x00000008
	System::Call Kernel32::CreateToolhelp32Snapshot(i0x8,ir1)i.r1
	${Unless} $1 = -1
	${AndUnless} $1 == "error"
		System::Call "*${MODULEENTRY32}.r2"
		System::Call "${Module32First}(r1,r2).r3"
		${Do}
			${IfThen} $3 = 0 ${|} ${ExitDo} ${|}
			System::Call "*$2${MODULEENTRY32}(,,,,,,,,,.r3)"
			Call $0
			${IfThen} $0 == "Stop" ${|} ${ExitDo} ${|}
			System::Call "${Module32Next}(r1,r2).r3"
		${Loop}
	    System::Call Kernel32::CloseHandle(ir1)
		System::Free $2
	${EndUnless}
	Pop $3
	Pop $2
	Pop $1
	Pop $0
!macroend


!macro GetProcessCmdLineCall _PID _RESULT
	Push ${_PID}
	${CallArtificialFunction} GetProcessCmdLine_
	Pop ${_RESULT}
!macroend

!define GetProcessCmdLine `!insertmacro GetProcessCmdLineCall`

!macro GetProcessCmdLine_
	Exch $0
	Push $1
	Push $2
	#define PROCESS_VM_READ (0x0010)
	System::Call Kernel32::OpenProcess(i0x0010,i0,ir0)i.r1
	${If} $1 = 0
	${OrIf} $1 == "error"
	    StrCpy $0 $1
	${Else}
		System::Call Kernel32::GetModuleHandle(t'Kernel32.dll')i.s
 	!ifdef NSIS_UNICODE
		System::Call Kernel32::GetProcAddress(is,m'GetCommandLineW')i.r0
	!else
		System::Call Kernel32::GetProcAddress(is,t'GetCommandLineA')i.r0
	!endif
		IntOp $0 $0 + 1
		System::Call "*$0(i.r0)"
		System::Call Kernel32::ReadProcessMemory(ir1,ir0,*i.r0,i4,*i)
		System::Call Kernel32::GetVersion()i.r2
		${If} $2 U< 0x80000000   ; Windows NT/2000/XP
		    System::Call Kernel32::ReadProcessMemory(ir1,ir0,t.r0,i1024,*i)
		${Else}                  ; Windows 95/98/Me and Win32s
			System::Call Kernel32::ReadProcessMemory(ir1,ir0,*i.r0,i4,*i)
			IntOp $0 $0 + 0xC0
			System::Call Kernel32::ReadProcessMemory(ir1,ir0,t.r0,i1024,*i)i.r2
			${If} $0 == ""
			${AndIf} $2 <> 0
				IntOp $0 $0 + 0x40
				System::Call Kernel32::ReadProcessMemory(ir1,ir0,*i.r0,i4,*i)
				IntOp $0 $0 + 0x8
				System::Call Kernel32::ReadProcessMemory(ir1,ir0,*i.r0,i4,*i)
				System::Call Kernel32::ReadProcessMemory(ir1,ir0,t.r0,i1024,*i)
			${EndIf}
		${EndIf}
		System::Call Kernel32::CloseHandle(ir1)
	${EndIf}
	Pop $2
	Pop $1
	Exch $0
!macroend


!macro EnablePrivilegeCall SE_NAME
	Push `${SE_NAME}`
	${CallArtificialFunction} EnablePrivilege_
!macroend

!macro EnablePrivilege_
	Exch $0
	Push $1
	Push $2
	#define TOKEN_QUERY             (0x0008)
	#define TOKEN_ADJUST_PRIVILEGES (0x0020)
	System::Call Kernel32::GetCurrentProcess()i.s
	System::Call Advapi32::OpenProcessToken(is,i0x28,*i.r2)i.r1
	${If} $1 = 0
	${OrIf} $1 == "error"
		SetErrors
	${Else}
	    StrCpy $0 "Se$0Privilege"
	    System::Call Advapi32::LookupPrivilegeValue(i,tr0,*l.r0)i.r1
	    ${If} $1 = 0
	        SetErrors
		${Else}
		    #define SE_PRIVILEGE_ENABLED            (0x00000002L)
		    System::Call "*(i1,lr0,i0x2)i.r1"
		    System::Call Advapi32::AdjustTokenPrivileges(ir2,i0,ir1,i0,i,i0)i.r0
		    ${IfThen} $0 = 0 ${|} SetErrors ${|}
		    System::Free $1
	    ${EndIf}
	    System::Call Kernel32::CloseHandle(ir2)
	${EndIf}
	Pop $2
	Pop $1
	Pop $0
!macroend

!define EnablePrivilege `!insertmacro EnablePrivilegeCall`
;System::Call ntdll::RtlAdjustPrivilege(i20,i1,i0,*i)
!define EnableDebugPriv `${EnablePrivilege} Debug`
;System::Call ntdll::RtlAdjustPrivilege(i19,i1,i0,*i)
!define EnableShutdownPriv `${EnablePrivilege} Shutdown`
#define more...

!verbose pop
!endif
