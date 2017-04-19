!include MUI.nsh
!include NSISArray.nsh

Name 'SearchI'
OutFile 'NSISArrayExample - SearchI.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 4 9
${ArrayFunc} WriteListC
${ArrayFunc} SearchI

Section

  ${TestArray->Init}

  ${TestArray->WriteListC} "Cat Hippo Dog ElePhant" " "
  DetailPrint 'Array = [Cat, Hippo, Dog, ElePhant]'
  DetailPrint ""
  Sleep 3000

  DetailPrint "Testing 'SearchI'. Note that it is NOT case sensitive."
  Sleep 3000

  DetailPrint "Performing 'SearchI' for 'phant'..."
  DetailPrint ""
  ${TestArray->SearchI} $R0 "phant" 0
  DetailPrint "SearchI for 'phant': $R0"
  Sleep 3000

  ${TestArray->SearchI} $R0 "Phant" 0
  DetailPrint "SearchI for 'Phant': $R0"

  ${TestArray->Delete}

SectionEnd