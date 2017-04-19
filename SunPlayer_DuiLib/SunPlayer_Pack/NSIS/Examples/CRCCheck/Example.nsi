; Example.nsi
;
; This script is a quick demonstration of how to use CRCCheck.
;
;--------------------------------

Name "CRCCheck Example"

OutFile "CRCCheck Test.exe"

XPStyle on

;--------------------------------

Page instfiles

;--------------------------------

Section ""

  SetAutoClose true

  ; Get a CRC from Windows Explorer
  CRCCheck::GenCRC "$WINDIR\explorer.exe"
  Pop $R1

  ; And show it...
  MessageBox MB_OK "Windows Explorer CRC: $R1"
  
SectionEnd
