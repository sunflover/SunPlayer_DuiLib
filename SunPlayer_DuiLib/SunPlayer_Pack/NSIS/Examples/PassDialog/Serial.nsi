Name    "PassDialog Serial"
OutFile "PassDialog-Serial.exe"

## Include headers
!include MUI.nsh

## Pages
 !insertmacro MUI_PAGE_WELCOME
 Page Custom SerialPageShow SerialPageLeave
!define MUI_PAGE_CUSTOMFUNCTION_SHOW ComponentsPageShow
 !insertmacro MUI_PAGE_COMPONENTS
 !insertmacro MUI_PAGE_INSTFILES

## Languages
!insertmacro MUI_LANGUAGE English

## Displays the serial dialog
Function SerialPageShow

 !insertmacro MUI_HEADER_TEXT "Enter Serial Code" "Enter the software serial code to continue."

 PassDialog::Dialog Serial            \
                    /HEADINGTEXT 'Please enter the serial code located on the software CD case...' \
                    /CENTER             \
                    /BOXDASH 12  70 4 '' \
                    /BOXDASH 92  70 4 ''  \
                    /BOXDASH 172 70 4 ''   \
                    /BOXDASH 252 70 4 ''    \
                    /BOX     332 70 4 ''

  Pop $R0 # success, back, cancel or error

FunctionEnd

## Validate serial numbers
Function SerialPageLeave

 ## Pop values from stack
 Pop $R0
 Pop $R1
 Pop $R2
 Pop $R3
 Pop $R4

 ## A bit of validation
 StrCmp $R0 'aaaa' +3
  MessageBox MB_OK|MB_ICONEXCLAMATION "You must enter 'aaaa' in field 1!"
  Abort

 ## Display the values
 MessageBox MB_OK|MB_ICONINFORMATION "You inputted: $R0, $R1, $R2, $R3, $R4"

FunctionEnd

Function ComponentsPageShow

 ## Disable the Back button
 GetDlgItem $R0 $HWNDPARENT 3
 EnableWindow $R0 0

FunctionEnd

## Just a dummy section
Section 'A section'
SectionEnd