!include MUI.nsh
!include NSISArray.nsh

Name 'Copy'
OutFile 'NSISArrayExample - Copy.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray1" 3 2
${ArrayFunc} Debug
${ArrayFunc} WriteList
${ArrayFunc} Copy
${Array} "TestArray2" 3 2
${ArrayFunc} Debug
${ArrayFunc} SizeOf

Section

  ${TestArray1->Init}
  ${TestArray2->Init}

  ${TestArray1->WriteList} "'0' '1' '2' '4' '3' '5'"
  DetailPrint 'TestArray1 = [0, 1, 2, 4, 3, 5]'
  DetailPrint ""
  ${TestArray2->Debug}
  Sleep 3000

  ${TestArray2->SizeOf} $R0 $R1 $R2
  DetailPrint "TestArray2 initialized to $R2 items."
  DetailPrint "Copying TestArray1 to TestArray2..."
  DetailPrint ""
  Sleep 3000

  ${TestArray1->Copy} TestArray2
  ${TestArray2->Debug}
  ${TestArray2->SizeOf} $R0 $R1 $R2
  DetailPrint "TestArray2 now has $R2 items."

  ${TestArray1->Delete}
  ${TestArray2->Delete}

SectionEnd