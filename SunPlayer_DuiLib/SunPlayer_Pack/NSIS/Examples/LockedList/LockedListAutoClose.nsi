Name "LockedList Test"
OutFile "LockedListTest.exe"

!include MUI.nsh

!insertmacro MUI_PAGE_WELCOME
Page Custom LockedListShow

!insertmacro MUI_LANGUAGE English

Function LockedListShow
  !insertmacro MUI_HEADER_TEXT `LockedList Test` `Using AddModule and notepad.exe`
  LockedList::AddModule /NOUNLOAD $SYSDIR\notepad.exe
  LockedList::Dialog /autoclose `` `` `` /ignore `Close All`
FunctionEnd

Section
SectionEnd