!include MUI.nsh

Name "ShutdownAllow Modern UI Example"
OutFile ExampleMUI.exe

!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE English

Function onGUIInit
  ShutdownAllow::Allow /NOUNLOAD
FunctionEnd

Function .onGUIEnd
  ShutdownAllow::Unload
FunctionEnd

Section "Dummy" SecDummy
SectionEnd

LangString DESC_SecDummy ${LANG_ENGLISH} "Description of section."

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
!insertmacro MUI_FUNCTION_DESCRIPTION_END