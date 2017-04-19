; Example with classic NSIS style
Name nsWeb
OutFile nsWeb-CUI.exe
InstallDir $EXEDIR
ShowInstDetails show
XPStyle on

Page directory
Page custom "ShowWebControl" "" ": WebBrowser control web dialog"
Page custom "ShowHTMLControl" "" ": WebBrowser control html file dialog"
Page custom "ShowHTMLText" "" ": WebBrowser control html text dialog"
Page components "" "ShowPopURL" ""
Page instfiles

Function .onInit
InitPluginsDir
# Drop everything into the $PLUGINSDIR on init.
# For quick calling at its time
File /oname=$PLUGINSDIR\nsWeb.dll "${NSISDIR}\Plugins\nsWeb.dll"
File /oname=$PLUGINSDIR\file1.htm file1.htm
File /oname=$PLUGINSDIR\file2.htm file2.htm
FunctionEnd

Function "ShowWebControl"
nsWeb::ShowWebInPage "http://www.google.com.mx"
FunctionEnd

Function "ShowHTMLControl"
nsWeb::ShowWebInPage "$PLUGINSDIR\file1.htm"
FunctionEnd

Function "ShowHTMLText"
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
