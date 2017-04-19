Marquee plug-in

Description :
Result looks like marquee tag on the html page, scrolling text. Some animation on the INSTFILES page during long installs may be useful (but this is applicable to other pages as well, for example as a help text near some controls), attached plug-in is one of possible ways. Text length to be displayed may be big enough, limited by NSIS 'stringsize' parameter, 1024 and 8096 bytes for common and special NSIS builds. 20 parameters allow to define text, position, border, colors, font and scroll. The only big limitation I see now - horizontal scroll only (both directions). Extended functionality (compare to html tag) - bi-directional movement (/swing). 


Syntax :
 plug-in entry points: Marquee::start and Marquee::stop
 start parameters are decimal values (except face  and start string, and colors is hex):
 /FACE=FontFace  - typeface name of font, default Times
 /COLOR=XXXXXX - font color, hex value RGB, FF0000 is red, default - current system color.
 /HEIGHT=xxx - height, in logical units, of the font's character cell or character, default 18
 /WIDTH=xxx - average char width, in logical units, set -1 to use current system font, default 10
 /WEIGHT=xxx - weight of the font in the range 0 through 1000, default 600 (FW_SEMIBOLD, WINGDI.H)
 /CHARSET=xxx - character set value, default 0 (ANSI_CHARSET, WINGDI.H)
 /ITALIC - italic font, default no
 /UNDERLINE - underlined font, defalt no
 /SCROLLS=x - number of text scrolls, set 1 for once, default is 0 (non-stop)
 /STEP=x - text movement step, negative for left2right, high value -> faster scroll, default 1 (pixel). /step=0 sets /start=CENTER
 /INTERVAL=xx - text movement interval (between jumps), low value -> faster scroll, default 20 (milliseconds)
 /LEFT=x - additional left spacer, percents of the dialog width, default 0 (%)
 /RIGHT=x - additional right spacer, percents of the dialog width, default is 0 (%)
 /TOP=xx - text top, percents of the dialog client area height, default 60 (%)
 /BORDER=x - displays x pixel(s) border rectangle
 /SPACER=x - x pixels spacer between text clipping rect and border, 0 if border not set, default 1
 /BCOL=xxxxxx - border color, default is text color
 /GCOL=xxxxxx - background color, default is drawing rect left top point color
 /HWND=x - window handle to paint on. Default is current installer page.
 /SWING - bi-directional movement
 /START={RIGHT|LEFT|CENTER} - start position inside rectangle (for /step=0 mainly). Default position is outside paint rectangle
 "text to display" - max length 1024 or 8096 (special NSIS build).