
; The name of the installer
Name "Refresh Desktop"

; The file to write
OutFile "rfshdktp.exe"

; The default installation directory
InstallDir "$PROGRAMFILES\Refresh Desktop"

;--------------------------------

; Pages

Page directory
Page instfiles

;--------------------------------

; The stuff to install
Section "" ;No components page, name is not important

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File "${NSISDIR}\makensisw.exe"
  
  SetShellVarContext all
  CreateShortCut "$DESKTOP\MakeNSIS.lnk" "$INSTDIR\makensisw.exe"
  
  SetShellVarContext current
  CreateShortCut "$DESKTOP\MakeNSIS.lnk" "$INSTDIR\makensisw.exe"

  ; seems to be needed to allow the shortcuts to mess up before refreshing them
  Sleep 2000

  ; call the DLL to refresh the desktop
  rfshdktp::refreshDesktop
  
  ; never could get this to work
  ;SendMessage 65535 26 0 0
  
SectionEnd ; end the section
