!include MUI.nsh
!include NSISArray.nsh

Name 'Read'
OutFile 'NSISArrayExample - Read.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 4 6
${ArrayFunc} WriteList
${ArrayFunc} Read

Section

  ${TestArray->Init}

  ${TestArray->WriteList} "'zero' 'one' 'two' 'three'"
  DetailPrint 'TestArray = [zero, one, two, three]'
  DetailPrint ""
  Sleep 3000

  DetailPrint "Testing 'Read' for index 0..."
  ${TestArray->Read} $R0 0
  DetailPrint ""
  DetailPrint "Read from TestArray at index 0: $R0"

  ${TestArray->Delete}

SectionEnd