nsisDDE -- Small NSIS plugin to sends DDE client requests
Web site: http://wiz0u.free.fr/prog/nsisDDE
---------------------------------------------------------

nsisDDE sends DDE client requests to currently running applications with DDE
server matching the "server application name / topic name" pair you provide

You can typically use it to:
- close running instances of an application (eg: to prevent EXE and DLL to be in use)
- bring a running application to the foreground
- have an application open a document


Notes
-----
* For unicity, if you include a DDE server in your application, it is better to
	name it with a globally unique identifier generated with GUIDGEN like
	"YourAppName-{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}", instead of a short name
	like "WinWord"
* nsisDDE makes ANSI DDE requests (to be compatible with non-Unicode apps)
* According to DDE specifications, DDE servers (even Unicode apps) should answer
	to ANSI DDE client requests using ANSI strings.
	However MFC42 has a bug in CFrameWnd::OnDDEExecute if compiled with UNICODE
	because it assumes the request is in Unicode. Therefore, if your application
	is using MFC42 in Unicode, you should have your own OnDDEExecute handler and
	add the following lines before the lstrcpyn:
		#ifdef UNICODE
			if (!IsWindowUnicode((HWND) wParam))
				MultiByteToWideChar(CP_ACP, 0, (LPCSTR) lpsz, -1, szCommand, _MAX_PATH);
			else
		#endif


Usage
-----
nsisDDE::Execute [<options>] "<appname>" "<commands>"

<appname> is the name the application uses for its DDE requests
	(this is not case sensitive and not necessarily the name of the program executable)
	ex: Excel, IExplore, ...

<commands> can be any valid DDE request, specific to the application
	(this is usually one or more opcode strings enclosed in single brackets [...])
	ex: [open("%1")][print()], [SetForeground], [Quit]...

<options> are:
			if many running applications respond to the appname/topic pair,
	/ALL	send the request to all of them (default)
	/FIRST	send the request only to the first of them that responded
	/LAST	send the request only to the last of them that responded
		note: this is not necessarily the instance runned first or last

	/TOPIC=<topicname>
			indicates the DDE topic name (default is "System")
			(this is not case sensitive)
			
	/TIMEOUT=<seconds>
			if some applications are hung or takes too much time to reply,
			or on the contrary, you want to give them more time to reply,
			the timeout defines the maximum time nsisDDE will wait (default is 2)

Return Value
------------

nsisDDE returns an integer status on the top of the stack
Possible status are:
	0:  No matching DDE server was detected or they refused the request
	>0: number of DDE servers that were detected and accepted the request
			(if /FIRST or /LAST was used, it cannot obviously be more than 1)
	-1: Invalid option parameter
	-2: Not enough parameters
	-3: Could not create DDE client window


Sample scripts
--------------
	; close WinWord
	nsisDDE::Execute "WinWord" "[FileQuit()]"

	; leave 5 seconds maximum for apps to responds
	; (used only if some apps are hung or takes time to poll their message queue)
	nsisDDE::Execute /TIMEOUT=5 "WinWord" "[FileQuit()]"

	; some apps like MS-Access expect another topic than "System"
	nsisDDE::Execute /TOPIC=ShellSystem "Msaccess" "[SetForeground]"


License
-------
Copyright (c) 2005 Olivier Marcoux

This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software.

Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.

    2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.

    3. This notice may not be removed or altered from any source distribution.
