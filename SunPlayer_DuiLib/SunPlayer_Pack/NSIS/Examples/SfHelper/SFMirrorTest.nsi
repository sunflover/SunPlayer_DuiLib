
;--------------------------------
; General Attributes

Name "SF helper test"
OutFile "SFMirrorTest.exe"
ShowInstDetails show


;--------------------------------
;Interface Settings

  !include "MUI.nsh"
  !define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install-colorful.ico"
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_LANGUAGE "English"


!include "StrFunc.nsh"
${StrTok}

;--------------------------------
;Installer Sections

var mirrorList
var count
var mirrorHost

Section "Dummy Section" SecDummy

    ; use your own URL and file
    detailprint "downloading mirrorlist"
    inetc::get /popup "mirror list download" "http://prdownloads.sourceforge.net/devkitpro/libgba-20060410.tar.bz2?download" "$EXEDIR\mirrorlist.html"

    ; checkFile parses the downloaded file for the html header which indicates
    ; a file was not found on the SF mirror
    sfhelper::checkFile $EXEDIR\mirrorlist.html
    pop $0

    ; since we used the prdownloads URL to obtain a mirror list this will show an error
    detailprint $0
    detailprint "Parsing mirrors"

    ; getMirrors returns a string consisting of the hostnames delimited by |
    sfhelper::getMirrors $EXEDIR\mirrorlist.html
    pop $mirrorList

    strcpy $count 0
listMirrors:
    ${StrTok} $mirrorHost $mirrorList "|" $count 0
    StrCmp $mirrorHost "" end +1
    
    detailprint "http://$MirrorHost.dl.sourceforge.net"
    Intop $count $count + 1
    goto listMirrors
    
end:

SectionEnd

