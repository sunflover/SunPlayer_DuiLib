!include MUI.nsh
!include NSISArray.nsh

Name 'Reverse'
OutFile 'NSISArrayExample - Reverse.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 4 6
${ArrayFunc} WriteList
${ArrayFunc} Debug
${ArrayFunc} Reverse

Section

  ${TestArray->Init}

  ${TestArray->WriteList} "'zero' 'one' 'two' 'three'"
  DetailPrint ""
  DetailPrint "See debug window for original:"
  ${TestArray->Debug}
  Sleep 3000

  DetailPrint "Reversing TestArray with 'Reverse'..."
  DetailPrint ""
  ${TestArray->Reverse}
  DetailPrint "See debug window for reverse:"
  ${TestArray->Debug}

  ${TestArray->Delete}

SectionEnd