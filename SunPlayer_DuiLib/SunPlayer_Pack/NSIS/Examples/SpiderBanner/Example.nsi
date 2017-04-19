Name "Example"
OutFile "SpiderBannerExample.exe"

!include "MUI.nsh"

!insertmacro MUI_PAGE_WELCOME
Page Custom PagePre PageLeave
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

;BgGradient 008080 008080 FFFFFF
ShowInstDetails Show
ShowUnInstDetails Show

XPStyle on

Function .OnInit
  InitPluginsDir
  File /oname=$PLUGINSDIR\page.ini "Page.ini"
FunctionEnd

Function PagePre
  !insertmacro MUI_HEADER_TEXT "Options" "Please select the options you want."
  !insertmacro MUI_INSTALLOPTIONS_DISPLAY "page.ini"
FunctionEnd

Function PageLeave
  ReadINIStr $R0 "$PLUGINSDIR\page.ini" "Field 2" "State"
  StrCmp $R0 1 +1 +3
  StrCpy $R0 "/TL"
  GoTo next
  ReadINIStr $R0 "$PLUGINSDIR\page.ini" "Field 3" "State"
  StrCmp $R0 1 +1 +3
  StrCpy $R0 "/TR"
  GoTo next
  ReadINIStr $R0 "$PLUGINSDIR\page.ini" "Field 4" "State"
  StrCmp $R0 1 +1 +3
  StrCpy $R0 "/BL"
  GoTo next
  ReadINIStr $R0 "$PLUGINSDIR\page.ini" "Field 5" "State"
  StrCmp $R0 1 +1 +3
  StrCpy $R0 "/BR"
  GoTo next
  ReadINIStr $R0 "$PLUGINSDIR\page.ini" "Field 6" "State"
  StrCmp $R0 1 +1 +2
  StrCpy $R0 "/CENTER"

next:

  ReadINIStr $R1 "$PLUGINSDIR\page.ini" "Field 7" "State"
FunctionEnd

Section
  SpiderBanner::Show /NOUNLOAD $R0 $R1
  DetailPrint "Waiting..."
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  DetailPrint "Hello World!"
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  DetailPrint "This is a demonstration."
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  DetailPrint "This is one stupidly, crazy, over the top, once in a blue moon, insanely long detail text that should never have been written into this installer."
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  Sleep 100
  DetailPrint "Now we are finished."
  Sleep 1000
  SpiderBanner::Destroy
  SetAutoClose True
SectionEnd