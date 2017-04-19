!include MUI.nsh
!include NSISArray.nsh

Name 'Write'
OutFile 'NSISArrayExample - Write.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 1 7
${ArrayFunc} Write
${ArrayFunc} Debug
${ArrayFunc} Read

Section

  ${TestArray->Init}

  DetailPrint "Testing 'Write' for index 0..."
  ${TestArray->Write} 0 "hello!"
  ${TestArray->Write} 1 "ja!"
  ${TestArray->Write} 2 "hehe"
  DetailPrint 'TestArray = [hello, ja!, hehe]'
  DetailPrint ""
  Sleep 3000

  ${TestArray->Debug}
  DetailPrint "Testing 'Read' for index 0..."
  DetailPrint ""
  ${TestArray->Read} $R0 0
  DetailPrint "Read from TestArray at index 0: $R0"

  ${TestArray->Delete}

SectionEnd