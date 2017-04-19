NsScreenshot plug-in
nsScreenshot is a NSIS-plugin created by Leon Zandman that can create a screenshot and save it to a Windows bitmap (BMP) file. 

Usage :

1.Full-screen capture 
	; Put filename of screenshot onto stack
	Push "c:\fullscreen.bmp"
	 
	; Capture full screen
	nsScreenshot::Grab_FullScreen
	
	Pop $1
	; $1 contains "ok" if the screenshot was taken
	; $1 contains "error" if something went wrong
	 
	StrCmp $1 "ok" ok1 0
	DetailPrint "nsScreenshot error"
	Goto next1
	ok1:
	; Get image dimensions from stack (only available when "ok")
	Pop $R1
	Pop $R2
	DetailPrint "nsScreenshot OK"
	DetailPrint "Dimensions:  ($R1x$R2)"
	next1:

2.Capturing a specific window
	; Put window handle of window to be captured
	; onto stack. You can use FindWindow for this.
	; We'll use the NSIS window in this example
	Push $HWNDPARENT
	 
	; Put filename of screenshot onto stack
	Push "c:\screenshot.bmp"
	 
	; Capture window
	nsScreenshot::Grab
	
	Pop $1
	; $1 contains "ok" if the screenshot was taken
	; $1 contains "error" if something went wrong
	 
	StrCmp $1 "ok" ok1 0
	DetailPrint "nsScreenshot error"
	Goto next1
	ok1:
	; Get image dimensions from stack (only available when "ok")
	Pop $R1
	Pop $R2
	DetailPrint "nsScreenshot OK"
	DetailPrint "Dimensions:  ($R1x$R2)"
	next1:

Important Note :
nsScreenshot always captures the full screen. For capturing a specific window it will determine the rectangle occupied by that window and crop it out of the full screen picture, thus resulting in a screenshot of only that specific window. This means that the window to be captured has to be visible and on top when capturing! 