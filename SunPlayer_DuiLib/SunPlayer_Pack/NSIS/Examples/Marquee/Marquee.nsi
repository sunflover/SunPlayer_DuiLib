
;--------------------------------
; General Attributes

!define APP_NAME Marquee
!define DUMMY_FILE Example.nsi

Name "${APP_NAME} Test"
OutFile "${APP_NAME}.exe"


;--------------------------------
;Interface Settings

  !include "MUI.nsh"
  !insertmacro MUI_PAGE_INSTFILES
;  !insertmacro MUI_PAGE_FINISH
  !insertmacro MUI_LANGUAGE "English"


;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy
; plug-in entry points: Marquee::start and Marquee::stop
; start parameters are decimal values (except face  and start string, and colors is hex):
; /FACE=FontFace  - typeface name of font, default Times
; /COLOR=XXXXXX - font color, hex value RGB, FF0000 is red, default - current system color.
; /HEIGHT=xxx - height, in logical units, of the font's character cell or character, default 18
; /WIDTH=xxx - average char width, in logical units, set -1 to use current system font, default 10
; /WEIGHT=xxx - weight of the font in the range 0 through 1000, default 600 (FW_SEMIBOLD, WINGDI.H)
; /CHARSET=xxx - character set value, default 0 (ANSI_CHARSET, WINGDI.H)
; /ITALIC - italic font, default no
; /UNDERLINE - underlined font, defalt no
; /SCROLLS=x - number of text scrolls, set 1 for once, default is 0 (non-stop)
; /STEP=x - text movement step, negative for left2right, high value -> faster scroll, default 1 (pixel). /step=0 sets /start=CENTER
; /INTERVAL=xx - text movement interval (between jumps), low value -> faster scroll, default 20 (milliseconds)
; /LEFT=x - additional left spacer, percents of the dialog width, default 0 (%)
; /RIGHT=x - additional right spacer, percents of the dialog width, default is 0 (%)
; /TOP=xx - text top, percents of the dialog client area height, default 60 (%)
; /BORDER=x - displays x pixel(s) border rectangle
; /SPACER=x - x pixels spacer between text clipping rect and border, 0 if border not set, default 1
; /BCOL=xxxxxx - border color, default is text color
; /GCOL=xxxxxx - background color, default is drawing rect left top point color
; /HWND=x - window handle to paint on. Default is current installer page.
; /SWING - bi-directional movement
; /START={RIGHT|LEFT|CENTER} - start position inside rectangle (for /step=0 mainly). Default position is outside paint rectangle
; "text to display" - max length 1024 or 8096 (special NSIS build).

   SetOutPath "$PLUGINSDIR"
; script between 'start' and 'stop' calls is for demo purposes only, not required in real installer.

   Marquee::start /NOUNLOAD /step=0 /interval=300 /top=70 /height=18 /width=12 "demo /start=center & /step=0"
   Sleep 1000
   File ${DUMMY_FILE}
   Sleep 1000
;   Marquee::stop ; optional if followed by start, calls 'stop' internally if still running on 'start'

   Marquee::start /NOUNLOAD /italic /underline /scrolls=1 /border=3 /gcol=0x00f000 /bcol=0xf00000 /spacer=2 /color=0x0000b0 /right=50 /step=-2 /top=100 /height=18 /width=14 "demo /scrolls=1 /step=-2"
   Sleep 2000
   File ${DUMMY_FILE}
   Sleep 3000
   File "/oname=${DUMMY_FILE}1" "${DUMMY_FILE}"
   Sleep 2000
   Marquee::stop

   Marquee::start /NOUNLOAD /face=Verdana /swing /step=3 /top=60 /weight=400 "Marquee plug-in swing demo"
   Sleep 2000
   Delete "$PLUGINSDIR\${DUMMY_FILE}"
   Sleep 2000
   File "/oname=${DUMMY_FILE}1" "${DUMMY_FILE}"
   Sleep 2000
   Sleep 2000
   Marquee::stop ; optional - auto-close on page destroy

   Delete "$PLUGINSDIR\${DUMMY_FILE}"
   Delete "$PLUGINSDIR\${DUMMY_FILE}1"
   Sleep 1000

SectionEnd

