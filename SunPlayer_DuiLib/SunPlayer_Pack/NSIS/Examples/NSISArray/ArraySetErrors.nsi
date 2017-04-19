!include MUI.nsh
!include NSISArray.nsh

Name 'SetErrors'
OutFile 'NSISArrayExample - SetErrors.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

!define ArraySetErrors

${Array} "TestArray" 1 2
${ArrayFunc} Write
${ArrayFunc} Read

Section

  ${TestArray->Init}

  DetailPrint "Lets create errors by referencing"
  DetailPrint "indexes that are out of range..."
  DetailPrint ""
  Sleep 3000

  ClearErrors
  ${TestArray->Write} 2 "!"
  IfErrors 0 +2
   DetailPrint "We got an error code #$ArrayErr for Write!"
  
  ClearErrors
  ${TestArray->Read} $R0 0
  IfErrors 0 +2
   DetailPrint "We got an error code #$ArrayErr for Read!"

  ${TestArray->Delete}

SectionEnd