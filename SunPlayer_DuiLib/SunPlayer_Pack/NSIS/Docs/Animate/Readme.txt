animate.dll - plug-in that lets you throw up a splash/slide/roll screen in NSIS installers. 

Usage:

1)   animate::show /NOUNLOAD [/ATIME=xx] [/FLAGS=XX] [/X=xx] [/Y=xx] [/SFG] [/COLOR=0xRRGGBB] [/NOCANCEL] [/BORDER] FileName

Exit strings: OK, error (could not load image)

ATIME    - animation time (milliseconds), default 1 sec
FLAGS    - animate mode, default blend, see *.nsi samples for possible values, default AW_BLEND
X        - gap from desktop workarea borders. From right border if <0,
           from left border otherwise. Default - workarea center.
Y        - the same as X for vertical placement
SFG      - tries to set parent window foreground on exit
NOCANCEL - not close window on left mouse click
BORDER   - create window border
COLOR    - window background color for transparent gif's
FileName - image filename (with extension), bmp, gif and jpg supported.

2)  animate::wait [/ATIME=xx] [/FLAGS=XX] [/SFG] [/NOCANCEL | /IFNC] TIME_MS

IFNC - sets ATIME to 0 if banner was clicked before this (clears NOCANCEL flag)

Some options can be re-defined in this call
Exit reason: click, wait, error (thread not exists), terminate

Is safe even if "show" returned "error"
 
3) animate::hwnd

Returns banner window handle for using with other plug-ins (marquee, animgif).

Remarks:
After 'show' animation was finished and plug-in returned control to installer,
user can close window with left mouse button click if /NOCANCEL option not set.
In "wait" call plug-in starts animation immediately if TIME_MS is 0 or /IFNC set
and user already clicked banner (but it was not closed before this because if 
/NOCANCEL option). If not of these happened plug-in continues displaying banner 
for TIME_MS time or less depending on /NOCANCEL option in any of 'show' or 'wait' 
calls. Any case banner will be closed after "wait" time expired.

For example:

Desktop center 1 sec fade in (blend) and 1 sec fade out (default ATIMEs)
	animate::show /NOUNLOAD /NOCANCEL animate.gif
	Pop $0
; you can add installer initializatioon code here - baner locked with NOCANCEL option
; now plug-in can immediately handle user click (if any) with IFNC option or wait 1 sec
	animate::wait /IFNC 1000
	Pop $1

Bottom right corner rising slide 2 sec, show 1 sec, slide out 2 sec
User can close window without animation during 1 sec (left mouse button click)
	IntOp $R0 ${AW_VER_NEGATIVE} | ${AW_SLIDE}
	animate::show /NOUNLOAD /ATIME=2000 /FLAGS=$R0 /X=-10 /Y=-10 animate.gif
	Pop $0
	animate::wait 1000
	Pop $1


Pre-defined flags for 2-dimentional slide/roll from zeeh3:

!define ROLL_LEFT_TO_RIGHT    0x20001
!define ROLL_RIGHT_TO_LEFT    0x20002
!define ROLL_TOP_TO_BOTTOM    0x20004
!define ROLL_BOTTOM_TO_TOP    0x20008
!define ROLL_DIAG_TL_TO_BR    0x20005
!define ROLL_DIAG_TR_TO_BL    0x20006
!define ROLL_DIAG_BL_TO_TR    0x20009
!define ROLL_DIAG_BR_TO_TL    0x2000a
!define SLIDE_LEFT_TO_RIGHT   0x40001
!define SLIDE_RIGHT_TO_LEFT   0x40002
!define SLIDE_TOP_TO_BOTTOM   0x40004
!define SLIDE_BOTTOM_TO_TOP   0x40008
!define SLIDE_DIAG_TL_TO_BR   0x40005
!define SLIDE_DIAG_TR_TO_BL   0x40006
!define SLIDE_DIAG_BL_TO_TR   0x40009
!define SLIDE_DIAG_BR_TO_TL   0x4000a

Compatibility: Win98+, Win2k+
Patch for NT 4.0 - no animation, but displays window


Takhir Bedertdinov
