!include MUI.nsh
!include NSISArray.nsh

Name 'Subtract'
OutFile 'NSISArrayExample - Subtract.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray1" 3 2
${ArrayFunc} WriteList
${ArrayFunc} Subtract
${ArrayFunc} Debug
${Array} "TestArray2" 6 2
${ArrayFunc} WriteList
${ArrayFunc} Debug

Section

  ${TestArray1->Init}
  ${TestArray2->Init}

  ${TestArray1->WriteList} "'0' '1' '2' '3' '4' '5'"
  DetailPrint 'TestArray1 = [0, 1, 2, 3, 4, 5]'
  DetailPrint ""
  ${TestArray2->WriteList} "'1' '3' '5'"
  DetailPrint 'TestArray2 = [1, 3, 5]'
  DetailPrint ""
  Sleep 3000

  DetailPrint 'Subtracting TestArray2 from TestArray1...'
  ${TestArray1->Subtract} TestArray2
  ${TestArray2->Delete}
  ${TestArray1->Debug}

  ${TestArray1->Delete}

SectionEnd