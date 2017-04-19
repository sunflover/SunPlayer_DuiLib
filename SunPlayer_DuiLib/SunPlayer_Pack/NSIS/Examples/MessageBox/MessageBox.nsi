!define VERSION "v0.98 beta 3"
Name "Customisable Messagebox plug-in test ${VERSION}"
;!define SILENT

!ifdef SILENT
OutFile "messagebox_s.exe"
SilentInstall "Silent"
!else
OutFile "messagebox.exe"
!endif
ShowInstDetails show
InstProgressFlags smooth

Section
# parameters follow the following order:  hwnd #buttons mode module icon_id text caption [but_texts...]
# if the #buttons is set to zero it will force a one button case!

	# show example of the button width changes
	messagebox::show MB_DEFBUTTON4|MB_TOPMOST "testing is fun" \
	"0,103" \	
	"andforthespecialoptions...andforthespecial...MB_ABORTRETRYIGNORE|MB_TOPMOSTif you can...? if you can...? dghfd tyde trd fgdhg gfddrteyteigkjg$\n" \
	"la la la la la la la w$\nwwwwwwwww! wwwwwwwwww" "asdasd!" IDYES IDNO
;"shell32.dll,24"

	Pop $0
	DetailPrint "messagebox call 1 returned... $0"	

	# shows a NSIS
	MessageBox MB_OK "A normal NSIS MessageBox to show how the captions match with a normal or silent installer." ; this one puts a ' inside a string

	messagebox::show MB_SETFOREGROUND|MB_ICONHAND|MB_DEFBUTTON3 "" "" \
	"Are you sure you want to?$\nOh well if you're sure... altered button text$\n" \
 	IDYES "Yes to all" IDNO "No to all"
	Pop $0
	DetailPrint "messagebox call 2 returned... $0"

	loop:
	messagebox::show MB_ICONHAND|MB_DEFBUTTON2 "" "" \ 
	"and for the special options...$\n" "IDYES" "m12if you can!"

	; need to get return mapping sorted out
	Pop $0
	DetailPrint "messagebox call 3 returned... $0"
	StrCmp $0 "3" loop
	StrCmp $0 "4" loop

	# illeagal to have two of the same! Only the first will be shown
	messagebox::show MB_ICONEXCLAMATION|MB_ICONHAND|MB_TOPMOST|MB_DEFBUTTON2|MB_RIGHT "look at me a title" \
	"0,103" \
	"and for a messagebox that will show an icon... :o)$\n" IDYES "ah go on if you dare" IDYES

	Pop $0
	DetailPrint "messagebox call 4 returned... $0"

	# n0On3's example
	messagebox::show MB_ICONQUESTION "can't move, copy instead?" "" \
	"We can't move through different drives.$\nBut we can copy and delete if no errors" \
 	"Copy && Delete" "Copy" IDCANCEL

SectionEnd