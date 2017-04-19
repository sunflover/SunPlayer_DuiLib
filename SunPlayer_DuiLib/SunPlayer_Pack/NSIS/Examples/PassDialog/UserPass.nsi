Name    "PassDialog UserPass"
OutFile "PassDialog-UserPass.exe"

## Include headers
!include MUI.nsh

## Pages
 !insertmacro MUI_PAGE_WELCOME
 Page Custom UserPassPageShow UserPassPageLeave
!define MUI_PAGE_CUSTOMFUNCTION_SHOW ComponentsPageShow
 !insertmacro MUI_PAGE_COMPONENTS
 !insertmacro MUI_PAGE_INSTFILES

## Password is
!define Username1 "Jeff"
!define Password1 "blah"
!define Username2 "stealth"
!define Password2 "zero"

## Control ID's
!define IDC_USERNAME 1215
!define IDC_PASSWORD 1214

## Languages
!insertmacro MUI_LANGUAGE English

## Displays the username and password dialog
Function UserPassPageShow

 !insertmacro MUI_HEADER_TEXT "Enter Username && Password" "Enter your username and password to continue."

 PassDialog::InitDialog /NOUNLOAD UserPass
  Pop $R0 # Page HWND

  GetDlgItem $R1 $R0 ${IDC_USERNAME}
  SetCtlColors $R1 0xFF0000 0xFFFFFF
  GetDlgItem $R1 $R0 ${IDC_PASSWORD}
  SetCtlColors $R1 0x0000FF 0xFFFFFF

 PassDialog::Show

FunctionEnd

 ## Validate username and password
Function UserPassPageLeave

## Pop password & username from stack
Pop $R0
Pop $R1

## A bit of validation
StrCmp $R0 '${Username1}' 0 +2
StrCmp $R1 '${Password1}' Good Bad
StrCmp $R0 '${Username2}' 0 +2
StrCmp $R1 '${Password2}' Good Bad

Bad:
MessageBox MB_OK|MB_ICONEXCLAMATION "The entered username or password is incorrect!"
Abort

Good:

FunctionEnd

Function ComponentsPageShow

 ## Disable the Back button
 GetDlgItem $R0 $HWNDPARENT 3
 EnableWindow $R0 0

FunctionEnd

## Just a dummy section
Section 'A section'
SectionEnd