
!define APP_NAME fct
!define WND_CLASS "Outlook Express Browser Class"
!define CLASS_PART "Browser Class"
!define WND_TITLE "Outlook Express"
!define TITLE_PART "Express"
!define termMsg "Installer cannot stop running ${WND_TITLE}.$\nClick YES to terminate application."

!include WinMessages.nsh

Name "${APP_NAME}"
OutFile "${APP_NAME}.exe"


;  fct::fct [/NOUNLOAD] [/WC CLASS | /WCP CLASS_PART]  [/WT WINDOW_TITLE | /WTP TITLE_PART] [/ASYNC] [/MSGONLY] [/SCCLOSE] [/UDATA xxx] [/TIMEOUT xxxx] [/QUESTION CANNOT_CLOSE] [/END]

; /WC or /WCP defines full or partial window class
; /WT or /WTP defines full or partial window title
; /UDATA limits windows to be closed with having this GWL_USERDATA value (mainly for Dialog and .NET Form classes based apps).
; For example /udata=0x4d475201
; sync call returns count of still running applications. the same value returns 'wait' call in async mode
; /ASYNC 'fct' call returns thread_handle to be used with 'wait' call. You can start few async threads.
; Default timeout 1000 ms, plug-in uses it first when sending WM_CLOSE, then in WaitForSingleObject() call
; so maximum delay may be up to double timeout value.
; if /QUESTION defined and application not exits after wm_close, plug-in popups message box with 
; this question (but not in silent mode). Use DetailPrint before plug-in call to set current operation description.
; /MSGONLY - not attempts to terminate process.
; /SCCLOSE - uses WM_SYSCOMMAND SC_CLOSE instead of WM_CLOSE (for Windows Explorer).

;  fct::wait THREAD_HANDLE
; waits for plug-in exit and returns count of still running apps with predefined class/title



Section "Dummy Section" SecDummy
  
; async termination, requires /nounload
#    fct::fct /nounload /WCP '${CLASS_PART}' /WTP '${TITLE_PART}' /ASYNC /TIMEOUT 500 /QUESTION '${termMsg}'
;    Place your code here. We skipped thread_handle Pop and Push - it sits in the stack between calls. 
#    fct::wait

; sync termination
#    fct::fct /WC '#32770' /UDATA 0x4d475200
    fct::fct /WC '${WND_CLASS}' /WTP '${TITLE_PART}' /TIMEOUT 2000 /QUESTION '${termMsg}'

    Pop $0
    MessageBox MB_OK "Still Alive Count = $0"

SectionEnd