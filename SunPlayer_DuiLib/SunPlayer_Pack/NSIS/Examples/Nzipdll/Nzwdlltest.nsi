
!addplugindir "Plugins"

OutFile "Nzwdlltest.exe"
XPStyle on

Page custom SetCustomZip
Page custom SetCustomNsi
Page instfiles
  ShowInstDetails show
  CompletedText " "
  InstallColors "000000" "FFFFFF"
  SubCaption 3 " "
  SubCaption 4 " "
  
  
!define page_zip "Nzip.ini"
!define page_nsi "Nmw.ini"
ReserveFile "${NSISDIR}\Plugins\InstallOptions.dll"
ReserveFile "${page_zip}"
ReserveFile "${page_nsi}"


Function .onInit
  InitPluginsDir
  File "/oname=$PLUGINSDIR\${page_zip}" "${page_zip}"
  File "/oname=$PLUGINSDIR\${page_nsi}" "${page_nsi}"
FunctionEnd

Function SetCustomZip
 Push $R0
  WriteINIStr "$PLUGINSDIR\${page_zip}" "Field 5" "Flags" "DISABLED"
  WriteINIStr "$PLUGINSDIR\${page_zip}" "Field 6" "Flags" "DISABLED"
  WriteINIStr "$PLUGINSDIR\${page_zip}" "Field 7" "Flags" "DISABLED"
  WriteINIStr "$PLUGINSDIR\${page_zip}" "Field 8" "Flags" "DISABLED"
  InstallOptions::dialog "$PLUGINSDIR\${page_zip}"
  Pop $R0
 Pop $R0
FunctionEnd

Function SetCustomNsi
 Push $R0
 Push $R1

  ReadRegStr $R0 HKLM "Software\NSIS" ""
  IfFileExists "$R0\*.*" set 0
  StrCpy $R0 "$PROGRAMFILES\NSIS"
  set:
  WriteINIStr "$PLUGINSDIR\${page_nsi}" "Field 2" "State" "$R0"

  InstallOptions::dialog "$PLUGINSDIR\${page_nsi}"
  Pop $R0

 Pop $R1
 Pop $R0
FunctionEnd


Section ""
 Push $R0
 Push $R1
 Push $R2
 Push $R3
 
  ReadINIStr $R0 "$PLUGINSDIR\${page_zip}" "Field 2" "State"
  ReadINIStr $R1 "$PLUGINSDIR\${page_zip}" "Field 4" "State"
  DetailPrint "Extracting zip file..."

  Nzwdll::nzwUnzip "$R0" "$R1"
  Pop $R2
  DetailPrint "Error level: $R2"
  
  DetailPrint ""

  ReadINIStr $R0 "$PLUGINSDIR\${page_nsi}" "Field 2" "State"
  ReadINIStr $R1 "$PLUGINSDIR\${page_nsi}" "Field 4" "State"
  ReadINIStr $R2 "$PLUGINSDIR\${page_nsi}" "Field 6" "State"
  DetailPrint "Compiling NSIS file..."

  Nzwdll::nzwMakensis "$R0\makensis.exe" "$R2" "$R1"
  Pop $R3
  DetailPrint "Error level: $R3"
  
 Pop $R3
 Pop $R2
 Pop $R1
 Pop $R0
SectionEnd