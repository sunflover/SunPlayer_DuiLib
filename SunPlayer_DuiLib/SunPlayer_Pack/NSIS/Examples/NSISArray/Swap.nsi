!include MUI.nsh
!include NSISArray.nsh

Name 'Swap'
OutFile 'NSISArrayExample - Swap.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 6 2
${ArrayFunc} WriteList
${ArrayFunc} Debug
${ArrayFunc} Swap

Section

  ${TestArray->Init}

  ${TestArray->WriteList} "'0' '1' '4' '2' '3' '5'"
  DetailPrint 'TestArray = [0, 1, 4, 2, 3, 5]'
  DetailPrint ""
  ${TestArray->Debug}
  Sleep 3000

  DetailPrint "Now exchange 2 and 4..."
  DetailPrint ""
  ${TestArray->Swap} 2 4
  DetailPrint "Now view the corrected version:"
  ${TestArray->Debug}

  ${TestArray->Delete}

SectionEnd