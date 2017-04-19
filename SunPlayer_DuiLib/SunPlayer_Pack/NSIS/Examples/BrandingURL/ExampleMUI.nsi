!include MUI.nsh

## Settings.
Name    "BrandingURL Plugin Example"
OutFile BrandingURLMUI.exe

# The text to be displayed for our to-be hyperlink.
BrandingText "Afrow UK's website!"

## Pages.
!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

## Languages.
!insertmacro MUI_LANGUAGE English

## Dummy section.
Section
SectionEnd

## Set the hyperlink up.
Function onGUIInit
 BrandingURL::Set /NOUNLOAD "200" "0" "0" "http://www.afrowuk.co.uk"
FunctionEnd

## Unload the plugin.
Function .onGUIEnd
 BrandingURL::Unload
FunctionEnd