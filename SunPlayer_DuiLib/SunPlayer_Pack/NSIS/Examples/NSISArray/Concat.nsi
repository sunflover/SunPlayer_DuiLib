!include MUI.nsh
!include NSISArray.nsh

Name 'Concat'
OutFile 'NSISArrayExample - Concat.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 6 2
${ArrayFunc} WriteListC
${ArrayFunc} Debug
${ArrayFunc} Concat

Section

  ${TestArray->Init}

  ${TestArray->WriteListC} "1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20" "|"
  DetailPrint 'TestArray = [1, 2, 3, 4, 5, 6]'
  DetailPrint ""
  Sleep 3000

  ${TestArray->Debug}
  DetailPrint "Calling 'Concat' to join all items with a +..."
  DetailPrint ""
  ${TestArray->Concat} $R0 " + "
  DetailPrint 'Result:'
  DetailPrint '$R0'

  ${TestArray->Delete}

SectionEnd