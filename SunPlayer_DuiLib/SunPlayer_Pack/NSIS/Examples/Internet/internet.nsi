!include "defines.nsh"

Name "Internet"
OutFile "Internet.exe"
ShowInstDetails show
XPStyle on

Page instfiles

Section "-boo"
DetailPrint "Executing plugin...."
Internet::Ver ${VAR_0}
DetailPrint "Version: $0"
Internet::GetLocalHostIP ${VAR_1}
DetailPrint "My IP: $1"
Internet::GetLocalHostName ${VAR_2}
DetailPrint "My Host Name: $2"
Internet::GetUrlCode "127.0.0.1" "" ${VAR_3}
DetailPrint "The URL returns: $3"
DetailPrint "Plugin done."
SectionEnd
