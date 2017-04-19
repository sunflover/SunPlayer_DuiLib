!include MUI.nsh
!include NSISArray.nsh

Name 'ReadtoStack'
OutFile 'NSISArrayExample - ReadtoStack.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 4 6
${ArrayFunc} WriteList
${ArrayFunc} ReadtoStack
${ArrayFunc} Debug

Section

  ${TestArray->Init}

  ${TestArray->WriteList} "'zero' 'one' 'two' 'three'"
  DetailPrint 'TestArray = [zero, one, two, three]'
  DetailPrint ""
  Sleep 3000

  DetailPrint "Testing 'ReadToStack'..."
  ${TestArray->ReadtoStack} 0 -1
  Pop $R0
  Pop $R1
  Pop $R2
  Pop $R3
  ${TestArray->Debug}
  Sleep 3000

  DetailPrint ""
  DetailPrint "Results here should match what you just saw:"
  DetailPrint "Item 0: $R0"
  DetailPrint "Item 1: $R1"
  DetailPrint "Item 2: $R2"
  DetailPrint "Item 3: $R3"
  Sleep 3000

  DetailPrint ""
  DetailPrint "Testing 'ReadToStack' (first 3 items only)..."
  ${TestArray->ReadtoStack} 0 2
  Pop $R0
  Pop $R1
  Pop $R2
  DetailPrint ""
  DetailPrint "Results here should be the 1st 3 items from what you just saw:"
  DetailPrint "Item 0: $R0"
  DetailPrint "Item 1: $R1"
  DetailPrint "Item 2: $R2"

  ${TestArray->Delete}

SectionEnd