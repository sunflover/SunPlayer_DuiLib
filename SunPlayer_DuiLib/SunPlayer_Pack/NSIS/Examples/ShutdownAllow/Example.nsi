Name "ShutdownAllow Example"
OutFile Example.exe

Page Directory
Page Components
Page InstFiles

Function .onGUIInit
  ShutdownAllow::Allow /NOUNLOAD
FunctionEnd

Function .onGUIEnd
  ShutdownAllow::Unload
FunctionEnd

Section "Dummy"
SectionEnd