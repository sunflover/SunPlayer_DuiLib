; CRCCheck Example
;
; 这个例子说明了如何使用CRCCheck.
;
;--------------------------------

Name "CRCCheck Example"
OutFile "CRCCheck Test.exe"
XPStyle on
Page instfiles

Section ""
  SetAutoClose true
  ; 获取Windows Explorer 的 CRC 值
  CRCCheck::GenCRC "$WINDIR\explorer.exe"
  Pop $R1
  MessageBox MB_OK "Windows Explorer CRC: $R1"
SectionEnd
