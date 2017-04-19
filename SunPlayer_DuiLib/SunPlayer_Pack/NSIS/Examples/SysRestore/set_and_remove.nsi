!include MUI.nsh

Name `System Restore Example`
OutFile `System Restore Example.exe`

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

ShowInstDetails show

!insertmacro MUI_LANGUAGE English

Section

  SysRestore::StartRestorePoint /NOUNLOAD `System Restore Example`
  Pop $R0
  StrCmp $R0 0 0 End
    MessageBox MB_OK|MB_ICONINFORMATION `Step 1/3: System restore point started`

  SysRestore::FinishRestorePoint /NOUNLOAD
  Pop $R0
  StrCmp $R0 0 0 End
    MessageBox MB_OK|MB_ICONINFORMATION `Step 2/3: System restore point finished.`

  SysRestore::RemoveRestorePoint
  Pop $R0
  StrCmp $R0 0 0 End
    MessageBox MB_OK|MB_ICONINFORMATION `Step 3/3: System restore point removed.`

  Goto +2
  End:
    MessageBox MB_OK|MB_ICONINFORMATION `System restore point operation failed.`

SectionEnd