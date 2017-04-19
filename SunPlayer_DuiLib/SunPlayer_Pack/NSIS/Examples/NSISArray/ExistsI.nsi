!include MUI.nsh
!include NSISArray.nsh

Name 'ExistsI'
OutFile 'NSISArrayExample - ExistsI.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 1 5
${ArrayFunc} WriteListC
${ArrayFunc} ExistsI

Section

  ${TestArray->Init}

  ${TestArray->WriteListC} "Cat Hippo Dog Elephant" " "
  DetailPrint 'TestArray = [Cat, Hippo, Dog, Elephant]'
  DetailPrint "Testing 'ExistsI' with dog and Dog. Don't forget that 'ExistsI' is NOT case sensitive."
  DetailPrint ""
  Sleep 3000

  ${TestArray->ExistsI} $R0 "dog" 0
  DetailPrint "Result of 'ExistsI' for 'dog', starting at index 0: $R0"
  DetailPrint ""
  Sleep 3000

  ${TestArray->ExistsI} $R0 "Dog" 0
  DetailPrint "Result of 'ExistsI' for 'Dog', starting at index 0: $R0"

  ${TestArray->Delete}

SectionEnd