;NxS MSI LoaderDlg Test

!AddPluginDir "..\Plugins"
Name "NxS MSI LoaderDlg Test"
OutFile "NxS MSI LoaderDlg Test.exe"
ShowInstDetails show
XPStyle on
InstallDir "$PROGRAMFILES\NxS MSI LoaderDlg Test"

Page directory
Page instfiles

LangString TopText 1033 `Please wait while setup initializes.$\r$\n\
    This may take a while depending on your system's configuration.`

!macro TESTCODE

  NxSMSILoaderDlg::Show /NOUNLOAD `$(^Name) Setup` /h 1 /can 1 /top $(TopText)

  StrCpy $R0 "0"

  loop:
    NxSMSILoaderDlg::Update /NOUNLOAD /sub "$R0% complete." /pos $R0
    
    ; Check if user clicked Cancel
    NxSMSILoaderDlg::HasUserAborted /NOUNLOAD
    Pop $R1
    IntCmp $R1 1 cancel +1 cancel
    
    IntOp $R0 $R0 + 1
    Sleep 25
  IntCmp $R0 100 +1 loop +1
  
  cancel:

  NxSMSILoaderDlg::Destroy
  Pop $R0

!macroend

Function .onGUIInit
  ; NxSMSILoaderDlg requires this to be called in .onGUIInit
  ; if you use NxSMSILoaderDlg in the .onInit function.
  ; If you leave it out the installer dialog will be minimized.
  ShowWindow $HWNDPARENT 2
FunctionEnd

Function .onInit
  InitPluginsDir
  !insertmacro TESTCODE
FunctionEnd

Section
SectionEnd
