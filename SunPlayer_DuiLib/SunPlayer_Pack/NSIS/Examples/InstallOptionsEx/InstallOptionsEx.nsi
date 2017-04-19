; example_MUI.nsi

;--------------------------------
;General

	!define VERSION "2.4.5b2"
	!define /date NOW "%Y-%m-%d"
	!define NAME "NSIS InstallOptionsEx plugin"

;--------------------------------
;Configuration

	; The name of the installer
	Name "${NAME} version ${VERSION}"

	; The file to write
	OutFile "InstallOptionsEx${VERSION}_${NOW}.exe"
	
	SetCompressor /FINAL /SOLID lzma
	
	;Windows vista compatibility
	RequestExecutionLevel admin

	BrandingText "${NAME} version ${VERSION}"

	;Default installation folder
	InstallDir $PROGRAMFILES\NSIS

;--------------------------------
;Include UltraModernUI between others

	!include "MUIEx.nsh"

	!include "Sections.nsh"

;--------------------------------
;Interface Settings

	!define UMUI_USE_INSTALLOPTIONSEX

	!define MUI_ABORTWARNING
	!define MUI_UNABORTWARNING

	!define UMUI_USE_ALTERNATE_PAGE
	!define UMUI_USE_UNALTERNATE_PAGE

	!define MUI_COMPONENTSPAGE_NODESC
	!define MUI_LICENSEPAGE_RADIOBUTTONS
	
	!define MUI_HEADERIMAGE

;--------------------------------
;Registry Settings

	!define UMUI_PARAMS_REGISTRY_ROOT HKLM
	!define UMUI_PARAMS_REGISTRY_KEY "Software\NSIS"
	
	InstallDirRegKey ${UMUI_PARAMS_REGISTRY_ROOT} "${UMUI_PARAMS_REGISTRY_KEY}" ""

;--------------------------------
;Reserve Files

	!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

;--------------------------------
;Pages

	Var STARTMENU_FOLDER
	
	!insertmacro UMUI_PAGE_MULTILANGUAGE
		!define UMUI_WELCOMEPAGE_ALTERNATIVETEXT
	!insertmacro MUI_PAGE_WELCOME
	!insertmacro MUI_PAGE_LICENSE "..\..\Docs\InstallOptionsEx\License.txt"
	!insertmacro MUI_PAGE_COMPONENTS
		!define UMUI_ALTERNATIVESTARTMENUPAGE_SETSHELLVARCONTEXT
		!define UMUI_ALTERNATIVESTARTMENUPAGE_USE_TREEVIEW
		!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
		!define MUI_STARTMENUPAGE_DEFAULTFOLDER "NSIS\Contrib"
	!insertmacro UMUI_PAGE_ALTERNATIVESTARTMENU Application $STARTMENU_FOLDER
	!insertmacro MUI_PAGE_DIRECTORY
		!define UMUI_CONFIRMPAGE_TEXTBOX confirm_function
	!insertmacro UMUI_PAGE_CONFIRM
	!insertmacro MUI_PAGE_INSTFILES
		!define MUI_FINISHPAGE_SHOWREADME "${NSISDIR}\Docs\InstallOptionsEx\Readme.html"
		!define MUI_FINISHPAGE_LINK "InstallOptionsEx Home Page"
		!define MUI_FINISHPAGE_LINK_LOCATION "http://nsis-ioex.sourceforge.net/"
	!insertmacro MUI_PAGE_FINISH
		!define UMUI_ABORTPAGE_LINK "InstallOptionsEx Home Page"
		!define UMUI_ABORTPAGE_LINK_LOCATION "http://nsis-ioex.sourceforge.net/"
	!insertmacro UMUI_PAGE_ABORT
 
	!insertmacro MUI_UNPAGE_WELCOME
	!insertmacro MUI_UNPAGE_CONFIRM
	!insertmacro MUI_UNPAGE_INSTFILES
		!define MUI_FINISHPAGE_LINK "InstallOptionsEx Home Page"
		!define MUI_FINISHPAGE_LINK_LOCATION "http://nsis-ioex.sourceforge.net/"
	!insertmacro MUI_UNPAGE_FINISH
		!define UMUI_ABORTPAGE_LINK "InstallOptionsEx Home Page"
		!define UMUI_ABORTPAGE_LINK_LOCATION "http://nsis-ioex.sourceforge.net/"
	!insertmacro UMUI_UNPAGE_ABORT

;--------------------------------
;Languages

; first language is the default language if the system language is not in this list
	!insertmacro MUI_LANGUAGE "English"

; Other UMUI translated languages
	!insertmacro MUI_LANGUAGE "French"
	!insertmacro MUI_LANGUAGE "PortugueseBR"
	!insertmacro MUI_LANGUAGE "German"

; Other untranslated languages but usable even so.
  !insertmacro MUI_LANGUAGE "Spanish"
	!insertmacro MUI_LANGUAGE "SimpChinese"
	!insertmacro MUI_LANGUAGE "TradChinese"
	!insertmacro MUI_LANGUAGE "Japanese"
	!insertmacro MUI_LANGUAGE "Korean"
	!insertmacro MUI_LANGUAGE "Italian"
	!insertmacro MUI_LANGUAGE "Dutch"
	!insertmacro MUI_LANGUAGE "Danish"
	!insertmacro MUI_LANGUAGE "Swedish"
	!insertmacro MUI_LANGUAGE "Norwegian"
	!insertmacro MUI_LANGUAGE "Finnish"
	!insertmacro MUI_LANGUAGE "Greek"
	!insertmacro MUI_LANGUAGE "Russian"
	!insertmacro MUI_LANGUAGE "Portuguese"
	!insertmacro MUI_LANGUAGE "Polish"
	!insertmacro MUI_LANGUAGE "Ukrainian"
	!insertmacro MUI_LANGUAGE "Czech"
	!insertmacro MUI_LANGUAGE "Slovak"
	!insertmacro MUI_LANGUAGE "Croatian"
	!insertmacro MUI_LANGUAGE "Bulgarian"
	!insertmacro MUI_LANGUAGE "Hungarian"
	!insertmacro MUI_LANGUAGE "Thai"
	!insertmacro MUI_LANGUAGE "Romanian"
	!insertmacro MUI_LANGUAGE "Latvian"
	!insertmacro MUI_LANGUAGE "Macedonian"
	!insertmacro MUI_LANGUAGE "Estonian"
	!insertmacro MUI_LANGUAGE "Turkish"
	!insertmacro MUI_LANGUAGE "Lithuanian"
	!insertmacro MUI_LANGUAGE "Catalan"
	!insertmacro MUI_LANGUAGE "Slovenian"
	!insertmacro MUI_LANGUAGE "Serbian"
	!insertmacro MUI_LANGUAGE "SerbianLatin"
	!insertmacro MUI_LANGUAGE "Arabic"
	!insertmacro MUI_LANGUAGE "Farsi"
	!insertmacro MUI_LANGUAGE "Hebrew"
	!insertmacro MUI_LANGUAGE "Indonesian"
	!insertmacro MUI_LANGUAGE "Mongolian"
	!insertmacro MUI_LANGUAGE "Luxembourgish"
	!insertmacro MUI_LANGUAGE "Albanian"
	!insertmacro MUI_LANGUAGE "Breton"
	!insertmacro MUI_LANGUAGE "Belarusian"
	!insertmacro MUI_LANGUAGE "Icelandic"
	!insertmacro MUI_LANGUAGE "Malay"
	!insertmacro MUI_LANGUAGE "Bosnian"
	!insertmacro MUI_LANGUAGE "Kurdish"
	!insertmacro MUI_LANGUAGE "Basque"
	!insertmacro MUI_LANGUAGE "Welsh"
	!insertmacro MUI_LANGUAGE "Irish"
	!insertmacro MUI_LANGUAGE "NorwegianNynorsk"
	!insertmacro MUI_LANGUAGE "Valencian"
	!insertmacro MUI_LANGUAGE "Uzbek"
	!insertmacro MUI_LANGUAGE "Galician"
	!insertmacro MUI_LANGUAGE "Afrikaans"
	
;--------------------------------
; The stuff to install

Section "${NAME}" SecIOEx
	SectionIn RO
	
	SetOutPath $INSTDIR\Plugins
	File "..\..\Plugins\InstallOptionsEx.dll"
		
	SetOutPath $INSTDIR\Examples\InstallOptionsEx
	File "*.nsi"
	File "*.ini"
	
	SetOutPath $INSTDIR\Docs\InstallOptionsEx
	File "..\..\Docs\InstallOptionsEx\*.*"
	
	; Write the uninstall keys for Windows
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "DisplayName" "${NAME}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "UninstallString" '"$INSTDIR\uninstall_InstallOptionsEx.exe"'
	WriteUninstaller "uninstall_InstallOptionsEx.exe"

	!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
		SetOutPath "$SMPROGRAMS\$STARTMENU_FOLDER\"
		CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\InstallOptionsEx Readme.lnk" "$INSTDIR\Docs\InstallOptionsEx\Readme.html"
		CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall InstallOptionsEx.lnk" "$INSTDIR\uninstall_InstallOptionsEx.exe"
	!insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

Section "Source Code" SecSrc
		
	SetOutPath $INSTDIR\Contrib\InstallOptionsEx
	File "..\..\Contrib\InstallOptionsEx\*.h"
	File "..\..\Contrib\InstallOptionsEx\*.cpp"
	File "..\..\Contrib\InstallOptionsEx\ioptdll.rc"
	File "..\..\Contrib\InstallOptionsEx\io.dsp"
	File "..\..\Contrib\InstallOptionsEx\io.dsw"
	File "..\..\Contrib\InstallOptionsEx\io.sln"
	File "..\..\Contrib\InstallOptionsEx\io.vcproj"
	SetOutPath $INSTDIR\Contrib\InstallOptionsEx\Controls
	File "..\..\Contrib\InstallOptionsEx\Controls\*.h"
		
SectionEnd

;--------------------------------
; Uninstaller

Section "Uninstall"
	
	; Remove registry keys
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}"
	DeleteRegKey HKLM "SOFTWARE\NSIS\${NAME}"

	Delete "$INSTDIR\Plugins\InstallOptionsEx.dll"
	RMDir /r "$INSTDIR\Contrib\InstallOptionsEx"
	Delete "$INSTDIR\Docs\InstallOptionsEx\*.*"
	RMDir "$INSTDIR\Docs\InstallOptionsEx"
	Delete "$INSTDIR\Examples\InstallOptionsEx\*.*"
	RMDir "$INSTDIR\Examples\InstallOptionsEx"
	Delete "$INSTDIR\uninstall_InstallOptionsEx.exe"
	RMDir "$INSTDIR"

	!insertmacro MUI_STARTMENU_GETFOLDER Application $STARTMENU_FOLDER
	Delete "$SMPROGRAMS\$STARTMENU_FOLDER\InstallOptionsEx Readme.lnk"
	Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall InstallOptionsEx.lnk"
	RMDir "$SMPROGRAMS\$STARTMENU_FOLDER"
	RMDir "$SMPROGRAMS\$STARTMENU_FOLDER\.."
	
SectionEnd

;--------------------------------
;Confirm page function

!macro confirm_addline section

	SectionGetFlags ${Sec${section}} $1
	IntOp $1 $1 & ${SF_SELECTED}
	IntCmp $1 ${SF_SELECTED} 0 n${section} n${section}
		SectionGetText ${Sec${section}} $1
		!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "    - $1"
	n${section}:

!macroend

Function confirm_function

	!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "$(UMUI_TEXT_INSTCONFIRM_TEXTBOX_DESTINATION_LOCATION)"
	!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "      $INSTDIR"
	!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE ""

	;Only if StartMenu Floder is selected
	!insertmacro MUI_STARTMENU_WRITE_BEGIN Application

		!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "$(UMUI_TEXT_INSTCONFIRM_TEXTBOX_START_MENU_FLODER)"
		!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "      $STARTMENU_FOLDER"
		!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE ""

		;ShellVarContext
		!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "$(UMUI_TEXT_SHELL_VAR_CONTEXT)"
		!insertmacro UMUI_GETSHELLVARCONTEXT
		Pop $1
		StrCmp $1 "all" 0 current
			!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "      $(UMUI_TEXT_SHELL_VAR_CONTEXT_FOR_ALL_USERS)"
			Goto endsvc
		current:
			!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "      $(UMUI_TEXT_SHELL_VAR_CONTEXT_ONLY_FOR_CURRENT_USER)"
		endsvc:
		!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE ""

	!insertmacro MUI_STARTMENU_WRITE_END


	!insertmacro UMUI_CONFIRMPAGE_TEXTBOX_ADDLINE "$(UMUI_TEXT_INSTCONFIRM_TEXTBOX_COMPNENTS)"

	!insertmacro confirm_addline IOEx
	!insertmacro confirm_addline Src

FunctionEnd

;--------------------------------
;Installer Functions

Function .onInit
  !insertmacro UMUI_MULTILANG_GET
FunctionEnd

;--------------------------------
;Uninstaller Functions

Function un.onInit
  !insertmacro UMUI_MULTILANG_GET
FunctionEnd