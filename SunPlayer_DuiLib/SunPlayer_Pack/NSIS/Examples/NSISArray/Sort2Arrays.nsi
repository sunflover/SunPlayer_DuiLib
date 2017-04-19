!include MUI.nsh
!include NSISArray.nsh

Name 'Sort Two Arrays'
OutFile 'NSISArrayExample - Sort Two Arrays.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray1" 7 7
${ArrayFunc} WriteList
${ArrayFunc} Sort
${ArrayFunc} Debug
${Array} "TestArray2" 7 7
${ArrayFunc} WriteList
${ArrayFunc} Debug

Section

  ${TestArray1->Init}
  ${TestArray2->Init}

  ${TestArray1->WriteList} "'zero' 'one' 'two' 'three' '001' '002' '003'"
  DetailPrint 'TestArray1 = [zero, one, two, three, 001, 002, 003]'
  DetailPrint ""
  ${TestArray2->WriteList} "'data 1' 'data 2' 'data 3' 'data 4' 'data 5' 'data 6' 'data 7'"
  DetailPrint 'TestArray2 = [data 1, data 2, data 3, data 4, data 5, data 6, data 7]'
  DetailPrint ""
  Sleep 3000

  DetailPrint "Sorting TestArray2 by TestArray1..."
  ${TestArray1->Sort} "TestArray2"
  DetailPrint ""
  DetailPrint "Now View the sorted versions:"
  ${TestArray1->Debug}

  ${TestArray1->Delete}
  ${TestArray2->Delete}

SectionEnd