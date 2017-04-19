================================================================================
= tSFD - 1.0 2008-08-31
=
= Select File Dialog plugin for NSIS
================================================================================

This plugin is intended as a replacement for the SelectFileDialog function in
the nsDialogs plugin.

I have added a feature that lets you select what folder you want to start
looking for the file in.

= Purpose
================================================================================

Displays a file selection dialog to the user. It can either be a file save
dialog or a file open dialog.

= Syntax
================================================================================

tSFD::SelectFileDialog /NOUNLOAD mode initial_selection filter

It must be called with the /NOUNLOAD flag.

    mode
        Can be either "save" or "open"

    initial_selection
        Can be used to provide the user with a default file to look for and/or
        a default folder to look in.

        If it is empty no default filename will be provided for the user and
        the dialog will start in the current working directory.

        If it specifies just a filename, for example "test.exe", the dialog
        will be set up to look for a file called test.exe in the current
        working directory.

        If it specifies just a directory, for example "C:\Program Files\", the
        dialog starts in the provided directory with no file name provided.

        If it specifies a directory and a filename, for example
        "C:\Windows\System32\calc.exe", the dialog will be set up to look for a
        file called calc.exe in the directory C:\Windows\System32\.

    filter
        Can be used to filter out what file types are displayed in the dialog.
        It should be a list of available file filters separated by pipes. If an
        empty string is passed, the default is used - All Files|*.*

= Return value
================================================================================

Returns the selected file on the stack or an empty string if the user canceled
the operation.

= Example code
================================================================================

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