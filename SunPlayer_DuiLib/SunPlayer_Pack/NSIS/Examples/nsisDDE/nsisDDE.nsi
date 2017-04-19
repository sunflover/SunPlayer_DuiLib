; nsisDDE - Sample script

!addplugindir ${TARGETDIR}

Name "Sample nsisDDE"
OutFile "Sample.exe"
ShowInstDetails show	

Section "Main program" SecCopyUI
	DetailPrint "Invoking nsisDDE::Execute to close WinWord..."
	nsisDDE::Execute "WinWord" "[FileQuit()]"
	Pop $0
	DetailPrint "Found $0 responding DDE server(s)"
	Sleep 1000		; Leave some extra time for the application to close
SectionEnd
