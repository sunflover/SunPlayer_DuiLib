!include MUI.nsh
!include NSISArray.nsh

Name 'Pop'
OutFile 'NSISArrayExample - Pop.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 4 6
${ArrayFunc} WriteList
${ArrayFunc} Debug
${ArrayFunc} Pop

Section

  ${TestArray->Init}

  ${TestArray->WriteList} "'zero' 'one' 'two' 'three'"
  DetailPrint 'TestArray = [zero, one, two, three]'
  DetailPrint ""
  Sleep 3000

  DetailPrint "Testing 'Pop'..."
  DetailPrint ""
  ${TestArray->Pop} $R0
  DetailPrint "Item popped: $R0"
  ${TestArray->Debug}

  ${TestArray->Delete}

SectionEnd