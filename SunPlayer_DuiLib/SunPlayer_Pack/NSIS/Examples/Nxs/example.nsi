Name "example"
OutFile "example.exe"
AutoCloseWindow True
BGGradient 000000 000080 FFFFFF
InstallDir "$PROGRAMFILES\My Application"

!include "WinMessages.nsh"

Page directory
Page instfiles

Function .onInit
	nxs::Show /NOUNLOAD `$(^Name) Setup` /top `Setup installing something$\r$\nPlease wait...` /sub `$\r$\n$\r$\n Preparing...` /h 0 /pos 0 /max 100 /can 1 /end

        Sleep 1000 ; Delay to show Cancel button text before it will be changed to Quit
	nxs::getWindow /NOUNLOAD
	Pop $0                                        ; $0 now contains the handle to the dialog
	GetDlgItem $1 $0 2                            ; button=2; top=8; progress=10; sub=11; icon=12
	SendMessage $1 ${WM_SETTEXT} 1 "STR:&Quit"    ; Change button label &Cancel to &Quit
	StrCpy $1 -1

	sleep:
	IntOp $1 $1 + 1
	nxs::Update /NOUNLOAD /sub "$\r$\n$\r$\n $1% complite" /pos $1 /end
        Sleep $1

	nxs::HasUserAborted /NOUNLOAD
	Pop $0                                        ; $0 now contains "1" if user clicked Cancel or "0" otherwise.
	StrCmp $0 1 destroy
	StrCmp $1 100 0 sleep

	destroy:
	nxs::Destroy

;	MessageBox MB_OK "$1% complited"
	StrCmp $1 100 +2
	quit ;Aborts dialog if user clicked Quit
FunctionEnd

Function .onGUIInit
  ; plug-in requires this to be called in .onGUIInit
  ; if you use it in the .onInit function.
  ; If you leave it out the installer dialog will be minimized.
  ShowWindow $HWNDPARENT 2
FunctionEnd

Section
SectionEnd
