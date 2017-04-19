Name "Example"
OutFile "Example.exe"

LicenseData "${NSISDIR}\Docs\MakeNSISw\license.txt"

Page License 
Page InstFiles

ShowInstDetails Show
ShowUnInstDetails Show

Function .onguiinit
  StrCpy $0 `NSIS: "The Best Installer On The Planet"`
  SimpleBg::SetBg /NOUNLOAD 0 128 128 0 128 128 "$0"
FunctionEnd

Function .onguiend
  SimpleBg::Destroy
FunctionEnd

Section
  Sleep 500
  DetailPrint "Hello World!"
  Sleep 500
  DetailPrint "This is a demonstration."
  Sleep 500
  DetailPrint "To err is human."
  Sleep 700
  DetailPrint "Now we are finished."
  Sleep 700
  SetAutoClose False
SectionEnd