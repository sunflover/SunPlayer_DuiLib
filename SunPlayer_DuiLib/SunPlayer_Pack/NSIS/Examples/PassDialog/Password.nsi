Name    "PassDialog Password"
OutFile "PassDialog-Password.exe"

## Include headers
!include MUI.nsh

## Pages
 !insertmacro MUI_PAGE_WELCOME
 Page Custom PasswordPageShow PasswordPageLeave
!define MUI_PAGE_CUSTOMFUNCTION_SHOW ComponentsPageShow
 !insertmacro MUI_PAGE_COMPONENTS
 !insertmacro MUI_PAGE_INSTFILES

## Password is
!define Password "blah"

## Control ID's
!define IDC_PASSWORD 1211

## Languages
!insertmacro MUI_LANGUAGE English

## Displays the password dialog
Function PasswordPageShow

 !insertmacro MUI_HEADER_TEXT "Enter Password" "Enter your password to continue."

 PassDialog::InitDialog /NOUNLOAD Password /HEADINGTEXT "Enter a password dammit!!!" /GROUPTEXT "In 'ere \/"
  Pop $R0 # Page HWND

  GetDlgItem $R1 $R0 ${IDC_PASSWORD}
  SendMessage $R1 ${EM_SETPASSWORDCHAR} 178 0

 PassDialog::Show

FunctionEnd

## Validate password
Function PasswordPageLeave

 ## Pop password from stack
 Pop $R0

 ## A bit of validation
 StrCmp $R0 '${Password}' +3
  MessageBox MB_OK|MB_ICONEXCLAMATION "The password is '${Password}', fool!"
  Abort

 ## Display the password
 MessageBox MB_OK|MB_ICONINFORMATION "The password is correct: $R0 !"

FunctionEnd

Function ComponentsPageShow

 ## Disable the Back button
 GetDlgItem $R0 $HWNDPARENT 3
 EnableWindow $R0 0

FunctionEnd

## Just a dummy section
Section 'A section'
SectionEnd