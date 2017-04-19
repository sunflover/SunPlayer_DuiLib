!include MUI.nsh
!define ArrayCallInstDLL "$EXEDIR\..\..\Plugins\NSISArray.dll"
!include NSISArray.nsh

Name 'WriteList'
OutFile 'NSISArrayExample - WriteList.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 3 11
${ArrayFunc} WriteList
${ArrayFunc} Debug
${ArrayFunc} Write

Section

  ${TestArray->Init}

  DetailPrint "Testing 'WriteList'..."
  ${TestArray->WriteListBegin}
  ${TestArray->WriteListItem} "zero"
  ${TestArray->WriteListItem} "one"
  ${TestArray->WriteListItem} "two"
  ${TestArray->WriteListEnd}
  DetailPrint 'TestArray = [zero, one, two]'
  DetailPrint ""
  Sleep 3000

  DetailPrint "Write 'yeah, one!' to index 1..."
  ${TestArray->Write} 1 'yeah, one!'
  DetailPrint ""
  ${TestArray->Debug}

  ${TestArray->Delete}

SectionEnd