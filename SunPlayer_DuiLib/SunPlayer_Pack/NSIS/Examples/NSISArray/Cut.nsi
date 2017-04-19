!include MUI.nsh
!include NSISArray.nsh

Name 'Cut'
OutFile 'NSISArrayExample - Cut.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 2 6
${ArrayFunc} WriteList
${ArrayFunc} Debug
${ArrayFunc} Cut

Section

  ${TestArray->Init}

  ${TestArray->WriteList} "'zero' 'one' 'two' 'three'"
  DetailPrint 'TestArray = [zero, one, two, three]'
  DetailPrint ""
  ${TestArray->Debug}
  Sleep 3000

  DetailPrint "Cut item at index 1 (2nd item)..."
  DetailPrint ""
  ${TestArray->Cut} $R0 1
  DetailPrint "Here's what we cut out: $R0"
  ${TestArray->Debug}

  ${TestArray->Delete}

SectionEnd