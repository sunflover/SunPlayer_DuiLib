!AddPluginDir .
Name "EmbeddedBanner"
OutFile "EBanner.exe"

!include "MUI2.nsh"
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "SimpChinese"

ShowInstDetails nevershow

Section
    EBanner::show /NOUNLOAD "$PLUGINSDIR\Data_6.png"
    Sleep 1500
    EBanner::show /NOUNLOAD "$PLUGINSDIR\Data_7.png"
    Sleep 1500
    EBanner::show /NOUNLOAD "$PLUGINSDIR\Data_8.png"
    Sleep 1500
    EBanner::show /NOUNLOAD "$PLUGINSDIR\Data_9.png"
    Sleep 1500
    EBanner::stop
SectionEnd

Function .onInit
    InitPluginsDir
    SetOutPath $PLUGINSDIR
    File ".\Data_*.png"
FunctionEnd