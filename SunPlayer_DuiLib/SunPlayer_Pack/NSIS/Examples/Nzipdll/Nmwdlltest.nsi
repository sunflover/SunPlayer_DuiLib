
!addplugindir "Plugins"

OutFile "Nmwdlltest.exe"
XPStyle on

Page custom SetCustom
Page instfiles
  ShowInstDetails show
  CompletedText " "
  InstallColors "000000" "FFFFFF"
  SubCaption 3 " "
  SubCaption 4 " "
  
!define page_ini "Nmw.ini"
ReserveFile "${NSISDIR}\Plugins\InstallOptions.dll"
ReserveFile "${page_ini}"

Function .onInit
  InitPluginsDir
  File "/oname=$PLUGINSDIR\${page_ini}" "${page_ini}"
FunctionEnd

Function SetCustom
 Push $R0
 Push $R1

  ReadRegStr $R0 HKLM "Software\NSIS" ""
  IfFileExists "$R0\*.*" set 0
  StrCpy $R0 "$PROGRAMFILES\NSIS"
  set:
  WriteINIStr "$PLUGINSDIR\${page_ini}" "Field 2" "State" "$R0"

  InstallOptions::dialog "$PLUGINSDIR\${page_ini}"
  Pop $R0

 Pop $R1
 Pop $R0
FunctionEnd

Section ""
 Push $R0
 Push $R1
 Push $R2
 Push $R3

  ReadINIStr $R0 "$PLUGINSDIR\${page_ini}" "Field 2" "State"
  ReadINIStr $R1 "$PLUGINSDIR\${page_ini}" "Field 4" "State"
  ReadINIStr $R2 "$PLUGINSDIR\${page_ini}" "Field 6" "State"
  DetailPrint "Compiling NSIS file..."

  Nmwdll::nmwMakensis "$R0\makensis.exe" "$R2" "$R1"
  Pop $R3
  DetailPrint "Error level: $R3"

 Pop $R3
 Pop $R2
 Pop $R1
 Pop $R0
SectionEnd