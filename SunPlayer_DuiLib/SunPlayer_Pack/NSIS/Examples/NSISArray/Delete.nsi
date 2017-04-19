!include MUI.nsh
!include NSISArray.nsh

Name 'Delete'
OutFile 'NSISArrayExample - Delete.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 3 9
${ArrayFunc} WriteListC
${ArrayFunc} Debug

Section

  ${TestArray->Init}

  ${TestArray->WriteListC} "Cat Hippo Dog Elephant" " "
  DetailPrint 'TestArray = [Cat, Hippo, Dog, Elephant]'
  DetailPrint ""
  Sleep 3000

  DetailPrint 'Deleting the array from memory.'
  DetailPrint ""
  ${TestArray->Delete}
  DetailPrint 'Going to try and reference the array after its deletion:'

  ${TestArray->Debug}
  MessageBox MB_OK "Error code: $ArrayErr"

SectionEnd