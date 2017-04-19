!include MUI.nsh
!include NSISArray.nsh

Name 'Join'
OutFile 'NSISArrayExample - Join.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray1" 3 2
${ArrayFunc} WriteList
${ArrayFunc} Debug
${Array} "TestArray2" 6 2
${ArrayFunc} WriteList
${ArrayFunc} Join
${ArrayFunc} Debug

Section

  ${TestArray1->Init}
  ${TestArray2->Init}

  ${TestArray1->WriteList} "'0' '1' '2'"
  DetailPrint 'TestArray1 = [0, 1, 2]'
  DetailPrint ""
  ${TestArray2->WriteList} "'3' '4' '5'"
  DetailPrint 'TestArray2 = [3, 4, 5]'
  DetailPrint ""
  Sleep 3000

  DetailPrint 'Joining TestArray2 onto the end of TestArray1...'
  ${TestArray2->Join} TestArray1
  ${TestArray2->Delete}
  ${TestArray1->Debug}

  ${TestArray1->Delete}

SectionEnd