!AddPluginDir "..\..\Plugins"
!include MUI.nsh
OutFile PopupListBox.exe

!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE English

Section

 Push /END
 Push "ja"
 Push "majs"
 PopupListBox::MultiSelect /HEADINGTEXT "Multiple selection list box..." "hello" "meh" "ja"
 Pop $R0
  DetailPrint $R0
 StrCmp $R0 CANCEL DoneA

 Pop $R0
 StrCmp $R0 /END +3
  DetailPrint $R0
 Goto -3

 DoneA:

 PopupListBox::SingleSelect /HEADINGTEXT "Single selection list box..." "hello" "meh" "ja" "majs" "ja" /END
 Pop $R0
  DetailPrint $R0
 StrCmp $R0 CANCEL DoneB
 Pop $R0
  DetailPrint $R0

 DoneB:

SectionEnd
