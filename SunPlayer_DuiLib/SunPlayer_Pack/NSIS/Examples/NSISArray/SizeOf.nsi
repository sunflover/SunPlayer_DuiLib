!include MUI.nsh
!include NSISArray.nsh

Name 'Search'
OutFile 'NSISArrayExample - SizeOf.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 4 9
${ArrayFunc} WriteListC
${ArrayFunc} SizeOf

Section

  ${TestArray->Init}

  ${TestArray->WriteListC} "Cat Hippo Dog Elephant" " "
  DetailPrint 'Array = [Cat, Hippo, Dog, Elephant]'
  DetailPrint ""
  Sleep 3000

  DetailPrint "Testing 'SizeOf'."
  DetailPrint ""
  Sleep 3000

  ${TestArray->SizeOf} $R0 $R1 $R2
  DetailPrint "TestArray has strings of $R0 in length."
  DetailPrint "TestArray has $R1 item slots allocated for use."
  DetailPrint "TestArray contains $R2 items."
  Sleep 3000

  ${TestArray->Delete}

SectionEnd