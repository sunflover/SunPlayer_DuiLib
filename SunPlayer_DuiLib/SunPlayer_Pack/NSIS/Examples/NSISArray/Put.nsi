!include MUI.nsh
!include NSISArray.nsh

Name 'Push'
OutFile 'NSISArrayExample - Push.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 4 12
${ArrayFunc} WriteList
${ArrayFunc} Debug
${ArrayFunc} Put

Section

  ${TestArray->Init}

  ${TestArray->WriteList} "'zero' 'one' 'two' 'three'"
  DetailPrint 'TestArray = [zero, one, two, three]'
  DetailPrint ""
  ${TestArray->Debug}
  Sleep 3000

  DetailPrint "Testing 'Put'..."
  ${TestArray->Put} 1 'insert...'
  Sleep 3000

  DetailPrint ""
  DetailPrint "View the changes..."
  ${TestArray->Debug}

  ${TestArray->Delete}

SectionEnd