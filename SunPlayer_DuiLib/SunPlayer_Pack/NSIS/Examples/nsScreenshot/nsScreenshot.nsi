Name "nsScreenshot Test"

OutFile "nsScreenshot Test.exe"

ShowInstDetails show

Section "Make Screenshot"
        DetailPrint "nsScreenshot example by Leon Zandman"
        DetailPrint "------------------------------------"
        
        ; ----------- Full-screen screenshot ----------------

        ; Put filename of screenshot onto stack
        StrCpy $0 "$EXEDIR\Fullscreen_Screenshot.bmp"
        Push $0

	; Capture full screen
        nsScreenshot::Grab_FullScreen

        ; $1 contains "ok" if the screenshot was taken
        ; $1 contains "error" if something went wrong
        Pop $1
        StrCmp $1 "ok" ok1 0
        DetailPrint "FullScreen screenshot error"
        Goto next1
ok1:
        ; Pop image dimensions from stack (only available when plugin returned "ok")
        Pop $R1
        Pop $R2
        DetailPrint "Fullscreen screenshot saved as: $0"
        DetailPrint "  Dimensions:  ($R1x$R2)"
next1:
        ; ----------- NSIS window screenshot ----------------

        ; Put window handle of NSIS screen onto stack
        Push $HWNDPARENT
        ; Put filename of screenshot onto stack
        StrCpy $0 "$EXEDIR\NSIS_Screenshot.bmp"
        Push $0

        ; Capture NSIS window
        nsScreenshot::Grab

        Pop $1
        ; $1 contains "ok" if the screenshot was taken
        ; $1 contains "error" if something went wrong
        StrCmp $1 "ok" ok2 0
        DetailPrint "NSIS screenshot error"
        Goto next2
ok2:
        ; Pop image dimensions from stack (only available when plugin returned "ok")
        Pop $R1
        Pop $R2
        DetailPrint "NSIS screenshot saved as: $0"
        DetailPrint "  Dimensions:  ($R1x$R2)"
next2:
        ; ----------- Taskbar screenshot ----------------

        ; Put window handle of taskbar window onto stack
        FindWindow $R0 "Shell_TrayWnd"
        Push $R0

        ; Put filename of screenshot onto stack
        StrCpy $0 "$EXEDIR\Taskbar_Screenshot.bmp"
        Push $0

	; Capture Taskbar window
	nsScreenshot::Grab

        Pop $1
        ; $1 contains "ok" if the screenshot was taken
        ; $1 contains "error" if something went wrong
        StrCmp $1 "ok" ok3 0
        DetailPrint "System Tray screenshot error"
        Goto next3
ok3:
        ; Pop image dimensions from stack (only available when plugin returned "ok")
        Pop $R1
        Pop $R2
        DetailPrint "Taskbar screenshot saved as: $0"
        DetailPrint "  Dimensions:  ($R1x$R2)"
next3:
        ; ----------- Tray screenshot ----------------

        ; Put window handle of taskbar window onto stack
        ; Notice the second call to FindWindow, needed because it's a child window
        FindWindow $R0 "Shell_TrayWnd"
        FindWindow $R0 "TrayNotifyWnd" "" $R0
        Push $R0

        ; Put filename of screenshot onto stack
        StrCpy $0 "$EXEDIR\Tray_Screenshot.bmp"
        Push $0

	; Capture Taskbar window
	nsScreenshot::Grab

        Pop $1
        ; $1 contains "ok" if the screenshot was taken
        ; $1 contains "error" if something went wrong
        StrCmp $1 "ok" ok4 0
        DetailPrint "Tray screenshot error"
        Goto next4
ok4:
        ; Pop image dimensions from stack (only available when plugin returned "ok")
        Pop $R1
        Pop $R2
        DetailPrint "Tray screenshot saved as: $0"
        DetailPrint "  Dimensions:  ($R1x$R2)"
next4:

SectionEnd
