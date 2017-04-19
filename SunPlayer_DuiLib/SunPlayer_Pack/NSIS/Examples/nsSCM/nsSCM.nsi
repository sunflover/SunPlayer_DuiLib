SetCompressor /SOLID lzma
SetCompress force
XPStyle on
OutFile "nsSCM Example.EXE"
Name "nsSCM Example"
Section
/*
; Turn off old selected section
; Methods:
  ; 1 str	2 str 3 num 4 num 5 str 6 str 7 str 8 str 9 str
  ; [name of service: startstop name] [name to display: display in SCM]
  ;    [service type] [start type] [service's binary:filepath]
  ;    [load order group: name] [dependencies: name] [account: name] [password: str]
  nsSCM::Install /NOUNLOAD [parameters]
  Pop $0 ; return error/success
 
  ; [name of service:startstop name]
  nsSCM::Start /NOUNLOAD [parameters]
  Pop $0 ; return error/success
 
  ; [name of service:startstop name]
  nsSCM::QueryStatus /NOUNLOAD [parameters]
  Pop $0 ; return error/success
  Pop $1 ; return service status

  ;!define SERVICE_STOPPED                0x00000001
  ;!define SERVICE_START_PENDING          0x00000002
  ;!define SERVICE_STOP_PENDING           0x00000003
  ;!define SERVICE_RUNNING                0x00000004
  ;!define SERVICE_CONTINUE_PENDING       0x00000005
  ;!define SERVICE_PAUSE_PENDING          0x00000006
  ;!define SERVICE_PAUSED                 0x00000007
 
  ; [name of service:startstop name]
  nsSCM::Stop /NOUNLOAD [parameters]
  Pop $0 ; return error/success
 
  ; [name of service:startstop name]
  nsSCM::Remove /NOUNLOAD [parameters]
  Pop $0 ; return error/success
 */
; Samples:
  ; Driver (boot stage starting)
  nsSCM::Install /NOUNLOAD "XXX" "XXX driver" 1 0 \
                           "$SYSDIR\drivers\XXX.sys" "" "" "" ""
  Pop $0 ; return error/success
 
  ; Driver (sscm stage starting)
  nsSCM::Install /NOUNLOAD "XXX" "XXX driver" 1 1 \
                           "$SYSDIR\drivers\XXX.sys" "" "" "" ""
  Pop $0 ; return error/success
 
  ; Driver (manual starting)
  nsSCM::Install /NOUNLOAD "XXX" "XXX driver" 1 3 \
                           "$SYSDIR\drivers\XXX.sys" "" "" "" ""
  Pop $0 ; return error/success
 
  ; Service (auto starting)
  nsSCM::Install /NOUNLOAD "XXX" "XXX service" 16 2 \
                           "$PROGRAMFILES\${PRJ_NAME}\XXX.exe" "" "" "" ""
  Pop $0 ; return error/success
 
; Service (auto starting WITH DESKTOP INTERACTION)
  nsSCM::Install /NOUNLOAD "XXX" "XXX service" 272 2 \
                           "$PROGRAMFILES\${PRJ_NAME}\XXX.exe" "" "" "" ""
  Pop $0 ; return error/success
 
  ; Service (manual starting)
  nsSCM::Install /NOUNLOAD "XXX" "XXX service" 16 3 \
                           "$PROGRAMFILES\${PRJ_NAME}\XXX.exe" "" "" "" ""
  Pop $0 ; return error/success
 
  nsSCM::Start /NOUNLOAD "XXX"
  Pop $0 ; return error/success
 
  nsSCM::QueryStatus /NOUNLOAD
  Pop $0 ; return error/success
  Pop $1 ; return service status
 
  IntCmp $1 4 lbl_Return ; check on running
  lbl_Return:
SectionEnd
