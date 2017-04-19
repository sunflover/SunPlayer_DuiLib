
; uninstaller inplace deletion without reboot sample
; works correct if started from link
; not required in most cases, but was interesting for me

!define APP_NAME SelfDel
!define U_N unsd
!define UN_EXE "${U_N}.exe"
!define UN_LNK "${U_N}.lnk"

Name "${APP_NAME}"
OutFile "${APP_NAME}.exe"


Section "Dummy Section" SecDummy
  
; add some install code here

; EXEDIR was used for test purposes only
; _? parameter prevents uninstaller from copy itself to temp folder followed by rm on reboot

  SetOutPath "$EXEDIR\${U_N}"
  WriteUninstaller "$EXEDIR\${U_N}\${UN_EXE}"
  CreateShortCut "$EXEDIR\${UN_LNK}" "$EXEDIR\${U_N}\${UN_EXE}" "_?=$EXEDIR\${U_N}" "$EXEDIR\${U_N}\${UN_EXE}" 0

SectionEnd



Section "Uninstall"

; add some uninstall code here
  Delete "..\${UN_LNK}" ; strange, but relative path works

SectionEnd

Function un.onGUIEnd

; /RMDIR works if uninstaller is the only file in the folder at this moment
; so remove other files first in uninstall section
; LNK defined, current directory is new uninstaller' $EXEDIR, i.e. ${U_N}

  SetOutPath "$WINDIR"  ; otherwise it not removes current folder..
  SelfDel::del /RMDIR

FunctionEnd