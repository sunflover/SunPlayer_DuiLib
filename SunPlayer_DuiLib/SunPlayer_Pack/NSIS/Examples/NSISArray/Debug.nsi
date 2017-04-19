!include MUI.nsh
!include NSISArray.nsh

Name 'Debug'
OutFile 'NSISArrayExample - Debug.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 3 9
${ArrayFunc} WriteListC
${ArrayFunc} Debug

Section

  ${TestArray->Init}

  ${TestArray->WriteListC} "Cat Hippo Dog Elephant Turtle Rat Squid Bird Hamster" " "
  DetailPrint 'TestArray = [Cat, Hippo, Dog, Elephant, Turtle, Rat, Squid, Bird, Hamster]'
  DetailPrint ""
  Sleep 3000

  ${TestArray->Debug}

  ${TestArray->Delete}

SectionEnd