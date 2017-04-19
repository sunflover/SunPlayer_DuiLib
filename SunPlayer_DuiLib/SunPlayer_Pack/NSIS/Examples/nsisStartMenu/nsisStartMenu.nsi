; nsisStartMenu - Sample script

!ifdef TARGETDIR
!addplugindir ${TARGETDIR}
!else
!addplugindir "Release"
!endif

!define PRODUCT "nsisStartMenu"

Name "Sample nsisStartMenu"
OutFile "Sample.exe"
ShowInstDetails show	


Section "Main program"
	IfFileExists "$SMPROGRAMS\${PRODUCT}\*" uninstall

	CreateDirectory "$SMPROGRAMS\${PRODUCT}"
	CreateShortCut  "$SMPROGRAMS\${PRODUCT}\Woaw this shortcut is first.lnk" "$WINDIR\Notepad.exe"

	nsisStartMenu::RegenerateFolder "${PRODUCT}"
	Pop $0
	IntCmp $0 0 error

	CreateShortCut  "$SMPROGRAMS\${PRODUCT}\despite the alphabetical order.lnk" "$WINDIR\Notepad.exe"

	nsisStartMenu::RegenerateFolder "${PRODUCT}"
	Pop $0
	IntCmp $0 0 error

	CreateShortCut  "$SMPROGRAMS\${PRODUCT}\Uninstall.lnk" "$EXEPATH"

	MessageBox MB_OK "Look at the '${PRODUCT}' menu in the Start Menu now"
	Quit

error:
	DetailPrint "nsisStartMenu::RegenerateFolder failed"
	Abort

uninstall:
	DetailPrint "Uninstallation..."
	RMDir /r "$SMPROGRAMS\${PRODUCT}"
SectionEnd
