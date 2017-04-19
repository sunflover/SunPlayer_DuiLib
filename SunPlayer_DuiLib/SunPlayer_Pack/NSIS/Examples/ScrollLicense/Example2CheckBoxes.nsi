!include MUI.nsh

Name    "ScrollLicense Test"
OutFile "ScrollLicense.exe"

!define MUI_PAGE_CUSTOMFUNCTION_SHOW LicenseShow
!insertmacro MUI_PAGE_LICENSE Example2CheckBoxes.nsi

!insertmacro MUI_LANGUAGE English

LicenseForceSelection checkbox

Function LicenseShow
 ScrollLicense::Set /NOUNLOAD /CHECKBOX
FunctionEnd

Function .onGUIEnd
 ScrollLicense::Unload
FunctionEnd

Section "A Section"
SectionEnd