;--------------------------------
; General Attributes

Name "EmbeddedBanner plug-in test"
OutFile "EBanner.exe"


;--------------------------------
;Interface Settings

!include "MUI.nsh"
; To reduce package size, 70 bytes 2x2 placeholder
!define MUI_WELCOMEFINISHPAGE_BITMAP plholder.bmp
!define MUI_PAGE_CUSTOMFUNCTION_PRE pre
!define MUI_PAGE_CUSTOMFUNCTION_SHOW show
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE leave
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"


Function pre
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 1" "Text" ""
Functionend

Function show
  ebanner::show /NOUNLOAD /HALIGN=LEFT /FIT=HEIGHT "$EXEDIR\wizard.jpg"
FunctionEnd

Function leave
  ebanner::stop
FunctionEnd

Section

#        ebanner::play /NOUNLOAD /LOOP "$EXEDIR\New Stories.wma"
        Sleep 500
        ebanner::show /NOUNLOAD "$EXEDIR\orange.jpg"
        Sleep 1000
        ebanner::show /NOUNLOAD /FIT=BOTH "${NSISDIR}\Contrib\Graphics\Header\orange.bmp"
        Sleep 1000
        ebanner::show /NOUNLOAD /HALIGN=RIGHT "${NSISDIR}\Contrib\Graphics\Wizard\orange.bmp"
        Sleep 1000
        ebanner::show /NOUNLOAD "" ; cleares image but not stops sound
        Sleep 500
        ebanner::show /NOUNLOAD "$EXEDIR\catch.png"
        Sleep 1000
        ebanner::stop     ; terminates all
        Sleep 500

SectionEnd
