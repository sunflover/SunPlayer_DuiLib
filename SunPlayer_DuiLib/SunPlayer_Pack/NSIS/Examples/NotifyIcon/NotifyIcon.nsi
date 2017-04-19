; By brainsucker, updated by Afrow UK
; Shows installation progress as NotifyIcon

Name "NotifyIcon Example"
OutFile "notifyicon.exe"
Icon "${NSISDIR}\Contrib\Graphics\Icons\modern-install-colorful.ico"
XPStyle on

Section "ThisNameIsIgnoredSoWhyBother?"

 InitPluginsDir

 NotifyIcon::Icon /NOUNLOAD "iy" 103
 NotifyIcon::Icon /NOUNLOAD "b" "NSIS installer" "Starting installation..."
 NotifyIcon::Icon /NOUNLOAD "p" "Completed %d%%"
 Sleep 4000

 NotifyIcon::Icon /NOUNLOAD "!pt" "Tip is back!"   
 Sleep 2000

 File "/oname=$PLUGINSDIR\icon.ico" "${NSISDIR}\Contrib\Graphics\Icons\modern-install-colorful.ico"
 NotifyIcon::Icon /NOUNLOAD ".fb" "$PLUGINSDIR\icon.ico" "NSIS installer" "Installation is finished!"
 Sleep 3000

 NotifyIcon::Icon /NOUNLOAD "f" "$PLUGINSDIR\icon.ico"
 Sleep 4000

SectionEnd

Function .onGUIEnd
 NotifyIcon::Icon "r"
FunctionEnd

; eof
