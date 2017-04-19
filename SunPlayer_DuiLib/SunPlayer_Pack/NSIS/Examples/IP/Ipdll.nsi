outfile IpTest.exe
name IpTest
 
; get_ip example
; by Hendri Adriaens
; HendriAdriaens@hotmail.com
;
; Usage:
; ip::get_ip
; Output: 'ip1;ip2;ip3;ip4;'
; (semi-colon delimited IP's list, on stack)
;
; Uses NSIS script to retrieve
; separate IP-addresses and to
; test whether or not it is an
; internet IP-address. Based on
; information by Joost Verburg:
;   These ranges are for local networks: 
;   10.x.x.x / 255.0.0.0 
;   172.16.x.x / 255.255.0.0 to 172.31.x.x / 255.255.0.0 
;   192.168.x.x / 255.255.255.0 
;   169.254.x.x / 255.255.0.0
; and:
;   169.254.x.x is an Automatic Private IP Address,
;   which you get when there is no DHCP server available,
;   for example, Windows gives these addresses when you check
;   "Obtain an IP address automatically" and you have no DHCP server.
;
; Further information has also been found at:
; http://home.t-online.de/home/TschiTschi/ip_adressierung.htm
;
; Script supplies two funcions:
; GetNextIp : get any IP (network and internet)
; CheckIP   : determine IP type (see function header for available types)
; Script uses the VersionCheck
; function to test IP's.
 
 
Section
  ; Code to use actual ExtensionDLL
  ; Current script provides an example
 
  ip::get_ip
  Pop $0
 
  ; test entry
  ;StrCpy $0 '192.168.0.100;127.0.0.1;152.168.0.101;169.254.0.1;'
 
  Loop:
  Push $0
  Call GetNextIp
  Call CheckIp
  Pop $2 ; Type of current IP-address
  Pop $1 ; Current IP-address
  Pop $0 ; Remaining addresses
  StrCmp $2 '1' '' NoLoopBackIp
    MessageBox MB_OK "LoopBack IP-address: $1"
    Goto Continue
  NoLoopBackIp:
  StrCmp $2 '2' '' NoAPA
    MessageBox MB_OK "Automatic Private IP-address: $1"
    Goto Continue
  NoAPA:
  StrCmp $2 '3' '' NoLanIp
    MessageBox MB_OK "Network IP-address: $1"
    Goto Continue
  NoLanIp:
  MessageBox MB_OK "Internet IP-address: $1"
  Continue:
  StrCmp $0 '' ExitLoop Loop
  ExitLoop:
SectionEnd
 
; Function GetNextIp
; input: head of stack
; format: 'ip1;ip2;ip3;ip4;'
; output: 'ip1' head of stack
;         'ip2;ip3;ip4;' second entry of stack
 
Function GetNextIp
  Exch $0
  Push $1
  Push $2
  Strcpy $2 0             ; Counter
  Loop:
    IntOp $2 $2 + 1
    StrCpy $1 $0 1 $2
    StrCmp $1 '' ExitLoop
    StrCmp $1 ';' '' Loop
    StrCpy $1 $0 $2       ; IP-address
    IntOp $2 $2 + 1
    StrCpy $0 $0 '' $2    ; Remaining string
  ExitLoop:
  Pop $2
  Push $0
  Exch 2
  Pop $0
  Exch $1
FunctionEnd
 
; Function CheckIP
; input: IP-address on stack
; output: additional entry on stack
;         1 - LoopBack IP (localhost, indicates no connection to a LAN or to the internet).
;         2 - Automatic Private IP Address (no DHCP server).
;         3 - Network IP.
;         4 - Internet IP.
; Eg:
; Push '192.168.0.100'
; Call CheckIP
; Pop $0 ; Contains '3'
; Pop $1 ; Contains '192.168.0.100'
 
Function CheckIP
  Exch $0
  Push $1
 
  ; Check 127.x.x.x
  Push '127.0.0.0'
  Push $0
  Call VersionCheck
  Pop $1
  StrCmp $1 2 '' Range1     ; IP cannot be in range of LoopBack addresses
  Push '127.255.255.255'
  Push $0
  Call VersionCheck
  Pop $1
  StrCmp $1 1 LoopBack      ; We found a LoopBack IP
 
  ; Check 10.x.x.x
  Range1:
  Push '10.0.0.0'
  Push $0
  Call VersionCheck
  Pop $1
  StrCmp $1 2 '' Range2     ; IP cannot be in range 1
  Push '10.255.255.255'
  Push $0
  Call VersionCheck
  Pop $1
  StrCmp $1 1 LanIp         ; We found a LanIp
 
  ; Check 172.16.x.x to 172.31.x.x
  Range2:
  Push '172.16.0.0'
  Push $0
  Call VersionCheck
  Pop $1
  StrCmp $1 2 '' Range3     ; IP cannot be in range 2
  Push '172.31.255.255'
  Push $0
  Call VersionCheck
  Pop $1
  StrCmp $1 1 LanIp         ; We found a LanIp
 
  ; Check 192.168.x.x
  Range3:
  Push '192.168.0.0'
  Push $0
  Call VersionCheck
  Pop $1
  StrCmp $1 2 '' Range4     ; IP cannot be in range 3
  Push '192.168.255.255'
  Push $0
  Call VersionCheck
  Pop $1
  StrCmp $1 1 LanIp         ; We found a LanIp
 
  ; Check 169.254.x.x
  Range4:
  Push '169.254.0.0'
  Push $0
  Call VersionCheck
  Pop $1
  StrCmp $1 2 '' InternetIp ; It should be an internet IP
  Push '169.254.255.255'
  Push $0
  Call VersionCheck
  Pop $1
  StrCmp $1 1 APA           ; We found an Automatic Private IP Address
 
  Goto InternetIp           ; Remaining addresses are internet IPs
 
  LoopBack:
  StrCpy $1 1
  Goto Exit
 
  APA:
  StrCpy $1 2
  Goto Exit
 
  LanIp:
  StrCpy $1 3
  Goto Exit
 
  InternetIp:
  StrCpy $1 4
 
  Exit:
  Exch $1
  Exch 1
  Exch $0
  Exch 1
FunctionEnd
 
; Function VersionCheck
; input: 'v1', 'v2' on stack
; output 1 - if number 1 is newer
;        2 - if number 2 is newer
;        0 - if it is the same verion
; Eg:
; Push '3.5.1.4'
; Push '3.5'
; Call VersionCheck
; Pop $0 ; now contains 1
 
Function VersionCheck
  Exch $0 ;second versionnumber
  Exch
  Exch $1 ;first versionnumber
  Push $R0 ;counter for $0
  Push $R1 ;counter for $1
  Push $3 ;temp char
  Push $4 ;temp string for $0
  Push $5 ;temp string for $1
  StrCpy $R0 "-1"
  StrCpy $R1 "-1"
  Start:
  StrCpy $4 ""
  DotLoop0:
  IntOp $R0 $R0 + 1
  StrCpy $3 $0 1 $R0
  StrCmp $3 "" DotFound0
  StrCmp $3 "." DotFound0
  StrCpy $4 $4$3
  Goto DotLoop0
  DotFound0:
  StrCpy $5 ""
  DotLoop1:
  IntOp $R1 $R1 + 1
  StrCpy $3 $1 1 $R1
  StrCmp $3 "" DotFound1
  StrCmp $3 "." DotFound1
  StrCpy $5 $5$3
  Goto DotLoop1
  DotFound1:
  Strcmp $4 "" 0 Not4
    StrCmp $5 "" Equal
    Goto Ver2Less
  Not4:
  StrCmp $5 "" Ver2More
  IntCmp $4 $5 Start Ver2Less Ver2More
  Equal:
  StrCpy $0 "0"
  Goto Finish
  Ver2Less:
  StrCpy $0 "1"
  Goto Finish
  Ver2More:
  StrCpy $0 "2"
  Finish:
  Pop $5
  Pop $4
  Pop $3
  Pop $R1
  Pop $R0
  Pop $1
  Exch $0
FunctionEnd