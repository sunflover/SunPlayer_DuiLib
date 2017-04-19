; Installer Attributes
;-----------------------------------------------------
Name "ExDlg"
OutFile "ExDlg.exe"
ComponentText "Please choose which dialogs with determined control classes to see in action using ExDlg..." \
              "" "Choose which test dialogs to run:"

InstallButtonText "Run"

; Hidden "-pre" Section.
;-----------------------------------------------------
Section "-pre"
  SetOutPath $TEMP
  File ".\Example.res"
SectionEnd

; Sample Dialog Page #1
;-----------------------------------------------------
Section '"EDIT" and "BUTTON"'
  exdlg::create_dlg "101" "$TEMP\Example.res"
  Pop $0
  Push $0
  push "1005"
  call DisplayResult
  Push $0
  push "1007"
  call DisplayResult
  Push $0
  push "1008"
  call DisplayResult
  Push $0
  push "112"
  call IsChecked
  Push $0
  push "113"
  call IsChecked

  exdlg::dealloc $0
SectionEnd

; Sample Dialog Page #2
;-----------------------------------------------------
Section '"START_BROWSE" and TRACKBAR_CLASS'
  exdlg::create_dlg "102" "$TEMP\Example.res"
  Pop $0
  Push $0
  push "104"
  call DisplayResult
  Push $0
  push "105"
  call SliderPercent

  exdlg::dealloc $0
SectionEnd

; Sample Dialog Page #3
;-----------------------------------------------------
Section '"FILE_BROWSE" and "DIR_BROWSE"'
  exdlg::create_dlg "103" "$TEMP\Example.res"
  Pop $0
  Push $0
  push "15"
  call DisplayResult
  Push $0
  push "16"
  call DisplayResult

  exdlg::dealloc $0
SectionEnd

; Hidden "-post" Section.
;-----------------------------------------------------
Section "-post"
  Delete "$TEMP\script1.res"
SectionEnd

; IsChecked Function: Detects if a checkbox is checked
;-----------------------------------------------------
Function IsChecked
  exdlg::push_windowtext
  Pop $1
  StrCmp "! invalid id" $1 nothing
  StrCmp "checked" $1 not_checked
  goto nothing
  not_checked:
  MessageBox MB_OK $1
  nothing:
FunctionEnd

; DisplayResult Function: Detects the control's state
;-----------------------------------------------------
Function DisplayResult
  exdlg::push_windowtext
  Pop $1
  StrCmp "! invalid id" $1 nothing
  StrCmp "" $1 nothing
  MessageBox MB_OK $1
  nothing:
FunctionEnd

; SliderPercent Function: Detects the item selected
;-----------------------------------------------------
Function SliderPercent
  exdlg::push_windowtext
  Pop $1
  StrCmp "! invalid id" $1 nothing
  StrCmp "" $1 nothing
  IntOp $1 100 - $1
  MessageBox MB_OK "You thought it was $1% cool"
  nothing:
FunctionEnd