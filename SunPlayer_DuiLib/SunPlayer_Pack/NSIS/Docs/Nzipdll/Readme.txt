

Features unzip plugin (Nzipdll.dll):
 - shows small "banner" with progress bar, percent text or files extracted text
 - cancel unzip process (right click dialog menu)
 - left click the dialog to drag it a round

   Ussage: Nzipdll::nzip [DIALOG] [ZIP_FILE] [UOTPUT_DIR]

   DIALOG:
     /PERCENT
     /FILES
     /PROGBAR

   Example: Nzipdll::nzip /PROGBAR "$PLUGINSDIR\Myzip.zip" "$INSTDIR\data"


Features NSIS console plugin:
 - shows a console window with makensis output
 - left click dialog to drag it a round

   Ussage: Nmwdll::nmwMakensis [MAKENSIS_EXE_PATH] [MAKENSIS_PARAMETERS] [NSI_FILE]

   Example: Nmwdll::nmwMakensi "${NSISDIR}\makensis.exe" "/V3" "${NSISDIR}\Examples\bigtest.nsi"


Features "wiz" plugin:
 - shows small "banner" with progress in percents
 - cancel unzip process (right click dialog menu)
 - left click the dialog to drag it a round

   Ussage: Nzwdll::nzwUnzip [ZIP_FILE] [UOTPUT_DIR]

 - shows a console window with makensis output
 - left click dialog to drag it a round

   Ussage: Nzwdll::nzwMakensis [MAKENSIS_EXE_PATH] [MAKENSIS_PARAMETERS] [NSI_FILE]