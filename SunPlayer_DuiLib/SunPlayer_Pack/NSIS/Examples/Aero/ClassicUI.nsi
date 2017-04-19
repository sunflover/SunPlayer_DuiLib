Name `Aero Test`
XPStyle on
OutFile AeroTestClassicUI.exe
RequestExecutionLevel user
InstallDir $PROGRAMFILES\Blah
BrandingText `We Like Aero`

Page Directory
LicenseData ${__FILE__}
Page License
Page InstFiles
Page License

Function .onGUIInit
  !ifdef ${NSIS_MAKENSIS64} ; Note: Not defined for https://bitbucket.org/dgolub/nsis64!
    Aero64::Apply
  !else
    Aero::Apply
  !endif
FunctionEnd

Section
SectionEnd