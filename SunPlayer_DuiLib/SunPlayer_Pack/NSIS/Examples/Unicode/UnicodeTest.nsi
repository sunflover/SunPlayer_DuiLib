Name "UnicodeTest"
OutFile "UnicodeTest.exe"
ShowInstDetails show

Section
	#Convert file from Unicode to ANSI
	StrCpy $0 "UTF-8.txt"
	StrCpy $1 "_ResultANSI_.txt"
	StrCpy $2 AUTO

	unicode::FileUnicode2Ansi "$0" "$1" $2
	Pop $3

	DetailPrint 'unicode::FileUnicode2Ansi "$0" "$1" $2'
	DetailPrint "$3"
	DetailPrint ""


	#Convert file from ANSI to Unicode
	StrCpy $0 "ANSI.txt"
	StrCpy $1 "_ResultUnicode_.txt"
	StrCpy $2 UTF-16LE

	unicode::FileAnsi2Unicode "$0" "$1" $2
	Pop $3

	DetailPrint 'unicode::FileAnsi2Unicode "$0" "$1" $2'
	DetailPrint "$3"
	DetailPrint ""


	#Get file unicode type
	StrCpy $0 "UTF-16BE.txt"

	unicode::UnicodeType "$0"
	Pop $1

	DetailPrint 'unicode::UnicodeType "$0"'
	DetailPrint "$1"
	DetailPrint ""
SectionEnd
