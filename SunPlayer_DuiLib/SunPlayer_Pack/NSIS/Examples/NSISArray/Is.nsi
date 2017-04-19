!include MUI.nsh
!include NSISArray.nsh

Name 'Is'
OutFile 'NSISArrayExample - Is.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 4 6
${ArrayFunc} WriteListC
${ArrayFunc} SizeOf
${ArrayFunc} Read
${ArrayFunc} Debug

Section

  ${TestArray->Init}

  DetailPrint "We haven't written anything to TestArray yet."
  DetailPrint ""
  DetailPrint "Testing if the array is empty..."
  ${TestArray->SizeOf} $R0 $R1 $R2
  StrCmp $R1 0 0 +2
  DetailPrint "TestArray is empty!"
  Sleep 3000

  DetailPrint ""
  DetailPrint "Adding some data..."
  ${TestArray->WriteListC} "zero|one|two|three" "|"
  DetailPrint 'TestArray = [zero, one, two, three]'
  Sleep 3000

  DetailPrint ""
  DetailPrint "Testing if the array is full..."
  ${TestArray->SizeOf} $R0 $R1 $R2
  StrCmp $R1 $R2 0 +2
  DetailPrint "TestArray is now full!"
  Sleep 3000

  DetailPrint ""
  DetailPrint "Testing if an index of 2 is in range of our items..."
  ${TestArray->SizeOf} $R0 $R1 $R2
  IntCmp 2 $R2 +2 0 +2
  DetailPrint "Index 2 is in range..."
  Sleep 3000

  ${TestArray->Debug}
  ${TestArray->Read} $R0 2
  DetailPrint "It's: $R0"

  ${TestArray->Delete}

SectionEnd