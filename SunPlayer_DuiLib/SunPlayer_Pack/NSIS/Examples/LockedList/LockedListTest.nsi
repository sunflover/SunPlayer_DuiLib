!include MUI.nsh
!include LogicLib.nsh
!include WinVer.nsh

Name LockedListTest
OutFile LockedListTest.exe

ShowInstDetails show
Page Custom LockedListPageShow
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE English

ReserveFile "${NSISDIR}\Plugins\LockedList.dll"

Function .onInit

  ${Unless} ${AtLeastWinNt4}
    MessageBox MB_OK|MB_ICONSTOP "You cannot run this installer on < Win NT"
    Abort
  ${EndUnless}

  InitPluginsDir

  !tempfile TEMP
  !appendfile `${TEMP}` `!include MUI.nsh$\r$\n`
  !appendfile `${TEMP}` `Name LockFile$\r$\n`
  !appendfile `${TEMP}` `Caption "File locked for testing"$\r$\n`
  !appendfile `${TEMP}` `OutFile ${TEMP}.exe$\r$\n`
  !appendfile `${TEMP}` `!insertmacro MUI_PAGE_INSTFILES$\r$\n`
  !appendfile `${TEMP}` `!insertmacro MUI_LANGUAGE "English"$\r$\n`
  !appendfile `${TEMP}` `Function .onInit$\r$\n`
  !appendfile `${TEMP}` `FileOpen $R0 "$TEMP\Lock" w$\r$\n`
  !appendfile `${TEMP}` `MessageBox MB_OK "Click OK to unlock the file $EXEDIR\Lock."$\r$\n`
  !appendfile `${TEMP}` `FileClose $R0$\r$\n`
  !appendfile `${TEMP}` `Abort$\r$\n`
  !appendfile `${TEMP}` `Delete "$EXEDIR\Lock"$\r$\n`
  !appendfile `${TEMP}` `FunctionEnd$\r$\n`
  !appendfile `${TEMP}` `Section$\r$\n`
  !appendfile `${TEMP}` `SectionEnd$\r$\n`
  !execute `"${NSISDIR}\makensis.exe" "${TEMP}"`
  File /oname=$PLUGINSDIR\LockFile.exe `${TEMP}.exe`
  !delfile `${TEMP}`

  Exec "$PLUGINSDIR\LockFile.exe"

  Sleep 1000
  BringToFront

FunctionEnd

Function LockedListPageShow

  !insertmacro MUI_HEADER_TEXT "LockedList dialog" "This is a list of programs that have our files held hostage..."

  LockedList::AddFile /NOUNLOAD $TEMP\Lock
  LockedList::Dialog /ignore ``

FunctionEnd

Section "Threading test" Section_ThreadTest

  DetailPrint "Testing LockedList with threading..."

  LockedList::AddFile /NOUNLOAD $TEMP\Lock
  LockedList::AddModule /NOUNLOAD "$PLUGINSDIR\LockedList.dll"

  # Begin the search in a separate thread.
  LockedList::SilentSearch /NOUNLOAD /thread

  SetDetailsPrint textonly
  ${Do}

    # What is the current status?
    LockedList::SilentPercentComplete /NOUNLOAD
    Pop $R0
    DetailPrint "Searching... $R0%"

    # Wait a maximum of 500ms.
    LockedList::SilentWait /NOUNLOAD /time 500
    Pop $R0

  ${LoopWhile} $R0 == "/wait"
  SetDetailsPrint both

  DetailPrint "Searching... 100%"

  # Done with the plugin.
  LockedList::Unload

  # Retrieve stack items.
  # First item on stack is /start, next one may be /end if no files found.
  Pop $R0
  ${DoWhile} $R0 != "/end"

    Pop $R0 # Process identity
    DetailPrint "Process id: $R0"

    Pop $R0 # Process full path
    DetailPrint "Process path: $R0"

    Pop $R0 # Process window caption
    DetailPrint "Process caption: $R0"

    Pop $R0

  ${Loop}

  DetailPrint ""

SectionEnd

Section "Normal test" Section_NormalTest

  DetailPrint "Testing LockedList, please wait..."

  LockedList::AddFile /NOUNLOAD $PLUGINSDIR\Lock
  LockedList::AddModule /NOUNLOAD "$PLUGINSDIR\LockedList.dll"

  # Begin the search now.
  LockedList::SilentSearch

  DetailPrint "Searching... 100%"

  # Retrieve stack items.
  # First item on stack is /start or /end if no files found.
  Pop $R0
  ${DoWhile} $R0 != "/end"

    Pop $R0 # Process identity
    DetailPrint "Process id: $R0"

    Pop $R0 # Process full path
    DetailPrint "Process path: $R0"

    Pop $R0 # Process window caption
    DetailPrint "Process caption: $R0"

    Pop $R0

  ${Loop}

  DetailPrint ""

SectionEnd

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${Section_ThreadTest} "Tests LockedList with a separate thread showing progress indication."
  !insertmacro MUI_DESCRIPTION_TEXT ${Section_NormalTest} "Calls LockedList and waits for it to finish."
!insertmacro MUI_FUNCTION_DESCRIPTION_END