!include MUI.nsh
!include NSISArray.nsh

Name 'Search'
OutFile 'NSISArrayExample - Search.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 4 9
${ArrayFunc} WriteListC
${ArrayFunc} Search

Section

  ${TestArray->Init}

  ${TestArray->WriteListC} "Cat Hippo Dog ElePhant" " "
  DetailPrint 'Array = [Cat, Hippo, Dog, ElePhant]'
  DetailPrint ""
  Sleep 3000

  DetailPrint "Testing 'Search'. Note that it is case sensitive."
  Sleep 3000

  DetailPrint "Performing 'Search' for 'phant'..."
  DetailPrint ""
  ${TestArray->Search} $R0 "phant" 0
  DetailPrint "Search for 'phant': $R0"
  Sleep 3000

  ${TestArray->Search} $R0 "Phant" 0
  DetailPrint "Search for 'Phant': $R0"

  ${TestArray->Delete}

SectionEnd