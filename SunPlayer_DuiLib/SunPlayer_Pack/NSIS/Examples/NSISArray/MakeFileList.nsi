!include MUI.nsh
!include NSISArray.nsh

#
# This NSISArray example script generates a list of files in the current folder.
# It then sorts them by their last modified times using the NSISArray Sort function.
#

Name 'MakeFileList'
OutFile 'NSISArrayExample - MakeFileList.exe'
ShowInstDetails show

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

## Create arrays
${Array} FileList 32 2
${ArrayFunc} Shift
${ArrayFunc} Debug
${ArrayFunc} SizeOf
${ArrayFunc} ReadFirst
${ArrayFunc} ReadNext
${ArrayFunc} ReadClose
${Array} FileTimes 32 2
${ArrayFunc} Sort
${ArrayFunc} Shift

Section

 ## Initialise arrays
 ${FileList->Init}
 ${FileTimes->Init}

 ## Loop through the $EXEDIR directory
 ## Write files to FileList array
 ## Write file times to FileTimes array
 FindFirst $R0 $R1 "$EXEDIR\*.*"
 ClearErrors
 Loop:
  IfErrors Done
  StrCmp $R1 . Next
  StrCmp $R1 .. Next
   ${FileList->Shift}  $R1
   GetFileTime "$EXEDIR\$R1" $R1 $R2
   ${FileTimes->Shift} $R1$R2
  Next:
  ClearErrors
  FindNext $R0 $R1
 Goto Loop
 Done:
 FindClose $R0

 ## Show list of files in no order
 ${FileList->Debug}

 ## Sort file list by file times
 ${FileTimes->Sort} FileList

 ## Reverse the list?
 # ${FileList->Reverse}

 ## Display new list
 ${FileList->Debug}

 ## Loop through array, and write files to file in new order
 FileOpen $R0 "$EXEDIR\FileList.txt" w
 ClearErrors
 ${FileList->ReadFirst} $R1 $R2
 Loop2:
 IfErrors Done2
   FileWrite $R0 $R2$\r$\n
  ClearErrors
  ${FileList->ReadNext} $R1 $R2
 Goto Loop2
 Done2:
 ${FileList->ReadClose} $R1
 FileClose $R0

 ## Open the list
 ExecShell open "$EXEDIR\FileList.txt"

 ## Delete arrays from memory now that we're done
 ${FileList->Delete}
 ${FileTimes->Delete}

SectionEnd