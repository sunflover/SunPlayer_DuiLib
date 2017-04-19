; --------------------------------------------------
;
; ButtonEvent plugin example script
;  By Afrow UK
;
; This example script requires the UI file
; modern_modified.exe to be present to compile.
;
; --------------------------------------------------

!include MUI.nsh
!include LogicLib.nsh

; --------------------------------------------------
; General defines.

 !define IDC_BUTTON_TRYME         1190
 !define IDC_CHECKBOX_ILIKECHEESE 1200
 !define IDC_BUTTON_ILIKECHEESE   1201

 !define BST_CHECKED 1

; --------------------------------------------------
; General settings.

 Name "ButtonEvent Notify Example"
 OutFile "ButtonEventNotify.exe"

; --------------------------------------------------
; MUI interface settings.

 # We want to use our own UI with custom buttons!
 !define MUI_UI "modern_modified.exe"
 # The event handler for our parent button is added in MyGUIInit.
 !define MUI_CUSTOMFUNCTION_GUIINIT MyGUIInit
 # Don't skip to the finish page.
 !define MUI_FINISHPAGE_NOAUTOCLOSE

; --------------------------------------------------
; Insert MUI pages.

 !insertmacro MUI_PAGE_WELCOME

 !insertmacro MUI_PAGE_LICENSE ButtonEventMUI.nsi

 !define MUI_PAGE_CUSTOMFUNCTION_SHOW ComponentsShow
 !define MUI_PAGE_CUSTOMFUNCTION_LEAVE ComponentsLeave
 !insertmacro MUI_PAGE_COMPONENTS

 !define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesShow
 !insertmacro MUI_PAGE_INSTFILES

 !define MUI_PAGE_CUSTOMFUNCTION_SHOW FinishShow
 !insertmacro MUI_PAGE_FINISH

; --------------------------------------------------
; Languages.

 !insertmacro MUI_LANGUAGE English

 LangString TryMeButtonClicked  ${LANG_ENGLISH} "You clicked on the damn Try Me button didn't you!"
 LangString CheeseButtonClicked ${LANG_ENGLISH} "Thank you for clicking the I Like Cheese button!"
 LangString CheeseCheckCheckBox ${LANG_ENGLISH} "Please confirm that you really like cheese..."

; --------------------------------------------------
; Called when the custom buttons are clicked.

 # Called when the Try Me button is pressed.
 Function TryMe

  MessageBox MB_OK|MB_ICONEXCLAMATION $(TryMeButtonClicked)
    Abort

 FunctionEnd

 # Called when the I Like Cheese button is pressed.
 Function ILikeCheese

  MessageBox MB_OK|MB_ICONEXCLAMATION $(CheeseButtonClicked)

  # Has user checked the check box as well?
  FindWindow $R0 "#32770" "" $HWNDPARENT
  GetDlgItem $R1 $R0 ${IDC_CHECKBOX_ILIKECHEESE}
  SendMessage $R1 ${BM_GETCHECK} 0 0 $R0

  ${If} $R0 != ${BST_CHECKED} # User has not checked check box.
    MessageBox MB_OK|MB_ICONQUESTION $(CheeseCheckCheckBox)
      Abort
  ${EndIf}

  # Enable Next button.
  GetDlgItem $R0 $HWNDPARENT 1
  EnableWindow $R0 1

 FunctionEnd

; --------------------------------------------------
; Our custom user interface functions.

 Function MyGUIInit

  # Create event handler for our parent window button.
  GetFunctionAddress $R0 TryMe
  ButtonEvent::AddEventHandler /NOUNLOAD ${IDC_BUTTON_TRYME} $R0

 FunctionEnd

 Function ComponentsShow

  # Create event handler for our Components page button.
  ButtonEvent::AddEventHandler /NOUNLOAD ${IDC_BUTTON_ILIKECHEESE} /NOTIFY

  # Disable next button.
  GetDlgItem $R0 $HWNDPARENT 1
  EnableWindow $R0 0

 FunctionEnd

 # Modifies the components list on page leave.
 # It cannot be done while the page is visible.
 Function ComponentsLeave

  ButtonEvent::WhichButtonId /NOUNLOAD
  Pop $R0
  ${If} $R0 == ${IDC_BUTTON_ILIKECHEESE}

    # Call the original function first.
    Call ILikeCheese

    FindWindow $R0 "#32770" "" $HWNDPARENT
    GetDlgItem $R0 $R0 1200

    SectionGetFlags 0 $R2
    SectionGetFlags 1 $R3

    SendMessage $R0 ${BM_GETCHECK} 0 0 $R1
    ${If} $R1 == 1

      IntOp $R2 $R2 | ${SF_RO}
      IntOp $R2 $R2 | ${SF_SELECTED}

      IntOp $R3 $R3 | ${SF_RO}
      IntOp $R3 $R3 | ${SF_SELECTED}

    ${Else}

      IntOp $R1 $R2 & ${SF_RO}
      StrCmp $R1 ${SF_RO} 0 +2
        IntOp $R2 $R2 ^ ${SF_RO}
      IntOp $R1 $R2 & ${SF_SELECTED}
      StrCmp $R1 ${SF_SELECTED} 0 +2
        IntOp $R2 $R2 ^ ${SF_SELECTED}

      IntOp $R1 $R3 & ${SF_RO}
      StrCmp $R1 ${SF_RO} 0 +2
        IntOp $R3 $R3 ^ ${SF_RO}
      IntOp $R1 $R3 & ${SF_SELECTED}
      StrCmp $R1 ${SF_SELECTED} 0 +2
        IntOp $R3 $R3 ^ ${SF_SELECTED}

    ${EndIf}

    SectionSetFlags 0 $R2
    SectionSetFlags 1 $R3

    StrCpy $0 0
    Abort

  ${EndIf}

 FunctionEnd

 # Disable Try Me button for the InstFiles page.
 Function InstFilesShow

  GetDlgItem $R0 $HWNDPARENT ${IDC_BUTTON_TRYME}
  EnableWindow $R0 0

 FunctionEnd

 # Enable Try Me button for the Finish page.
 Function FinishShow

  GetDlgItem $R0 $HWNDPARENT ${IDC_BUTTON_TRYME}
  EnableWindow $R0 1

 FunctionEnd

 Function .onGUIEnd

  # Unload the plugin.
  # If we don't do this, the DLL file remains
  # locked and cannot be deleted.
  ButtonEvent::Unload

 FunctionEnd

; --------------------------------------------------
; Sections.

 # Dummy section.
 Section "Dummy" SecDummy
  Sleep 1000
 SectionEnd

 # Dummy section 2.
 Section "Dummy 2" SecDummy2
  Sleep 1000
 SectionEnd

; --------------------------------------------------
; Section descriptions.

 # Language strings.
 LangString Description_SecDummy ${LANG_ENGLISH}  "Dummy section."
 LangString Description_SecDummy2 ${LANG_ENGLISH} "Dummy section 2."

 # Assign language strings to sections.
 !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
   !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy}  $(Description_SecDummy)
   !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy2} $(Description_SecDummy2)
 !insertmacro MUI_FUNCTION_DESCRIPTION_END