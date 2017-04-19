SetCompressor /SOLID lzma
SetCompress force
XPStyle on
OutFile "TCP Example.EXE"
Name "TCP Example"
Section
StrCpy $1 80

validate_port:
  TCP::CheckPort $1
  Pop $0
  StrCmp $0 "free" port_ok
  StrCmp $0 "socket_error" socket_error
  StrCmp $0 "inuse" socket_inuse
  Goto port_ok
socket_inuse:
  MessageBox MB_OK "端口正在被程序使用."
  Abort
socket_error:
  MessageBox MB_OK "非法 TCP 端口号. 端口号必须在 1 至 65535 之间."
  Abort
port_ok:
SectionEnd
