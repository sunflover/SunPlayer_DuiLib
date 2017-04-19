!include MUI.nsh
!include NSISArray.nsh

Name 'Push'
OutFile 'NSISArrayExample - Push.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 4 6
${ArrayFunc} WriteList
${ArrayFunc} SizeOf
${ArrayFunc} Debug
${ArrayFunc} Push

Section

  ${TestArray->Init}

  ${TestArray->WriteList} "'zero' 'one' 'two' 'three'"
  DetailPrint 'TestArray = [zero, one, two, three]'
  DetailPrint ""
  ${TestArray->SizeOf} $R0 $R1 $R2
  DetailPrint "TestArray has strings of $R0 in length."
  DetailPrint "TestArray has $R1 item slots allocated for use."
  DetailPrint "TestArray contains $R2 items."
  DetailPrint ""
  Sleep 3000

  DetailPrint "Pushing 'four'..."
  ${TestArray->Push} 'four'
  DetailPrint ""
  DetailPrint "See debug window..."
  ${TestArray->Debug}
  Sleep 3000

  DetailPrint "Pushing 'one hundred' which is greater than the"
  DetailPrint "current array string length of $R2..."
  DetailPrint ""
  ${TestArray->Push} 'one hundred'
  ${TestArray->SizeOf} $R0 $R1 $R2
  DetailPrint "TestArray has strings of $R0 in length."
  DetailPrint "TestArray has $R1 item slots allocated for use."
  DetailPrint "TestArray contains $R2 items."
  DetailPrint ""
  DetailPrint "See debug window again..."
  ${TestArray->Debug}

  ${TestArray->Delete}

SectionEnd