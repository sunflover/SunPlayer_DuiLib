!include MUI.nsh
!include NSISArray.nsh

Name 'ErrorStyle'
OutFile 'NSISArrayExample - ErrorStyle.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 1 2
${ArrayFunc} Write
${ArrayFunc} Read

Section

  ${TestArray->Init}

  DetailPrint "Lets create errors by referencing"
  DetailPrint "indexes that are out of range..."
  Sleep 3000

  DetailPrint "Error in message box:"
  ${ArrayErrorStyle} MsgBox
  ${TestArray->Write} 2 "!"

  DetailPrint "Error in log window:"
  ${ArrayErrorStyle} LogWin
  ${TestArray->Read} $R0 0

  ${TestArray->Delete}

SectionEnd