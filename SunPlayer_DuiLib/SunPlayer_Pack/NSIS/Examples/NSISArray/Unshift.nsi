!include MUI.nsh
!include NSISArray.nsh

Name 'Unshift'
OutFile 'NSISArrayExample - Unshift.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 4 6
${ArrayFunc} WriteList
${ArrayFunc} Debug
${ArrayFunc} Unshift

Section

  ${TestArray->Init}

  ${TestArray->WriteList} "'zero' 'one' 'two' 'three'"
  DetailPrint 'TestArray = [zero, one, two, three]'
  DetailPrint ""
  ${TestArray->Debug}
  Sleep 3000

  DetailPrint "Testing 'UnShift'..."
  DetailPrint ""
  ${TestArray->Unshift} $R0
  DetailPrint "Unshifted: $R0"
  DetailPrint ""
  DetailPrint "See debug window..."
  ${TestArray->Debug}

  ${TestArray->Delete}

SectionEnd