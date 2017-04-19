!include MUI.nsh
!include NSISArray.nsh

Name 'Clear'
OutFile 'NSISArrayExample - Clear.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 3 5
${ArrayObj} .
${ArrayFunc} WriteList
${ArrayFunc} SizeOf
${ArrayFunc} Clear

Section

  ${TestArray.Init}

  ${TestArray.WriteList} "'zero' 'one' 'two' 'three' '1' '2' '3'"
  DetailPrint 'TestArray = [zero, one, two, three, 1, 2, 3]'
  DetailPrint ""
  Sleep 3000

  ${TestArray.SizeOf} $R0 $R1 $R2
  DetailPrint "TestArray has strings of $R0 in length."
  DetailPrint "TestArray has $R1 item slots allocated for use."
  DetailPrint "TestArray contains $R2 items."
  DetailPrint ""
  Sleep 3000

  DetailPrint "Clearing TestArray..."
  ${TestArray.Clear}
  ${TestArray.SizeOf} $R0 $R1 $R2
  DetailPrint "TestArray has strings of $R0 in length."
  DetailPrint "TestArray has $R1 item slots allocated for use."
  DetailPrint "TestArray now contains $R2 items."

  ${TestArray.Delete}

SectionEnd