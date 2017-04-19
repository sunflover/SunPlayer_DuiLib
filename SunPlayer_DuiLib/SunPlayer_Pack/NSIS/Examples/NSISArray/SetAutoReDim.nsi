!include MUI.nsh
!include NSISArray.nsh

Name 'SetAutoReDim'
OutFile 'NSISArrayExample - SetAutoReDim.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 5 5
${ArrayObj} .
${ArrayFunc} Shift
${ArrayFunc} SizeOf
${ArrayFunc} SetAutoReDim

Section

  ${TestArray.Init}

  ${TestArray.SizeOf} $R0 $R1 $R2
  DetailPrint "TestArray has strings of $R0 in length."
  DetailPrint "TestArray has $R1 item slots allocated for use."
  DetailPrint "TestArray contains $R2 items."
  DetailPrint ""
  Sleep 3000

  DetailPrint "Setting item increase count to 32."
  DetailPrint "Setting string length increase to 64."
  ${TestArray.SetAutoReDim} 32 64
  Sleep 3000

  DetailPrint ""
  DetailPrint "Now adding 6 items of 6 bytes in length..."
  ${TestArray.Shift} "hello"
  ${TestArray.Shift} "hello"
  ${TestArray.Shift} "hello"
  ${TestArray.Shift} "hello"
  ${TestArray.Shift} "hello"
  ${TestArray.Shift} "hello"

  DetailPrint ""
  ${TestArray.SizeOf} $R0 $R1 $R2
  DetailPrint "TestArray has strings of $R0 in length."
  DetailPrint "TestArray has $R1 item slots allocated for use."
  DetailPrint "TestArray now contains $R2 items."

  ${TestArray.Delete}

SectionEnd