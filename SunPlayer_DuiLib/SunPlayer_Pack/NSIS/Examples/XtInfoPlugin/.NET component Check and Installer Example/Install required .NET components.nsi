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


; ==================================================================================
; Download xtInfoPlugin from
; http://www.razormotion.com/nsis/xtInfoPlugin.zip
; best to copy xtInfoPlugin.dll to NSIS\Plugins and remove below code
!addplugindir ".\" ; detect xtInfoPlugin.dll in current directory
!addplugindir "..\" ; detect xtInfoPlugin.dll in current directory
!addplugindir "..\.." ; detect xtInfoPlugin.dll in parent/parent directory
Name "Required .NET Components"
OutFile "SimpleNETApp_Component_Check_and_Setup.exe"
SetCompress off ; Useful to disable compression under development

; ===========================================================================
; Components Settings
; ===========================================================================
!define MUI_COMPONENTSPAGE_SMALLDESC
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\box-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\box-uninstall.ico"


!include "${NSISDIR}\Include\MUI.nsh"
!include "${NSISDIR}\Include\LogicLib.nsh"


; ===========================================================================
; Reserve files
; ===========================================================================
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS ; InstallOptions plug-in
!insertmacro MUI_RESERVEFILE_LANGDLL ; Language selection dialog


; ===========================================================================
; Pages
; ===========================================================================
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
;!insertmacro MUI_UNPAGE_CONFIRM - we do not install anything except system components
;!insertmacro MUI_UNPAGE_INSTFILES - we do not install anything except system components


; ===========================================================================
; Languages
; ===========================================================================
!insertmacro MUI_LANGUAGE "English"


; ===========================================================================
; Execute and Wait for process to return
; ===========================================================================
!macro EXECWAIT filename command
	xtInfoPlugin::GetInstallerFullPath
	Pop $0
	StrCpy $0 '"$0\${filename}" ${command}'
	StrCpy $0 "We should call ExecWait with this (See Code to uncomment ExecWait)$\r$\n$\r$\n -> $0"
	; MessageBox MB_OK $0
	; ExecWait '"$0\${filename}" ${command}'
!macroend


; ===========================================================================
; Execute without waiting for process to return
; ===========================================================================
!macro EXECNOWAIT filename command
	xtInfoPlugin::GetInstallerFullPath
	Pop $0
	Exec '"$0\${filename}" ${command}'
!macroend


; ===========================================================================
; Set Section Size in MB instead of KB
; ===========================================================================
!macro SECMB sec mb
	IntOp $0 ${mb} * 1024
	SectionSetSize ${sec} $0
!macroend


; ===========================================================================
; Disable a specific Section because we need to install it
; ===========================================================================
!macro SECOFF sec
	SectionSetText ${sec} ""
	SectionSetFlags ${sec} 0
!macroend


; ===========================================================================
; IE Section
; ===========================================================================
Section "Internet Explorer 6.0 SP1" Sec01
	SectionIn RO
	!insertmacro EXECWAIT "Redist\ie6setup.exe" "/q"
SectionEnd


; ===========================================================================
; .NET Section
; ===========================================================================
Section ".NET Framework 1.1" Sec02
	SectionIn RO
	!insertmacro EXECWAIT "Redist\dotnetfx.exe" "/q"
SectionEnd


; ===========================================================================
; MDAC Section
; ===========================================================================
Section "MDAC 2.8" Sec03
	SectionIn RO
	!insertmacro EXECWAIT "Redist\mdacsetup.exe" "/q"
SectionEnd


; ===========================================================================
; Descriptions for the sections
; ===========================================================================
LangString DESC_Sec01 ${LANG_ENGLISH} "Internet Explorer 5.01 or newer required to run this application."
LangString DESC_Sec02 ${LANG_ENGLISH} ".NET Framework 1.1 or newer required to run this application."
LangString DESC_Sec03 ${LANG_ENGLISH} "MDAC 2.5 or newer required to run this application."
LangString DESC_WindowsError ${LANG_ENGLISH} "This Application uses components that requires Windows 98 or newer."
;LangString DESC_Section2 ${LANG_ENGLISH} "Description of section 2."
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${Sec01} $(DESC_Sec01)
	!insertmacro MUI_DESCRIPTION_TEXT ${Sec02} $(DESC_Sec02)
	!insertmacro MUI_DESCRIPTION_TEXT ${Sec03} $(DESC_Sec03)
!insertmacro MUI_FUNCTION_DESCRIPTION_END


; ===========================================================================
; Check for Components required by our application
; ===========================================================================
Function CheckForComponents

	; First off, let's explain to the user that .NET requires Windows 98 or newer
	; Actually .NET works with Windows NT4 with SP6a too - but frankly who cares about NT these modern days, heh! ;)
	; So, let's exclude all users of Windows 95, Windows NT3 and Windows NT4, like this:
	xtInfoPlugin::GetWindowsId
	Pop $0
	${if} $0 == "95"
		StrCpy $0 ""
	${elseif} $0 == "nt3"
		StrCpy $0 ""
	${elseif} $0 == "nt4"
		StrCpy $0 ""
	${endif}
	${if} $0 == ""
		MessageBox MB_ICONEXCLAMATION "$(DESC_WindowsError)"
		Quit
	${endif}

	; -----------------------------------------------------------------------

	; Internet Explorer 5.01 or Newer required for .NET to install and work
	StrCpy $2 "5.01"
	Push $2
	xtInfoPlugin::GetInternetExplorerVersion
	Pop $1
	Push $1
	xtInfoPlugin::CompareVersion
	Pop $0
	${if} $0 >= 0
		; Newer or Equal, skip component installation
		!insertmacro SECOFF ${Sec01}
	${endif}

	; -----------------------------------------------------------------------

	; .NET 1.1 Required
	xtInfoPlugin::IsDotNetFrameworkInstalled
	Pop $0
	${if} $0 == true
		xtInfoPlugin::GetDotNetFrameworkId
		Pop $0
		${if} $0 == "1.1"
			; Newer or Equal, skip component installation
			!insertmacro SECOFF ${Sec02}
		${endif}
	${endif}

	; -----------------------------------------------------------------------

	; MDAC 2.5 or Newer required for application to have prober ADO support
	StrCpy $2 "2.5"
	Push $2
	xtInfoPlugin::GetMDACVersion
	Pop $1
	Push $1
	xtInfoPlugin::CompareVersion
	Pop $0
	${if} $0 >= 0
		; Newer or Equal, skip component installation
		!insertmacro SECOFF ${Sec03}
	${endif}

	; Let's check if the Text of the components have been cleared (that means no component installation)
	SectionGetText ${Sec01} $1
	SectionGetText ${Sec02} $2
	SectionGetText ${Sec03} $3
	StrCpy $0 "$1$2$3"
	${if} $0 == ""
	    ; 'sum' of Component Text are empty, that means no components to install
		MessageBox MB_ICONINFORMATION "All components required to run our .NET application are present.$\r$\nLet's just run our Application now and skip the installer!"
		!insertmacro EXECNOWAIT "SimpleNETApp.exe" "no commandline this time"
		Quit
	${endif}

FunctionEnd

; ===========================================================================
; On Initialization of Installer
; ===========================================================================
Function .onInit

	; Check if we have the required components to skip the installer
	Call CheckForComponents

	; Preset component size in megabytes
	!insertmacro SECMB ${Sec01} 64
	!insertmacro SECMB ${Sec02} 64
	!insertmacro SECMB ${Sec03} 12

FunctionEnd


