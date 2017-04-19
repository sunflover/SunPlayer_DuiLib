!include MUI.nsh
!include NSISArray.nsh

Name 'Clear'
OutFile 'NSISArrayExample - Splice.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 4 6
${ArrayFunc} WriteList
${ArrayFunc} Debug
${ArrayFunc} Splice

Section

  ${TestArray->Init}

  ${TestArray->WriteList} "'zero' 'one' 'two' 'three' 'four'"
  DetailPrint 'TestArray = [zero, one, two, three, four]'
  ${TestArray->Debug}
  Sleep 3000

  DetailPrint ""
  DetailPrint "Splicing 3 items"
  DetailPrint "   from indexes 0, 1, 2 (0-2)."
  DetailPrint "Replacing them with:"
  DetailPrint '[meh!, ja, meh!, ja, meh!, ja]'
  ${TestArray->Splice} 0 2 "'meh!' 'ja' 'meh!' 'ja' 'meh!' 'ja'"
  DetailPrint ""
  DetailPrint "Now viewing spliced version..."
  ${TestArray->Debug}
  Sleep 3000

  DetailPrint ""
  DetailPrint "Splicing 2 items"
  DetailPrint "   from indexes 3, 4 (3-4)."
  DetailPrint "Replacing them with:"
  DetailPrint '[boo.]'
  ${TestArray->Splice} 3 4 "'boo.'"
  DetailPrint ""
  DetailPrint "Now viewing spliced version..."
  ${TestArray->Debug}
  Sleep 3000

  DetailPrint ""
  DetailPrint "Splicing 2 items"
  DetailPrint "   from indexes 4, -1 (4-5)."
  DetailPrint "Replacing them with:"
  DetailPrint '[hello!]'
  ${TestArray->Splice} 4 -1 "'hello'"
  DetailPrint ""
  DetailPrint "Now viewing spliced version..."
  ${TestArray->Debug}

  ${TestArray->Delete}

SectionEnd