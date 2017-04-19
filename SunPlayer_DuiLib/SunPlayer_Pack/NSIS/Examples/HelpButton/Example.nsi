; primes.nsi
;
; This is an example of the possibities of the NSIS Script language.
; It calculates prime numbers.

;--------------------------------

Name "HelpButton"
OutFile "HelpButton.exe"
Caption "Runtime Help Button v0.7b"
ShowInstDetails show
InstallDir $EXEDIR
;SetFont "Tahoma" 5

#DirText "Select a directory to write primes.txt. $_CLICK"

;--------------------------------

;Pages

Page license start
Page directory "" start_2
Page instfiles "" "" start_3


Function start
	HelpButton::show /NOUNLOAD "246,231" "blah blah blah" "built to the power of the llama ^o^" "/html=$EXEDIR\winampmb.htm"
FunctionEnd

Function start_3
	MessageBox MB_OK "Try pressing 'F1'"
	HelpButton::show /NOUNLOAD "0,50" "" "well you did ask!" "/file=$EXEDIR\help.rtf" wrap 20
FunctionEnd

Function start_2
	HelpButton::show /NOUNLOAD "232,231" "?" "now you've really done it..." "now why install?" wrap ; 20
FunctionEnd

Function .onGUIEnd
	# This needs to be called otherwise the dll will not be correctly unloaded and so will stay on the hd :o(
	HelpButton::end
FunctionEnd

;--------------------------------

Section ""
  SetOutPath $INSTDIR
  Call DoPrimes 
SectionEnd

;--------------------------------

Function DoPrimes
; we put this in here so it doesn't update the progress bar (faster)

!define PPOS $0 ; position in prime searching
!define PDIV $1 ; divisor
!define PMOD $2 ; the result of the modulus
!define PCNT $3 ; count of how many we've printed

  DetailPrint "2 is prime!"
  DetailPrint "3 is prime!"
  Strcpy ${PPOS} 3
  Strcpy ${PCNT} 2
outerloop:
   StrCpy ${PDIV} 3
   innerloop:
     IntOp ${PMOD} ${PPOS} % ${PDIV}
     IntCmp ${PMOD} 0 notprime
     IntOp ${PDIV} ${PDIV} + 2
     IntCmp ${PDIV} ${PPOS} 0 innerloop 0
       DetailPrint "${PPOS} is prime!"
       IntOp ${PCNT} ${PCNT} + 1
       IntCmp ${PCNT} 100 0 innerloop
       StrCpy ${PCNT} 0
       MessageBox MB_YESNO "Process more?" IDNO stop
     notprime:
       IntOp ${PPOS} ${PPOS} + 2
     Goto outerloop
   stop:
FunctionEnd