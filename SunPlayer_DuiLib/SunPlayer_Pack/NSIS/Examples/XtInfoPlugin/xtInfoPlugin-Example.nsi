; NSIS xtInfoPlugin Example Script by Jari Berg Jensen.
; File is part of NSIS xtInfoPlugin by Jari Berg Jensen.
;
; Copyright 2004 Jari Berg Jensen. All Rights Reserved.
;
; DISCLAIMER
; Please feel free to do anything with the code as long as the copyright message above
; and this disclaimer is present in the file.
; ALL USE OF THIS CODE IS AT YOUR OWN RISK
; ==================================================================================


; ===================================================================================
; Download xtInfoPlugin from http://www.razormotion.com/nsis/xtInfoPlugin.zip
; (including full c++ sourcecode for the plugin and this example script)
; If you have ideas/modify code please contact me or contribute code to community.
; ===================================================================================
; SPECIAL thanks to Hector Mauricio Rodriguez Segura for the AWESOME HM NIS Edit.
; HM NIS Edit makes NSIS development so much fun - Check it out NOW! :)
; ===================================================================================

; For an easy to follow example look in the Examples folder under
; .NET component Check and Installer Example.
; Shows how to detect IE5.01 (required by .NET), MDAC 2.5 and run .NET app afterwards.

; Okay, let me show you what xtInfoPlugin can do for you or atleast I hope.
; xtInfoPlugin will assist you to determine version information for various components.
; All ID's are always lowercase and no spaces - see below and example in .onInit method.
;
; Version Compare function (See code in onInit method or .NET check example)
; Installer Filename (ie. Setup.exe)
; Installer FullPath (ie. D:\SetupFiles)
; Installer FileName (ie. D:\SetupFiles\Setup.exe)
; Windows Language (ie. Danish, English, German, etc.)
; .NET Framework IDs (ie. 1.0, 1.1, 2.0, etc.)
; .NET Framework Version (ie. 1.0.3705, 1.1.4322, etc.)
; Internet Explorer IDs (ie. 4.01, 5.0, 5.01, 6.0, etc.)
; Internet Explorer Versions (ie, 4.71.1712.6, 5.00.2920.0000, 6.00.2600.0000, etc.)
; Windows IDs (ie. 95, 98, me, xp, nt3, nt4, 2003, etc)
; Windows Versions (ie, 5.1.2800, etc.)
; MDAC IDs (ie. 2.5)
; MDAC Versions (ie. 2.50.4403.9)
; OLEDB IDs (ie. 2.5)
; OLEDB Versions (ie. 2.50.4403.8)
; Windows Service Pack IDs (ie, 1, 2a, 6a, etc.)

; ===================================================================================
; Configuration
; ===================================================================================
!addplugindir "..\" ; will detect xtInfoPlugin.dll in parent directory
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\box-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\box-uninstall.ico"
!define NAME "NSIS xtInfoPlugin Example"
Name "${NAME}"
Caption "${NAME}"
OutFile "xtInfoPlugin-Example.exe"
SetCompress off ; Useful to disable compression under development
SetFont "Tahoma" 8
WindowIcon on
XPStyle on

; ===================================================================================
; Include Files
; ===================================================================================
!include "${NSISDIR}\Include\MUI.nsh"
!include "${NSISDIR}\Include\LogicLib.nsh"

!insertmacro MUI_RESERVEFILE_LANGDLL ; Language selection dialog
!insertmacro MUI_LANGUAGE "English"

Var result

; ===================================================================================
; GETINFO Macro
; ===================================================================================
!macro GETINFO function
	xtInfoPlugin::${function} ; Call the passed function - Gee, I love macros ;)
	Pop $0 ; Pop the stack - any register will do (ie. Pop $R5)
	StrCpy $result "$result$\r$\n ${function}: $0" ; Save result for later
!macroend

; ===================================================================================
; ISINFO Macro
; ===================================================================================
!macro ISINFO function
	xtInfoPlugin::${function} ; Call the passed function - Gee, I love macros ;)
	Pop $0 ; Pop the stack - any register will do (ie. Pop $R5)
	/*
	; not necessary, but you can check against true/false in your code for better control
	${if} $0 == true
	    StrCpy $0 "true"
	${else}
	    StrCpy $0 "false"
	${endif}
	*/
	StrCpy $result "$result$\r$\n ${function} = $0" ; Save result for later
!macroend

; ===================================================================================
; On Initialization
; ===================================================================================
Function .onInit

	; CompareVersion example
	; ie. (in C++) CompareVersion("2.50.4403.9", "2.50.4403.9") would return 0  (a == b)
	; ie. (in C++) CompareVersion("2.50.4403.9", "2.71.9030.0") would return 1  (b > a)
	; ie. (in C++) CompareVersion("2.71.9030.0", "2.50.4403.9") would return -1 (a > b)

	StrCpy $2 "2.5"
	Push $2
	xtInfoPlugin::GetMDACVersion
	Pop $1
	Push $1
	xtInfoPlugin::CompareVersion
	Pop $0
	${if} $0 >= 0
		MessageBox MB_OK "xtInfoPlugin::CompareVersion - MDAC detection example (See Script)$\r$\n$\r$\nYour MDAC version is Newer or Equal to $2 (detected version: $1)"
	${else}
		MessageBox MB_OK "xtInfoPlugin::CompareVersion - MDAC detection example (See Script)$\r$\n$\r$\nYour MDAC version is OLDER than $2 (detected version: $1)"
	${endif}

	StrCpy $result ""
	StrCpy $result "$result Methods like GetWindowsId always return consistent lowercase strings (ie. nt4,6a,me,xp,2000,sp2,4.0,5.01,6.0,1.1)$\r$\n"

	!insertmacro GETINFO GetInstaller
	!insertmacro GETINFO GetInstallerFullPath
	!insertmacro GETINFO GetInstallerFileName
	!insertmacro GETINFO GetLanguage
	!insertmacro GETINFO GetWindowsVersion
	!insertmacro GETINFO GetWindowsId
	!insertmacro GETINFO GetWindowsServicePackId
	!insertmacro GETINFO GetInternetExplorerVersion
	!insertmacro GETINFO GetInternetExplorerId
	!insertmacro GETINFO GetDotNetFrameworkVersion
	!insertmacro GETINFO GetDotNetFrameworkId
	!insertmacro GETINFO GetMDACVersion
	!insertmacro GETINFO GetMDACId
	!insertmacro GETINFO GetOLEDBVersion
	!insertmacro GETINFO GetOLEDBId
	!insertmacro ISINFO IsDotNetFrameworkInstalled
	!insertmacro ISINFO IsWindowsXP
	!insertmacro ISINFO IsWindows2000
	!insertmacro ISINFO IsWindowsME
	!insertmacro ISINFO IsWindows98
	;!insertmacro ISINFO IsWindows95
	;!insertmacro ISINFO IsWindowsNT3 ; Commented out to save space in MessageBox result window
	;!insertmacro ISINFO IsWindowsNT4
	;!insertmacro ISINFO IsWindows2003

	; Say we wan't our application to only work when .NET Framework v1.1 is installed, here is how you do it
	xtInfoPlugin::IsDotNetFrameworkInstalled
	Pop $0
	${if} $0 == true
		xtInfoPlugin::GetDotNetFrameworkId
		Pop $0
		${if} $0 == "1.1"
			StrCpy $0 "Version 1.1 Installed"
		${else}
			StrCpy $0 "Version 1.0 Installed"
		${endif}
	${else}
		StrCpy $0 "Not installed"
	${endif}
	xtInfoPlugin::GetDotNetFrameworkVersion
	Pop $1
	StrCpy $result "$result$\r$\n$\r$\nAn example of a .NET Framework version check (See Script) = $0 ($1)"

	MessageBox MB_OK $result ; Show saved result in a system MessageBox
	
	Quit ; Quit before installer start
FunctionEnd

; ===================================================================================
; Required by NSIS, we don't need it!
; ===================================================================================
Section
SectionEnd



