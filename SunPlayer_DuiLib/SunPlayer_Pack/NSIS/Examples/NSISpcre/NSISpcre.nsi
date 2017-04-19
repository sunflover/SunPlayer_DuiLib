;_____________________________________________________________________________
;
;                          PCRE Functions Test
;_____________________________________________________________________________
;
; 2007 Rob Stocks, Computerway Business Solutions Ltd.

Name "PCRE Functions Test"
OutFile "PCREFuncTest.exe"
Caption "$(^Name)"
ShowInstDetails show
XPStyle on

Var FUNCTION
Var OUT
Var STACKTOP

!include "NSISpcre.nsh"
!insertmacro REQuoteMeta
!insertmacro RECheckPattern
!insertmacro REClearAllOptions
!insertmacro REClearOption
!insertmacro REGetOption
!insertmacro RESetOption
!insertmacro REMatches
!insertmacro REReplace
!insertmacro REFind
!insertmacro REFindNext

!insertmacro un.REGetOption
!insertmacro un.RESetOption
!insertmacro un.REClearOption
!insertmacro un.REClearAllOptions
!insertmacro un.REMatches
!insertmacro un.REReplace

;############### INSTALL ###############

!define StackVerificationStart `!insertmacro StackVerificationStart`
!macro StackVerificationStart _FUNCTION
	StrCpy $FUNCTION ${_FUNCTION}
	Call StackVerificationStart
!macroend

!define StackVerificationEnd `!insertmacro StackVerificationEnd`
!macro StackVerificationEnd
	Call StackVerificationEnd
!macroend

Function StackVerificationStart
	StrCpy $0 !0
	StrCpy $1 !1
	StrCpy $2 !2
	StrCpy $3 !3
	StrCpy $4 !4
	StrCpy $5 !5
	StrCpy $6 !6
	StrCpy $7 !7
	StrCpy $8 !8
	StrCpy $9 !9
	StrCpy $R0 !R0
	StrCpy $R1 !R1
	StrCpy $R2 !R2
	StrCpy $R3 !R3
	StrCpy $R4 !R4
	StrCpy $R5 !R5
	StrCpy $R6 !R6
	StrCpy $R7 !R7
	StrCpy $R8 !R8
	StrCpy $R9 !R9
	
	Push "StackVerification"
FunctionEnd

Function StackVerificationEnd
	IfErrors +3
	DetailPrint 'PASSED $FUNCTION no errors'
	goto +2
	DetailPrint '*** FAILED $FUNCTION error'
	
	Pop $STACKTOP
	StrCmp $STACKTOP 'StackVerification' 0 stackerror
	#DetailPrint 'PASSED $FUNCTION stack'
	
	goto +2
	stackerror:
	DetailPrint '*** FAILED $FUNCTION stack ($STACKTOP)'

	StrCmp $0 '!0' 0 regerror
	StrCmp $1 '!1' 0 regerror
	StrCmp $2 '!2' 0 regerror
	StrCmp $3 '!3' 0 regerror
	StrCmp $4 '!4' 0 regerror
	StrCmp $5 '!5' 0 regerror
	StrCmp $6 '!6' 0 regerror
	StrCmp $7 '!7' 0 regerror
	StrCmp $8 '!8' 0 regerror
	StrCmp $9 '!9' 0 regerror
	StrCmp $R0 '!R0' 0 regerror
	StrCmp $R1 '!R1' 0 regerror
	StrCmp $R2 '!R2' 0 regerror
	StrCmp $R3 '!R3' 0 regerror
	StrCmp $R4 '!R4' 0 regerror
	StrCmp $R5 '!R5' 0 regerror
	StrCmp $R6 '!R6' 0 regerror
	StrCmp $R7 '!R7' 0 regerror
	StrCmp $R8 '!R8' 0 regerror
	StrCmp $R9 '!R9' 0 regerror
	#DetailPrint 'PASSED $FUNCTION registers'
	goto end

	regerror:
	DetailPrint '*** FAILED $FUNCTION registers'
;	MessageBox MB_OKCANCEL '$$0={$0}$\n$$1={$1}$\n$$2={$2}$\n$$3={$3}$\n$$4={$4}$\n$$5={$5}$\n$$6={$6}$\n$$7={$7}$\n$$8={$8}$\n$$9={$9}$\n$$R0={$R0}$\n$$R1={$R1}$\n$$R2={$R2}$\n$$R3={$R3}$\n$$R4={$R4}$\n$$R5={$R5}$\n$$R6={$R6}$\n$$R7={$R7}$\n$$R8={$R8}$\n$$R9={$R9}' IDOK +2
;	quit

	end:
FunctionEnd

Section LogicLibIntegration

	${StackVerificationStart} LogicLibIntegration

        Push $0
        StrCpy $0 "c:\Program Files\"
        ${If} $0 !~ ".*\\"
                Goto error
        ${EndIf}
        
        ${If} $0 =~ ".*\\"
        ${Else}
                Goto error
        ${EndIf}
        
        ${If} "a" == "a"
        ${AndIf} "a" =~ "[a-z]"
                ${RESetOption} "CASELESS"
                ${If} "a" == "b"
                ${OrIf} "B" =~ "[a-z]"
                ${Else}
                        Goto error
                ${EndIf}
                ${REClearOption} "CASELESS"
        ${Else}
                Goto error
        ${EndIf}

        StrCpy $0 ""
        ${IfThen} "a" !~ "[A-Z]" ${|} StrCpy $0 "1" ${|}
        StrCmp $0 1 0 error
        
        StrCpy $0 ""
        ${DoWhile} $0 !~ "000000"
                StrCpy $0 "$00"
                StrCmp $0 "0000000" error
        ${Loop}
        StrCmp $0 "000000" 0 error

	goto +2
	error:
	SetErrors

        Pop $0
        
	${StackVerificationEnd}
	
SectionEnd

Section GetSetOptions
        !define OptionTest `!insertmacro OptionTest`
        !macro OptionTest OPTION
                # Each option should be false to start with
                # because we called REClearAllOptions
        	${REGetOption} $OUT ${OPTION}
        	IfErrors error
                StrCmp $OUT "false" 0 error

                # Set option and test
        	${RESetOption} ${OPTION}
        	IfErrors error
        	${REGetOption} $OUT ${OPTION}
        	IfErrors error
                StrCmp $OUT "true" 0 error
                
                # Clear option and test
        	${REClearOption} ${OPTION}
        	IfErrors error
        	${REGetOption} $OUT ${OPTION}
        	IfErrors error
                StrCmp $OUT "false" 0 error
        !macroend
        
	${StackVerificationStart} GetSetOptions
	
	${REClearAllOptions}
        IfErrors error

	${OptionTest} "MULTILINE"
	${OptionTest} "CASELESS"
	${OptionTest} "DOTALL"
	${OptionTest} "EXTENDED"
	${OptionTest} "UTF8"
	${OptionTest} "DOLLAR_ENDONLY"
	${OptionTest} "EXTRA"
	${OptionTest} "UNGREEDY"
	${OptionTest} "NO_AUTO_CAPTURE"
	${OptionTest} "i"
	${OptionTest} "m"
	${OptionTest} "x"
	${OptionTest} "s"

	goto +2
	error:
	SetErrors

	${StackVerificationEnd}
SectionEnd

Section QuoteMeta
        !define QuoteMetaTest `!insertmacro QuoteMetaTest`
        !macro QuoteMetaTest UNQUOTED QUOTED
        	${REQuoteMeta} $OUT `${UNQUOTED}`
        	IfErrors error
                StrCmp $OUT `${QUOTED}` 0 error
        !macroend

	${StackVerificationStart} QuoteMeta

	${QuoteMetaTest} ".*" "\.\*"
	${QuoteMetaTest} "(.*" "\(\.\*"

	goto +2
	error:
	SetErrors

	${StackVerificationEnd}
SectionEnd

Section CheckPattern
        !define CheckPatternTest `!insertmacro CheckPatternTest`
        !macro CheckPatternTest PATTERN BAD
        	${RECheckPattern} $OUT `${PATTERN}`
        	IfErrors error
        	StrCpy $OUT $OUT 1
        	StrLen $OUT $OUT
                StrCmp $OUT `${BAD}` 0 error
        !macroend

	${StackVerificationStart} CheckPattern

	${CheckPatternTest} ".*" 0
	${CheckPatternTest} "(.*" 1

	goto +2
	error:
	SetErrors

	${StackVerificationEnd}
SectionEnd

Section Matches
        !define MatchTest `!insertmacro MatchTest`
        !macro MatchTest PATTERN SUBJECT PARTIAL RESULT
#DetailPrint "PATTERN=${PATTERN}, SUBJECT=${SUBJECT}"
        	${REMatches} $OUT `${PATTERN}` `${SUBJECT}` `${PARTIAL}`
                IfErrors error
        	StrCmp $OUT `${RESULT}` 0 error
        !macroend

	${StackVerificationStart} Matches
	
	# Check some basic patterns
	${REClearAllOptions}
	${MatchTest} ".*" "SUBJECT" 0 "true"
	${MatchTest} "S.*" "SUBJECT" 0 "true"
	${MatchTest} "s.*" "SUBJECT" 0 "false"
	${MatchTest} "S.*(ECT)+" "SUBJECT" 0 "true"
	${MatchTest} "S.*(ECT!)*" "SUBJECT" 0 "true"
	${MatchTest} "S.*(ECT){1}" "SUBJECT" 0 "true"
	${MatchTest} "S.*(ECT){2}" "SUBJECT" 0 "false"
	${MatchTest} "S.*(ECT){1,2}" "SUBJECT" 0 "true"
	${MatchTest} "SUBJ+(ECT){1}" "SUBJECT" 0 "true"

	# Check some more complicated patterns (backreferences)
	${MatchTest} "(e)l\g{1}phant" "elephant" 0 "true"
	${MatchTest} "(?<P1>123)[\d]*\k<P1>4567890" "12345678901234567890" 0 "true"
	${MatchTest} "(?<P1>123)[\d]*\k<P1>[\d]*" "12341235" 0 "true"
	${MatchTest} "(?<P1>123)[\d]*\k<P1>[\d]*" "12341245" 0 "false"

	# Check some more complicated patterns (lookaheads)
        ${MatchTest} "Computer(?=way)" "Computerway" 0 "false"
	${MatchTest} "Computer(?=[a-z]+)" "Computer" 0 "false"
	${MatchTest} "Computer(?=[a-z]*)" "Computer" 0 "true"
	${MatchTest} "Computer(?![a-z]{4})w.*" "Computerway" 0 "true"
	${MatchTest} "Computer(?![a-z]{4})w.*" "Computerway Business Solutions" 0 "true"
	${MatchTest} "Computer(?![a-z]{4})w.*" "Computerwayz" 0 "false"
	
	# Check some more complicated patterns (lookbehinds)
	${MatchTest} ".*(?<=nsis[^1])\s+is\s+the\s+best!" "nsis2 is  the$\nbest!" 0 "true"
	${MatchTest} ".*(?<=nsis[^1])\s+is\s+the\s+best!" "nsis1 is  the best!" 0 "false"
	
	# Check partial matches
	${MatchTest} "U[\S+]J" "SUBJECT" 0 "false"
	${MatchTest} "U[\S+]J" "SUBJECT" 1 "true"
	
	# Try the options
	${RESetOption} "CASELESS"
	${MatchTest} "subject" "SUBJECT" 0 "true"
	${REClearOption} "CASELESS"
	${MatchTest} "subject" "SUBJECT" 0 "false"
	
	${RESetOption} "DOTALL"
	${MatchTest} "SUB.JECT" "SUB$\nJECT" 0 "true"
	${REClearOption} "DOTALL"
	${MatchTest} "SUB.JECT" "SUB$\nJECT" 0 "false"

	${RESetOption} "MULTILINE"
	${MatchTest} "^abc\s?$$.*" "abc$\r$\ndef" 0 "true"
	${REClearOption} "MULTILINE"
	${MatchTest} "^abc\s?$$.*" "abc$\r$\ndef" 0 "false"
	
	${RESetOption} "DOLLAR_ENDONLY"
	${MatchTest} "SUBJECT$$" "SUBJECT$\n" 1 "false"
	${REClearOption} "DOLLAR_ENDONLY"
	${MatchTest} "SUBJECT$$" "SUBJECT$\n" 1 "true"
	
	${RESetOption} "EXTENDED"
	${MatchTest} ".* CT" "SUBJECT" 0 "true"
	${MatchTest} ".*CT # Comment" "SUBJECT" 0 "true"
	${REClearOption} "EXTENDED"
	${MatchTest} ".* CT" "SUBJECT" 0 "false"
	${MatchTest} ".*CT # Comment" "SUBJECT" 0 "false"
	
	${RESetOption} "UNGREEDY"
	${MatchTest} "/\*.*\*/" "/* a */ b /* c */" 0 "false"
	${MatchTest} "/\*.*?\*/" "/* a */ b /* c */" 0 "true"
	${REClearOption} "UNGREEDY"
	${MatchTest} "/\*.*\*/" "/* a */ b /* c */" 0 "true"
	${MatchTest} "/\*.*?\*/" "/* a */ b /* c */" 0 "false"

	# Try inline Perl options
	${MatchTest} "(?i)subject" "SUBJECT" 0 "true"
	${MatchTest} "(?-i)subject" "SUBJECT" 0 "false"
	${MatchTest} "SUB(?i)jec(?-i)t" "SUBJECT" 0 "false"
	${MatchTest} "SUB(?i)jec(?-i)t" "SUBJECt" 0 "true"
	${MatchTest} "(Line[1-2].?){2}" "Line 1$\nLine 2" 0 "false"
	${MatchTest} "(Line[1-2](?s).?){2}" "Line 1$\nLine 2" 0 "false"

	goto +2
	error:
	SetErrors
	
	${StackVerificationEnd}
SectionEnd

Section CaptureMatches
        !define CaptureMatchTest0 `!insertmacro CaptureMatchTest0`
        !macro CaptureMatchTest0 PATTERN SUBJECT PARTIAL
        	${RECaptureMatches} $OUT `${PATTERN}` `${SUBJECT}` `${PARTIAL}`
                IfErrors error
        	StrCmp $OUT 0 0 error
        !macroend
        !define CaptureMatchTest1 `!insertmacro CaptureMatchTest1`
        !macro CaptureMatchTest1 PATTERN SUBJECT PARTIAL RESULT
        	${RECaptureMatches} $OUT `${PATTERN}` `${SUBJECT}` `${PARTIAL}`
                IfErrors error
        	StrCmp $OUT 1 0 error
        	Pop $OUT
        	StrCmp $OUT `${RESULT}` 0 error
        !macroend
        !define CaptureMatchTest2 `!insertmacro CaptureMatchTest2`
        !macro CaptureMatchTest2 PATTERN SUBJECT PARTIAL RESULT1 RESULT2
        	${RECaptureMatches} $OUT `${PATTERN}` `${SUBJECT}` `${PARTIAL}`
                IfErrors error
        	StrCmp $OUT 2 0 error
        	Pop $OUT
        	StrCmp $OUT `${RESULT1}` 0 error
        	Pop $OUT
        	StrCmp $OUT `${RESULT2}` 0 error
        !macroend

	${StackVerificationStart} CaptureMatches
	
	${CaptureMatchTest1} "(.*)" "SUBJECT" 0 "SUBJECT"
	${CaptureMatchTest1} "S(.*)" "SUBJECT" 0 "UBJECT"
	${CaptureMatchTest1} "S([TCEJBUS]*)" "SUBJECT" 0 "UBJECT"

	${CaptureMatchTest2} "(S([TCEJBUS]*))" "SUBJECT" 0 "SUBJECT" "UBJECT"
	${CaptureMatchTest2} "(S(.*)T)" "SUBJECT" 0 "SUBJECT" "UBJEC"
	${CaptureMatchTest2} "(S(?:UBJ)ECT(.*))" "SUBJECT" 0 "SUBJECT" ""
	
	# Test NO_AUTO_CAPTURE option
	${RESetOption} "NO_AUTO_CAPTURE"
	${CaptureMatchTest0} "(.*)" "SUBJECT" 0
	${REClearOption} "NO_AUTO_CAPTURE"
	${CaptureMatchTest1} "(.*)" "SUBJECT" 0 "SUBJECT"

	goto +2
	error:
	SetErrors

	${StackVerificationEnd}
SectionEnd

Section Find
        !define FindTest0 `!insertmacro FindTest0`
        !macro FindTest0 PATTERN SUBJECT
        	${REFind} $OUT `${PATTERN}` `${SUBJECT}`
                IfErrors error
        	StrCmp $OUT 0 0 error
        !macroend
        !define FindTest1 `!insertmacro FindTest1`
        !macro FindTest1 PATTERN SUBJECT RESULT
        	${REFind} $OUT `${PATTERN}` `${SUBJECT}`
                IfErrors error
                StrCmp `${RESULT}` "false" +1 +2
               	StrCmp $OUT "false" +4 error
        	StrCmp $OUT 1 0 error
        	Pop $OUT
        	StrCmp $OUT `${RESULT}` 0 error
        !macroend
        !define FindNextTest1 `!insertmacro FindNextTest1`
        !macro FindNextTest1 RESULT
        	${REFindNext} $OUT
                IfErrors error
                StrCmp `${RESULT}` "false" +1 +2
               	StrCmp $OUT "false" +4 error
               	StrCmp $OUT 1 0 error
        	Pop $OUT
        	StrCmp $OUT `${RESULT}` 0 error
        !macroend
        !define FindTest2 `!insertmacro FindTest2`
        !macro FindTest2 PATTERN SUBJECT RESULT1 RESULT2
        	${REFind} $OUT `${PATTERN}` `${SUBJECT}`
                IfErrors error
                StrCmp `${RESULT1}` "false" +1 +2
               	StrCmp $OUT "false" +6 error
        	StrCmp $OUT 2 0 error
        	Pop $OUT
        	StrCmp $OUT `${RESULT1}` 0 error
        	Pop $OUT
        	StrCmp $OUT `${RESULT2}` 0 error
        !macroend
        !define FindNextTest2 `!insertmacro FindNextTest2`
        !macro FindNextTest2 RESULT1 RESULT2
        	${REFindNext} $OUT
                IfErrors error
                StrCmp `${RESULT1}` "false" +1 +2
               	StrCmp $OUT "false" +6 error
        	StrCmp $OUT 2 0 error
        	Pop $OUT
        	StrCmp $OUT `${RESULT1}` 0 error
        	Pop $OUT
        	StrCmp $OUT `${RESULT2}` 0 error
        !macroend

	${StackVerificationStart} Find
	
	${FindTest1} "D" "ABCD" "D"
	${FindTest1} "E" "ABCD" "false"
	${FindTest2} "(D)..A..(D)" "DCBABCD" "D" "D"
	${FindTest1} "x" "ABCxDEFxGHI" "x"
	${FindNextTest1} "x"
	${FindNextTest1} "false"
	${FindTest2} "([^;=]+)=([^;=]*)" "name1=value1;name2=value2" "name1" "value1"
	${FindNextTest2} "name2" "value2"
	${FindNextTest2} "false" ""

	${REFindClose}
	IfErrors error

	goto +2
	error:
	SetErrors

	${StackVerificationEnd}
SectionEnd

Section Replace
        !define ReplaceTest `!insertmacro ReplaceTest`
        !macro ReplaceTest PATTERN SUBJECT REPLACEMENT RESULT
        	${REReplace} $OUT `${PATTERN}` `${SUBJECT}` `${REPLACEMENT}` 0
                IfErrors error
        	StrCmp $OUT `${RESULT}` 0 error
        !macroend
        !define ReplaceAllTest `!insertmacro ReplaceAllTest`
        !macro ReplaceAllTest PATTERN SUBJECT REPLACEMENT RESULT
        	${REReplace} $OUT `${PATTERN}` `${SUBJECT}` `${REPLACEMENT}` 1
                IfErrors error
        	StrCmp $OUT `${RESULT}` 0 error
        !macroend

	${StackVerificationStart} Replace

        # Try some simple replacements
        ${ReplaceTest} "a" "Hallo World!" "e" "Hello World!"
        ${ReplaceTest} "z" "zbczbc" "a" "abczbc"
        ${ReplaceTest} "." "zbczbc" "x" "xbczbc"
        ${ReplaceTest} ".{3}" "zbczbc" "x" "xzbc"

        ${ReplaceAllTest} "z" "zbczbc" "a" "abcabc"
        ${ReplaceAllTest} "." "zbczbc" "x" "xxxxxx"
        ${ReplaceAllTest} ".{3}" "zbczbc" "x" "xx"
        
        # Try some replacements with capturing
        ${ReplaceTest} "h([\S]*)" "hello hello hello" "H\1" "Hello hello hello"
        ${ReplaceAllTest} "h([\S]*)" "hello hello hello" "H\1" "Hello Hello Hello"
        ${ReplaceAllTest} "(he)([\S]*)" "hello hello hello" "'a\2" "'allo 'allo 'allo"
        ${ReplaceTest} "(he)([\S]*)" "hello hello hello" "'a\2" "'allo hello hello"

	goto +2
	error:
	SetErrors

	${StackVerificationEnd}
SectionEnd

;############### UNINSTALL ###############

Section un.Uninstall
        # Just check that each function inserts correctly
        ${un.REClearAllOptions}
        ${un.REGetOption} $OUT "MULTILINE"
        ${un.RESetOption} "MULTILINE"
        ${un.REClearOption} "MULTILINE"
        ${un.REMatches} $OUT "PATTERN" "SUBJECT" 1
        ${un.RECaptureMatches} $OUT "PATTERN" "SUBJECT" 1
        ${un.REReplace} $OUT "PATTERN" "SUBJECT" "REPLACEMENT" 1
        ${If} "c:\" un.!~ ".*\\"
        ${EndIf}
SectionEnd