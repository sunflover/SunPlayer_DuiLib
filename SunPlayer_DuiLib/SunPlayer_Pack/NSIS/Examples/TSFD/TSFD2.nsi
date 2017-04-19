!include "MUI.nsh"
!include nsDialogs.nsh
!include LogicLib.nsh
!include winmessages.nsh

Var INST_SDAT_LOC1
Var INST_SDAT_BTN1

Name "test"
OutFile "nsDialogFileBrowse.exe"

Page custom SettingsPage

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

Function SettingsPage
	nsDialogs::Create /NOUNLOAD 1018
	Pop $0

	;; Only looking inside a specific folder
	${NSD_CreateBrowseButton} 410 130 25 12u "..."
	Pop $INST_SDAT_BTN1
	nsDialogs::SetUserData /NOUNLOAD $INST_SDAT_BTN1 FileRequest # remember field id

	GetFunctionAddress $0 FolderBrowseButton
	nsDialogs::OnClick /NOUNLOAD $INST_SDAT_BTN1 $0

	${NSD_CreateFileRequest} 110 130 300 12u ""
	Pop $INST_SDAT_LOC1

	nsDialogs::Show
FunctionEnd

Function FolderBrowseButton
	StrCpy $2 "C:\Windows\System32\"
	tSFD::SelectFileDialog /NOUNLOAD open $2 "*.exe|*.exe"
	Pop $2
	${If} $2 != ""
		SendMessage $INST_SDAT_LOC1 ${WM_SETTEXT} 0 STR:$2
	${EndIf}
FunctionEnd

Section
SectionEnd