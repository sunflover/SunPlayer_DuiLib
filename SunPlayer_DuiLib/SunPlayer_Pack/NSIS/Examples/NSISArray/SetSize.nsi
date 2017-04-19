!include MUI.nsh
!include NSISArray.nsh

Name 'SetSize'
OutFile 'NSISArrayExample - SetSize.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 9 6
${ArrayFunc} WriteList
${ArrayFunc} SetSize
${ArrayFunc} Debug

Section

  ${TestArray->Init}

  ${TestArray->WriteList} "'zero' 'one' 'two' 'three'"
  DetailPrint 'TestArray = [zero, one, two, three]'
  DetailPrint ""
  ${TestArray->Debug}
  Sleep 3000

  DetailPrint "Making array bigger..."
  ${TestArray->SetSize} 8
  DetailPrint "Reviewing changes..."
  ${TestArray->Debug}
  Sleep 3000

  DetailPrint ""
  DetailPrint "Making array smaller..."
  ${TestArray->SetSize} 3
  DetailPrint "Reviewing changes..."
  ${TestArray->Debug}

  ${TestArray->Delete}

SectionEnd