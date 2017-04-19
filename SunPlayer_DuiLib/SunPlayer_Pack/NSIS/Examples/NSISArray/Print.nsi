!include MUI.nsh
!include NSISArray.nsh

Name 'Print'
OutFile 'NSISArrayExample - Print.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 4 6
${ArrayFunc} WriteList
${ArrayFunc} Print

Section

  ${TestArray->Init}

  ${TestArray->WriteList} "'zero' 'one' 'two' 'three'"
  DetailPrint 'TestArray = [zero, one, two, three]'
  DetailPrint ""
  Sleep 3000

  DetailPrint "Testing 'Print'..."
  DetailPrint ""
  ${TestArray->Print} 0
  ${TestArray->Print} 1
  ${TestArray->Print} 2
  ${TestArray->Print} 3

  ${TestArray->Delete}

SectionEnd