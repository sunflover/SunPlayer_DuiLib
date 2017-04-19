!include MUI.nsh
!include NSISArray.nsh

Name 'ReDim'
OutFile 'NSISArrayExample - ReDim.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 3 5
${ArrayObj} .
${ArrayFunc} SizeOf
${ArrayFunc} ReDim

Section

  ${TestArray.Init}

  ${TestArray.SizeOf} $R0 $R1 $R2
  DetailPrint "TestArray has strings of $R0 in length."
  DetailPrint "TestArray has $R1 item slots allocated for use."
  DetailPrint "TestArray contains $R2 items."
  DetailPrint ""
  Sleep 3000

  DetailPrint "Testing 'ReDim'..."
  ${TestArray.ReDim} 10 10
  DetailPrint "'ReDim' should allocate 10 items (from 3)"
  DetailPrint "and 10 characters per item (from 5)..."
  DetailPrint ""
  Sleep 3000

  ${TestArray.SizeOf} $R0 $R1 $R2
  DetailPrint "TestArray has strings of $R0 in length."
  DetailPrint "TestArray has $R1 item slots allocated for use."
  DetailPrint "TestArray now contains $R2 items."

  ${TestArray.Delete}

SectionEnd