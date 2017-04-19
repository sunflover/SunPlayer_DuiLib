TCP plug-in

Description :
I made this little plugin to be able to check for TCP ports that our server software can use. There is currently only one function that checks if a port is already in use or not, but it is useful.
Created by Daniel Rejment. 


Sample Usage :
	validate_port:
	  TCP::CheckPort $1
	  Pop $0
	  StrCmp $0 "free" port_ok
	  StrCmp $0 "socket_error" socket_error
	  StrCmp $0 "inuse" socket_inuse
	  Goto port_ok
	socket_inuse:
	  MessageBox MB_OK "The Port is in use by another application."
	  Abort
	socket_error:
	  MessageBox MB_OK "Invalid TCP Port number. It should be an integer between 1 and 65535."
	  Abort
	port_ok: