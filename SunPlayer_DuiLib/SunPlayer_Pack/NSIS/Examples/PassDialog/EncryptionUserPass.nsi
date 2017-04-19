Name    "PassDialog UserPass With Encryption"
OutFile "PassDialog-EncryptionUserPass.exe"

## MD5 plugin DLL required.
## Download from NSIS Wiki.

## Include headers
!include MUI.nsh

## Pages
 !insertmacro MUI_PAGE_WELCOME
 Page Custom UserPassPageShow UserPassPageLeave
!define MUI_PAGE_CUSTOMFUNCTION_SHOW ComponentsPageShow
 !insertmacro MUI_PAGE_COMPONENTS
 !insertmacro MUI_PAGE_INSTFILES

## Password is
!define Username1MD5 "7f15f1ad99c489dc0314952535e424d5" # Jeff
!define Password1MD5 "6f1ed002ab5595859014ebf0951522d9" # blah
!define Username2MD5 "c7d714a4cac1686d91ff236931ec6dfa" # stealth
!define Password2MD5 "d02c4c4cde7ae76252540d116a40f23a" # zero

## Control ID's
!define IDC_USERNAME 1215
!define IDC_PASSWORD 1214

## Languages
!insertmacro MUI_LANGUAGE English

## Displays the password dialog
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

 ## Validate password
Function UserPassPageLeave

## Pop password & username from stack
Pop $R0
Pop $R1

## Get MD5 string for username
MD5DLL::GetMD5String $R0
Pop $R0

## Get MD5 string for password
MD5DLL::GetMD5String $R1
Pop $R1

## A bit of validation
StrCmp $R0 '${Username1MD5}' 0 +2
StrCmp $R1 '${Password1MD5}' Good Bad
StrCmp $R0 '${Username2MD5}' 0 +2
StrCmp $R1 '${Password2MD5}' Good Bad

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