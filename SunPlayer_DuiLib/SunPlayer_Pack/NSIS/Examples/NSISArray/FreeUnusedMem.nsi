!include MUI.nsh
!include NSISArray.nsh

Name 'FreeUnusedMem'
OutFile 'NSISArrayExample - FreeUnusedMem.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 32 64
${ArrayObj} .
${ArrayFunc} FreeUnusedMem
${ArrayFunc} WriteList
${ArrayFunc} SizeOf

Section

  ${TestArray.Init}

  ${TestArray.WriteList} "'zero' 'one' 'two' 'three' '1' '2' '3'"
  DetailPrint 'TestArray = [zero, one, two, three, 1, 2, 3]'
  DetailPrint "The dimensions are x: 32, y: 64"
  DetailPrint ""
  Sleep 3000

  ${TestArray.SizeOf} $R0 $R1 $R2
  DetailPrint "TestArray contains $R0 items."
  DetailPrint "TestArray has $R1 item slots allocated for use."
  DetailPrint "TestArray has strings of $R2 in length."
  DetailPrint ""
  IntOp $R0 $R1 * $R2
  DetailPrint "That's a total of $R0 Bytes!!"
  DetailPrint ""
  Sleep 3000

  DetailPrint "Freeing unused memory with 'FreeUnusedMem'..."
  DetailPrint ""
  ${TestArray.FreeUnusedMem}
  ${TestArray.SizeOf} $R0 $R1 $R2
  DetailPrint "TestArray still contains $R0 items."
  DetailPrint "TestArray now has $R1 item slots allocated for use."
  DetailPrint "TestArray has strings of $R2 in length."
  DetailPrint ""
  IntOp $R0 $R1 * $R2
  DetailPrint "That's a total of $R0 Bytes!!"

  ${TestArray.Delete}

SectionEnd