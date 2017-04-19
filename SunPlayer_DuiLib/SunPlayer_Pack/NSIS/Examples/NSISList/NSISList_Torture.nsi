;-----------------------------------------------------------------------------------
; Torture test for NSISList Plugin
;-----------------------------------------------------------------------------------

!include NSISList.nsh
ReserveFile "${NSISDIR}\Plugins\NSISList.dll"

Name "NSISList_Torture"
OutFile "NSISList_Torture.exe"

ChangeUI all "${NSISDIR}\Contrib\UIs\modern.exe"
ShowInstDetails show

Section
  System::Call "kernel32::GetCurrentProcess() i.r0"
  System::Call "kernel32::SetPriorityClass(i r0, i 128)"

  DetailPrint "THIS TEST WILL TAKE TIME, BE PATIENT !!!"

  SetDetailsPrint listonly
  DetailPrint "* Torture: Create 100 lists and add 10.000 items to each list"
  DetailPrint "* The test took about ~30 minutes on my Core2 Quad Q6600 machine"
  DetailPrint "* Kill the process in Taskmanager, if you don't want to wait..."
  SetDetailsPrint both

  Sleep 5000

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------
  
  StrCpy $0 0
  
  Loop:
    DetailPrint "Creating List: MyList_$0"
    ${List.Create} "MyList_$0"
    StrCpy $1 0

    Loop2:
      ${List.Add} "MyList_$0" "This is item #$1 of MyList_$0"
      IntOp $1 $1 + 1
      StrCmp $1 10000 0 Loop2

    IntOp $0 $0 + 1
    StrCmp $0 100 0 Loop

  ;-----------------------------------

  StrCpy $0 0

  Loop3:
    DetailPrint "----------------------"
    DetailPrint "Reading List: MyList_$0"

    Loop4:
      ${List.Pop} $1 "MyList_$0"
      DetailPrint "$1"
      StrCmp $1 "__ERROR" +2
      StrCmp $1 "__EMPTY" 0 Loop4

    ${List.Destroy} "MyList_$0"
    IntOp $0 $0 + 1
    StrCmp $0 100 0 Loop3

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "All tests done, unload plugin now..."
  ${List.Unload}
SectionEnd
