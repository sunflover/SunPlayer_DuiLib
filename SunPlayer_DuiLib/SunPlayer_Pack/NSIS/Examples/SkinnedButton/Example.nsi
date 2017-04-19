; example.nsi

;--------------------------------

!define VERSION 1.1
!define NAME "Skinned Button plugin for NSIS"

; The name of the installer
Name "${NAME} ${VERSION}"

; The file to write
OutFile "SkinnedButton${VERSION}.exe"

; The default installation directory
InstallDir $PROGRAMFILES\NSIS

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM Software\NSIS ""

LicenseData "..\..\Docs\skinnedbutton\license.txt"

;--------------------------------

; Pages

Page license
Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "${NAME}"
  SectionIn RO
  
  SetOutPath $INSTDIR\Plugins
  File "..\..\Plugins\skinnedbutton.dll"
    
  SetOutPath $INSTDIR\Examples\skinnedbutton
  File "Example.nsi"
  File "Example_MUI.nsi"

  SetOutPath $INSTDIR\Contrib\skinnedbutton\skins
  File "..\..\Contrib\skinnedbutton\skins\*.bmp"
  
  SetOutPath $INSTDIR\Docs\skinnedbutton
  File "..\..\Docs\skinnedbutton\*.txt"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "DisplayName" "${NAME}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}" "UninstallString" '"$INSTDIR\uninstall_skinnedbutton.exe"'
  WriteUninstaller "uninstall_skinnedbutton.exe"
  
  SetOutPath "$SMPROGRAMS\NSIS\Contrib\"
  CreateShortCut "$SMPROGRAMS\NSIS\Contrib\Skinned Button Readme.lnk" "$INSTDIR\Docs\skinnedbutton\Readme.txt"
  CreateShortCut "$SMPROGRAMS\NSIS\Contrib\Uninstall Skinned Button.lnk" "$INSTDIR\uninstall_skinnedbutton.exe"

SectionEnd

Section "Source Code"
    
  SetOutPath $INSTDIR\Contrib\skinnedbutton
  File "..\..\Contrib\skinnedbutton\exdll.h"
  File "..\..\Contrib\skinnedbutton\wa_dlg.h"
  File "..\..\Contrib\skinnedbutton\skinnedbutton.c"
  File "..\..\Contrib\skinnedbutton\skinnedbutton.dev"
    
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}"
  DeleteRegKey HKLM "SOFTWARE\NSIS\${NAME}"

  Delete "$INSTDIR\Plugins\skinnedbutton.dll"
  RMDir /r "$INSTDIR\Contrib\skinnedbutton"
  Delete "$INSTDIR\Docs\skinnedbutton\*.txt"
  RMDir "$INSTDIR\Docs\skinnedbutton"
  Delete "$INSTDIR\Examples\skinnedbutton\*.nsi"
  RMDir "$INSTDIR\Examples\skinnedbutton"
  
  Delete "$SMPROGRAMS\NSIS\Contrib\Skinned Button Readme.lnk"
  Delete "$SMPROGRAMS\NSIS\Contrib\Uninstall Skinned Button.lnk"
  RMDir "$SMPROGRAMS\NSIS\Contrib"
  RMDir "$SMPROGRAMS\NSIS"
  Delete "$INSTDIR\uninstall_skinnedbutton.exe"
  
SectionEnd



;-------------------------

; Skin the button

Function .onInit
  InitPluginsDir
  File "/oname=$PLUGINSDIR\button.bmp" "${NSISDIR}\Contrib\skinnedbutton\skins\ishield.bmp"
FunctionEnd

Function .onGUIInit
skinnedbutton::skinit /NOUNLOAD "$PLUGINSDIR\button.bmp"
  Pop $0
  StrCmp $0 "success" noerror
    MessageBox MB_ICONEXCLAMATION|MB_OK "skinned button error: $0"
  noerror:
FunctionEnd

Function .onGUIEnd
skinnedbutton::unskinit
FunctionEnd

Function un.onInit
  InitPluginsDir
  File "/oname=$PLUGINSDIR\button.bmp" "${NSISDIR}\Contrib\skinnedbutton\skins\ishield.bmp"
FunctionEnd

Function un.onGUIInit
	skinnedbutton::skinit /NOUNLOAD "$PLUGINSDIR\button.bmp"
  Pop $0
  StrCmp $0 "success" noerror
    MessageBox MB_ICONEXCLAMATION|MB_OK "skinned button error: $0"
  noerror:
FunctionEnd

Function un.onGUIEnd
	skinnedbutton::unskinit
FunctionEnd