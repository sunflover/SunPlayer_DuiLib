Name    "PassDialog InputBox"
OutFile "PassDialog-InputBox.exe"

## Include headers
!include MUI.nsh

## Pages
 !insertmacro MUI_PAGE_WELCOME
 Page Custom InputBoxPageShow InputBoxPageLeave
 !insertmacro MUI_PAGE_COMPONENTS
 !insertmacro MUI_PAGE_INSTFILES

## Password is
!define Password "blah"
!define Username "Jeff"

## Control ID's
!define IDC_INPUTBOX 1215

## Languages
!insertmacro MUI_LANGUAGE English

## Displays the input box dialog
Function InputBoxPageShow

 !insertmacro MUI_HEADER_TEXT "Enter Details" "Enter your details."

 PassDialog::InitDialog /NOUNLOAD InputBox /BOX "ja" "hello" 0
  Pop $R0 # Page HWND

  GetDlgItem $R1 $R0 ${IDC_INPUTBOX}
  SetCtlColors $R1 0xFF0000 0xFFFF00

 PassDialog::Show

FunctionEnd

## Validate inpu
Function InputBoxPageLeave

 ## Pop details from stack
 Pop $R0

 ## Display the details
 MessageBox MB_OK|MB_ICONINFORMATION "You entered: $R0 !"

FunctionEnd

## Just a dummy section
Section 'A section'
SectionEnd