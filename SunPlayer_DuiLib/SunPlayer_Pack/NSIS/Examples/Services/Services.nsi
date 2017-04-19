OutFile services.exe
Section
  services::IsProcessUserAdministrator
  Pop $0
  MessageBox MB_OK|MB_ICONINFORMATION 'Admin? $0'
  services::IsServiceRunning 'beep'
  Pop $0
  MessageBox MB_OK|MB_ICONINFORMATION 'Running? $0'
  services::IsServiceInstalled 'beep'
  Pop $0
  MessageBox MB_OK|MB_ICONINFORMATION 'Installed? $0'
  services::RemoveLogonAsAService 'username'
  Pop $0
  MessageBox MB_OK|MB_ICONINFORMATION 'Removed? $0'
  services::GrantLogonAsAService 'username'
  Pop $0
  MessageBox MB_OK|MB_ICONINFORMATION 'Granted? $0'
  services::HasLogonAsAService 'username'
  Pop $0
  MessageBox MB_OK|MB_ICONINFORMATION 'Has Grant? $0'
  services::SendServiceCommand 'stop' 'beep'
  Pop $0
  MessageBox MB_OK|MB_ICONINFORMATION 'Stopped? $0'
SectionEnd