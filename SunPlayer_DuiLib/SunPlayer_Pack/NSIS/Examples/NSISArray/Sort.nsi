!include MUI.nsh
!include NSISArray.nsh

Name 'Sort'
OutFile 'NSISArrayExample - Sort.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 7 6
${ArrayFunc} WriteList
${ArrayFunc} Debug
${ArrayFunc} Sort

Section

  ${TestArray->Init}

  ${TestArray->WriteList} "'zero' 'one' 'two' 'three' '001' '002' '003'"
  DetailPrint 'TestArray = [zero, one, two, three, 001, 002, 003]'
  DetailPrint ""
  DetailPrint "View original Array:"
  ${TestArray->Debug}
  Sleep 3000

  DetailPrint ""
  DetailPrint "Sorting..."
  ${TestArray->Sort} ""
  DetailPrint ""
  DetailPrint "Now View the sorted version:"
  ${TestArray->Debug}

  ${TestArray->Delete}

SectionEnd