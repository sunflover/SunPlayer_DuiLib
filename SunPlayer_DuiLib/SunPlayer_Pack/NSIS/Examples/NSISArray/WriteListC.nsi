!include MUI.nsh
!include NSISArray.nsh

Name 'WriteListC'
OutFile 'NSISArrayExample - WriteListC.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 3 6
${ArrayFunc} WriteListC
${ArrayFunc} Debug
${ArrayFunc} Read

Section

  ${TestArray->Init}

  DetailPrint "Testing 'WriteListC'..."
  ${TestArray->WriteListC} "zero|one|two|three|jaja|t" "|"
  ${TestArray->Debug}
  Sleep 3000

  DetailPrint ""
  DetailPrint "Items in array:"
  ${TestArray->Read} $R0 0
  DetailPrint $R0
  ${TestArray->Read} $R1 1
  DetailPrint $R1
  ${TestArray->Read} $R2 2
  DetailPrint $R2
  ${TestArray->Read} $R3 3
  DetailPrint $R3
  ${TestArray->Read} $R4 4
  DetailPrint $R4
  ${TestArray->Read} $R5 5
  DetailPrint $R5

  ${TestArray->Delete}

SectionEnd