!include MUI.nsh
!include NSISArray.nsh

Name 'Inited'
OutFile 'NSISArrayExample - Inited.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 5 8
${ArrayFunc} Inited

Section

  ${TestArray->Init}

  DetailPrint "Testing 'Inited'..."
  DetailPrint ""
  ${TestArray->Inited} 0 +2
  DetailPrint "TestArray was initialised successfully!"

  ${TestArray->Delete}

SectionEnd