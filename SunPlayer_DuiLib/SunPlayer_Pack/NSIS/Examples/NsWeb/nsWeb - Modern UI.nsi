; Example with Modern UI NSIS style

!include "MUI.nsh"

Name nsWeb
OutFile nsWeb-MUI.exe
InstallDir $EXEDIR
ShowInstDetails show
XPStyle on

!insertmacro MUI_PAGE_DIRECTORY
Page custom "ShowWebControl" "" ": WebBrowser control web dialog"
Page custom "ShowHTMLControl" "" ": WebBrowser control html file dialog"
Page custom "ShowHTMLText" "" ": WebBrowser control html text dialog"
!define MUI_PAGE_CUSTOMFUNCTION_SHOW "ShowPopURL"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"

Function .onInit
InitPluginsDir
# Drop everything into the $PLUGINSDIR on init.
# For quick calling at its time
File /oname=$PLUGINSDIR\nsWeb.dll "${NSISDIR}\Plugins\nsWeb.dll"
File /oname=$PLUGINSDIR\file1.htm file1.htm
File /oname=$PLUGINSDIR\file2.htm file2.htm
FunctionEnd

Function "ShowWebControl"
!insertmacro MUI_HEADER_TEXT "Testing nsWeb plugin" "You are watching http://nsis.sf.net"
nsWeb::ShowWebInPage "http://nsis.sf.net"
FunctionEnd

Function "ShowHTMLControl"
!insertmacro MUI_HEADER_TEXT "Testing nsWeb plugin" "You are watching file1.htm"
nsWeb::ShowWebInPage "$PLUGINSDIR\file1.htm"
FunctionEnd

Function "ShowHTMLText"
!insertmacro MUI_HEADER_TEXT "Testing nsWeb plugin" "You are watching plain HTML text"
nsWeb::ShowHTMLInPage "<b>I'm a <u>HTML text</u></b>"
FunctionEnd

Function "ShowPopURL"
nsWeb::ShowWebInPopUp "$PLUGINSDIR\file2.htm"
FunctionEnd

Section "Detect Internet?"
nsWeb::IsInet 3
DetailPrint "Do you have Internet connection: $3"
SectionEnd

Section -default
DetailPrint "It's over!"
SectionEnd
