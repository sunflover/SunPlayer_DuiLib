
!define APP_NAME fct
!define WND_CLASS "IEFrame"
!define TITLE_PART "Internet Explorer"
!define termMsg "Installer cannot stop running ${TITLE_PART}.$\nClick YES to terminate application."

!include WinMessages.nsh

Name "${APP_NAME}"
OutFile "${APP_NAME}.exe"



Section "Dummy Section" SecDummy
  
    fct::fct /WC '${WND_CLASS}' /TIMEOUT 2000 /SCCLOSE /QUESTION '${termMsg}'

    Pop $0
    MessageBox MB_OK "Still Alive Count = $0"

SectionEnd