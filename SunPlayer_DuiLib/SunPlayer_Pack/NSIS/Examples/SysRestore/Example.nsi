Name "System Restore Example"
OutFile "System Restore Example.exe"
InstallDir "$PROGRAMFILES\$(^Name)\"

Page Directory
Page InstFiles
UninstPage UninstConfirm
UninstPage InstFiles

Section "install"
  SetOverWrite try
  DetailPrint "Setting System Restore point..."
  SysRestore::StartRestorePoint /NOUNLOAD "Installed $(^Name)"
  Pop $0
  StrCmp $0 0 next
  MessageBox MB_OK "Could not set System Restore start point. Error code: $0"
next:

  SetOutPath "$INSTDIR"
  File "example.nsi"
  WriteUninstaller "$INSTDIR\uninst.exe"
  
  ExecShell open "$INSTDIR"
  
  SysRestore::FinishRestorePoint
  Pop $0
  StrCmp $0 0 next0
  MessageBox MB_OK "Could not set System Restore end point. Error code: $0"
next0:
  SetAutoClose true
SectionEnd

Section "un.install"
  SetOverWrite try
  DetailPrint "Setting System Restore point..."
  SysRestore::StartUnRestorePoint /NOUNLOAD "Uninstalled $(^Name)"
  Pop $0
  StrCmp $0 0 next
  MessageBox MB_OK "Could not set System Restore start point. Error code: $0"
next:

  Delete "$INSTDIR\readme.txt"
  Delete "$INSTDIR\uninst.exe"
  RMDir "$INSTDIR"
  
  SysRestore::FinishRestorePoint
  Pop $0
  StrCmp $0 0 next0
  MessageBox MB_OK "Could not set System Restore end point. Error code: $0"
next0:
  SetAutoClose true
SectionEnd
