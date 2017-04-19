!include MUI.nsh

Name    "ScrollLicense Test"
OutFile "ScrollLicense.exe"

!define MUI_PAGE_CUSTOMFUNCTION_SHOW LicenseShow
!insertmacro MUI_PAGE_LICENSE ExampleRadioButtons.nsi

!insertmacro MUI_LANGUAGE English

LicenseForceSelection radiobuttons

Function LicenseShow
 ScrollLicense::Set /NOUNLOAD
FunctionEnd

Function .onGUIEnd
 ScrollLicense::Unload
FunctionEnd

Section "A Section"
SectionEnd