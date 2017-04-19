!define PROD_NAME "SAFER Tester App"
Name "${PROD_NAME}"
OutFile "@${PROD_NAME}.exe"
ShowInstDetails show


Section
SAFER::SupportsSAFER
DetailPrint "OS supports SAFER API: $0"
strcmp $0 1 +2
abort

goagain:
!define exec 'calc' #'notepad.exe "c:\somefile.txt"'
MessageBox MB_ABORTRETRYIGNORE|MB_ICONQUESTION \
'Choose SAFER Level to execute ${exec}$\n$\nAbort=NORMAL$\nRetry=CONSTRAINED$\nIgnore=UNTRUSTED' \
IDIGNORE ignore IDRETRY retry
StrCpy $0 NORMAL
goto exec
ignore:
StrCpy $0 UNTRUSTED
goto exec
retry:
StrCpy $0 CONSTRAINED
exec:
DetailPrint 'Executing >>${exec}<< as $0'
SAFER::Exec $0 '${exec}'
DetailPrint "...returned $0"
MessageBox MB_YESNO|MB_ICONQUESTION "Execute again?" IDYES goagain
SectionEnd

Page InstFiles