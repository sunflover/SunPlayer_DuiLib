!include MUI.nsh
!include NSISArray.nsh

Name 'ReadFirst, ReadNext, ReadClose'
OutFile 'NSISArrayExample - ReadFirst Etc.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

${Array} TestArray 4 5
${ArrayFunc} WriteList
${ArrayFunc} ReadFirst
${ArrayFunc} ReadNext
${ArrayFunc} ReadClose

Section

 ${TestArray->Init}

 ${TestArray->WriteList} '"blah" "ja" "haha" "meh"'
 DetailPrint 'TestArray = [blah, ja, haha, meh]'
  DetailPrint ""
 Sleep 3000

 ClearErrors
 ${TestArray->ReadFirst} $R0 $R1
 Loop:
 IfErrors Done
  DetailPrint $R1
  ClearErrors
  ${TestArray->ReadNext} $R0 $R1
 Goto Loop
 Done:
 ${TestArray->ReadClose} $R0

 ${TestArray->Delete}

SectionEnd