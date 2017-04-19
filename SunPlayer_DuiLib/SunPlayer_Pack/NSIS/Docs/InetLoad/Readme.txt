 Copyright © 2006 Takhir Bedertdinov ineum@narod.ru

 Permission to use, copy, modify, distribute and sell this software or any part
 thereof and/or its documentation for any purpose is granted without fee provided
 that the above copyright notice and this permission notice appear in all
 copies.

 This software is provided "as is" without express or implied warranty of any kind.
 The author shall have no liability with respect to the infringement of copyrights 
 or patents that any modification to the content of this file or this file itself 
 may incur.


 MS WinInet API based plug-in for http and ftp downloads with improved proxy 
 (compare to NSISdl). Command line may include few URL/File pairs to be downloaded. 
 Plug-in supports 3 "download in progress" display modes: 1) old NSISdl style - 
 additional embedded progress bar and text on the INSTFILES page; 2) POPUP dialog 
 mode with detailed info; 3) BANNER mode with simple popup window. Plug-in recognizes 
 Installer' Silent mode and this case hides any output. Program implements simple 
 re-get functionality - host reconnect and download from current position after short 
 pause. NSISdl code fragment was used for progress bar displaying in the "old style" mode. 

 Requires NSIS 2.03 or later


Command line parameters (NSIS script):

  InetLoad::load [/PROXY IP:PORT] [/USERNAME PROXY_LOGIN /PASSWORD PROXY_PASSWD] [/NOPROXY] [/NOCANCEL] [/POST TEXT2POST] [/TIMEOUT INT_MS] [/SILENT TEXT2DISPLAY] [/RESUME RETRY_QUESTION] [/POPUP PREFIX | /BANNER CAPTION TEXT] [/TRANSLATE LANG_PARAMS] URL1 local_file1 [URL2 local_file2 [...]] [/END]

/PROXY    overwrites current proxy settings, not required in most cases, IE
          registry settings will be used by default

/USERNAME proxy username (http only).

/PASSWORD proxy password (http only).  For server (http/ftp) authentication it is possible
          to use URL encoded name and password, for example http://username:password@nsis.sourceforge.net

/NOPROXY  disables proxy settings for this connection (if any)

/NOCANCEL prevents download from being interupted by user (locks Esc, Alt-F4, Cancel handling)

/POST     text string to be used in the POST (http only). Disables auto re-get. No char replaces used (%20 and others).

/TIMEOUT sets INTERNET_OPTION_CONNECT_TIMEOUT, milliseconds, default - IE current parameter value 

/SILENT hides plug-in' output (both popup dialog and embedded progress bar)
        Sets TEXT2DISPLAY to 1006 control, if /silent "" - displays "InetLoad plug-in" default.
        Not required if installer is running in the 'silent' mode.

/RESUME on the permanent connection/transfer error instead of exit first displays 
        message box with "resume download" question. Usefull for dial-up connections and
        big files - allows user to restore connection and resume download. Default is
        "Your internet connection seems to have dropped out!\nPlease reconnect and click Retry to resume downloading..."

/POPUP  displays detailed download dialog instead of embedded progress bar.
        Useful in .onInit function (i.e. not in Section). Sets caption prefix 
        (text before "-"), "InetLoad plug-in" is a default if "" was used.

/BANNER displays simple popup dialog (MSI Banner mode) and sets dialog CAPTION 
        ("InetLoad plug-in" is a default for "" parameter) and TEXT (no default).

/END    allows to limit plug-in stack reading (optional, required if you stores other 
        vars in the stack) 

/TRANSLATE allows to translate dialog labels in the POPUP or NSISdl (old style) modes. 8 parameters both cases.

For NSISdl mode:
  /TRANSLATE downloading connecting second minute hour plural progress remaining
Default values are:
  "Downloading %s" "Connecting ..." second minute hour s "%dkB (%d%%) of %dkB @ %d.%01dkB/s" "(%d %s%s remaining)"

For POPUP mode:
  /TRANSLATE url downloading connecting file_name received file_size remaining_time total_time
Default is english:
  URL Downloading Connecting "File Name" Received "File Size" "Remaining Time" "Total Time"

For example:

  InetLoad::load "http://dl.zvuki.ru/6306/mp3/12.mp3" "$EXEDIR\12.mp3" "ftp://dl.zvuki.ru/6306/mp3/11.mp3" "$EXEDIR\11.mp3"

or

  InetLoad::load /BANNER "" "Cameron Diaz download in progress, please wait ;)" "http://www.dreamgirlswallpaper.co.uk/fiveyearsonline/wallpaper/Cameron_Diaz/camerond09big.JPG" "$EXEDIR\cd.jpg"

Return value is "OK" string if successful, error description 
string if failed (see InetLoad.cpp file for a full set of status 
strings). Result processing may be following:

  Pop $0
  StrCmp $0 "OK" dlok
  MessageBox MB_OK|MB_ICONEXCLAMATION "Download Error, click OK to abort installation" /SD IDOK
  Abort
dlok:
  ...

Takhir Bedertdinov, Moscow, Russia
ineum@narod.ru
