#############################################################################
# Example of how to easilly add custom language support to custom forms
# Only the ex_lang_{YOURLANGHERE}.nsh files need to be added or translated
#
# As bonus example how to use your OS GUI language instead of the locale.
# No need for the customer to choose a language, since he/she can use the PC
# also can use the installer in this language.
#############################################################################

!define THISAPP "MyExLangSetup.exe"

!addplugindir "..\Plugins"   ;To be able to use the MoreInfo plugin
!include "MUI.nsh"

;The interface file with the dialog resources. Change this if you have made your own customized UI.
!define MUI_UI "${NSISDIR}\Contrib\UIs\modern.exe"

; MUI Settings
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP_NOSTRETCH

ReserveFile ".\ioInstallType.ini"
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

!insertmacro MUI_PAGE_WELCOME
Page custom PAGE_ioInstallType
!insertmacro MUI_PAGE_FINISH

#############################################################################
# The only line one needs to add to have customized language support added.
!include ex_lang_main.nsh
#############################################################################

Var IsDEFAULTINSTALLATION
Var DEFAULTINSTALLATION

CRCCheck off
XPStyle On
Name "Custom language test"
VIProductVersion "1.0.1.789"
OutFile ${THISAPP}

#############################################################################

Section
  ; Not used in this demo
SectionEnd

#############################################################################

Function .onInit
  ;The plugin if you want to OS GUI language, and not the language set locale
  MoreInfo::GetOSUserinterfaceLanguage
  ;For debug testing purposes un-comment line below: set to language LCID to test
  ;push 1043

  pop $LANGUAGE
FunctionEnd

#############################################################################

Function PAGE_ioInstallType  ;FunctionName defined with Page command
  ;Feel free to improve here...
  
  ;StrCpy $ioInstallTypeFile "ioInstallType.ini"
  
  ;Set the Language lines here before displaying the form
  
  !insertmacro MUI_HEADER_TEXT "$(ioInstallType_ELRS_TEXT_IO_TITLE)" "$(ioInstallType_ELRS_TEXT_IO_SUBTITLE)"
  ;!insertmacro MUI_INSTALLOPTIONS_INITDIALOG "${ioInstallTypeFile}"

  !insertmacro MUI_INSTALLOPTIONS_EXTRACT "ioInstallType.ini"
  ;File /oname="ioInstallType.ini" ".\ioInstallType.ini"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "ioInstallType.ini" "Field 1" "Text" "$(ioInstallType_ELRS_TEXT_IO_STANDARD_INSTALL)"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "ioInstallType.ini" "Field 2" "Text" "$(ioInstallType_ELRS_TEXT_IO_NONSTANDARD_INSTALL)"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "ioInstallType.ini" "Field 3" "Text" "$(ioInstallType_ELRS_TEXT_IO_COMMONCOMPONENTS)"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "ioInstallType.ini" "Field 4" "Text" "$(ioInstallType_ELRS_TEXT_IO_INDIVIDUALCOMPONENTS)"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "ioInstallType.ini" "Field 5" "Text" "$(ioInstallType_ELRS_TEXT_IO_EXPLAIN)"

  !insertmacro MUI_INSTALLOPTIONS_DISPLAY "ioInstallType.ini"

  ;Example of howto read a value from an (InstallType) INI file
  ;!insertmacro MUI_INSTALLOPTIONS_READ $IsDEFAULTINSTALLATION "ioInstallType.ini" "Field 2" "State"
  ;Push $DEFAULTINSTALLATION

  ;StrCmp $DEFAULTINSTALLATION "0" "" +2
  ;  InstType /NOCUSTOM
FunctionEnd

#############################################################################
; If you want to use this, do not forget to actually WriteToDisk the UNINST.EXE
; See NSIS manual and example how to to this...

;Uninstaller Functions
Function un.onInit
  ; Restore Language selection
  MoreInfo::GetOSUserinterfaceLanguage
  pop $LANGUAGE
FunctionEnd

#############################################################################
