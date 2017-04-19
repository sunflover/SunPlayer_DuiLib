!include MUI.nsh
!include NSISArray.nsh

Name 'Clear'
OutFile 'NSISArrayExample - Clear.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} "TestArray" 4 6
${ArrayFunc} WriteList
${ArrayFunc} Shift
${ArrayFunc} Debug

Section

  ${TestArray->Init}

  ${TestArray->WriteList} "'zero' 'one' 'two' 'three'"
  DetailPrint 'TestArray = [zero, one, two, three]'
  DetailPrint ""
  ${TestArray->Debug}
  Sleep 3000

  DetailPrint "Testing 'Shift' with 'four'..."
  ${TestArray->Shift} 'four'
  DetailPrint ""
  DetailPrint "See debug window again..."
  ${TestArray->Debug}

  ${TestArray->Delete}

SectionEnd