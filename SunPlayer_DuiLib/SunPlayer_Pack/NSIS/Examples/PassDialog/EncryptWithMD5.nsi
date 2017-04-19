Name    "Ecrypt With MD5"
OutFile "EncryptWithMD5.exe"

## Include headers
!include MUI.nsh

## Pages
Page Custom InputBoxPageShow InputBoxPageLeave

## Control ID's
!define IDC_INPUTBOX 1215

## Languages
!insertmacro MUI_LANGUAGE English

## Get MD5 DLL plugin path
Function .onInit

 StrCpy $R1 ""
 StrCpy $R2 ""

FunctionEnd

## Displays the input box dialog
Function InputBoxPageShow

 !insertmacro MUI_HEADER_TEXT "Enter Settings" "Enter the string to encrypt and the path to the MD5 plugin extension DLL."

 ## Change Next button text.
 GetDlgItem $R0 $HWNDPARENT 1
 SendMessage $R0 ${WM_SETTEXT} "" "STR:Encrypt..."

 PassDialog::InitDialog /NOUNLOAD InputBox /HEADINGTEXT "The MD5 DLL plugin is required. You can download it from the NSIS Wiki." /BOX "String:" "$R1" 0 /BOXRO "MD5 Checksum:" "$R2" 0
  Pop $R3 # Page HWND
 PassDialog::Show
  Pop $R0 # success, back, cancel or error

FunctionEnd

## Validate input
Function InputBoxPageLeave

 ## Pop details from stack
 Pop $R1
 Pop $R2

 ## Validate entered string to encrypt
 StrCmp $R1 "" 0 +3
  MessageBox MB_OK|MB_ICONEXCLAMATION "Please enter a string to encrypt."
  Abort

 MD5DLL::GetMD5String $R1
 Pop $R2

 ## Get 2nd InputBox field (by adding 2 onto IDC_INPUTBOX)
 IntOp $R0 ${IDC_INPUTBOX} + 2
 GetDlgItem $R0 $R3 $R0
 SendMessage $R0 ${WM_SETTEXT} "" "STR:$R2"

 Abort

FunctionEnd

## Just a dummy section
Section 'A section'
SectionEnd