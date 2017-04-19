!include MUI.nsh

Name    "ScrollLicense Test"
OutFile "ScrollLicense.exe"

!define MUI_PAGE_CUSTOMFUNCTION_SHOW LicenseShow
!insertmacro MUI_PAGE_LICENSE ExampleCheckBox.nsi

!insertmacro MUI_LANGUAGE English

LicenseForceSelection checkbox

Function LicenseShow
 ScrollLicense::Set /NOUNLOAD
FunctionEnd

Function .onGUIEnd
 ScrollLicense::Unload
FunctionEnd

Section "A Section"
SectionEnd