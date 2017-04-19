!include MUI.nsh
!include NSISArray.nsh

Name 'Exists'
OutFile 'NSISArrayExample - Exists.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 1 5
${ArrayFunc} WriteListC
${ArrayFunc} Exists

Section

  ${TestArray->Init}

  ${TestArray->WriteListC} "Cat Hippo Dog Elephant" " "
  DetailPrint 'TestArray = [Cat, Hippo, Dog, Elephant]'
  DetailPrint "Testing 'Exists' with dog and Dog. Don't forget that 'Exists' is case sensitive."
  DetailPrint ""
  Sleep 3000

  ${TestArray->Exists} $R0 "dog" 0
  DetailPrint "Result of 'Exists' for 'dog', starting at index 0: $R0"
  DetailPrint ""
  Sleep 3000

  ${TestArray->Exists} $R0 "Dog" 0
  DetailPrint "Result of 'Exists' for 'Dog', starting at index 0: $R0"

  ${TestArray->Delete}

SectionEnd