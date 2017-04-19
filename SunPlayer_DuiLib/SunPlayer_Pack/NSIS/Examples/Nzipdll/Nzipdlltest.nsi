
!addplugindir "Plugins"

OutFile "Nzipdlltest.exe"
XPStyle on

Page custom SetCustom
Page instfiles
  ShowInstDetails show
  CompletedText " "
  InstallColors "000000" "FFFFFF"
  SubCaption 3 " "
  SubCaption 4 " "

!define page_ini "Nzip.ini"
ReserveFile "${NSISDIR}\Plugins\InstallOptions.dll"
ReserveFile "${page_ini}"

Function .onInit
  InitPluginsDir
  File "/oname=$PLUGINSDIR\${page_ini}" "${page_ini}"
FunctionEnd

Function SetCustom
 Push $R0
  InstallOptions::dialog "$PLUGINSDIR\${page_ini}"
  Pop $R0
 Pop $R0
FunctionEnd

Section ""
 Push $R0
 Push $R1
 Push $R2
 Push $R3
 
  ReadINIStr $R0 "$PLUGINSDIR\${page_ini}" "Field 6" "State"
  StrCmp $R0 1 0 nprc
  StrCpy $R2 "/PERCENT"
  Goto done
  nprc:
  ReadINIStr $R0 "$PLUGINSDIR\${page_ini}" "Field 7" "State"
  StrCmp $R0 1 0 nfil
  StrCpy $R2 "/FILES"
  Goto done
  nfil:
  StrCpy $R2 "/PROGBAR"
  done:

  ReadINIStr $R0 "$PLUGINSDIR\${page_ini}" "Field 2" "State"
  ReadINIStr $R1 "$PLUGINSDIR\${page_ini}" "Field 4" "State"
  DetailPrint "Extracting zip file..."
  
  Nzipdll::nzip $R2 "$R0" "$R1"
  Pop $R3
  DetailPrint "Error level: $R3"
  
 Pop $R3
 Pop $R2
 Pop $R1
 Pop $R0
SectionEnd