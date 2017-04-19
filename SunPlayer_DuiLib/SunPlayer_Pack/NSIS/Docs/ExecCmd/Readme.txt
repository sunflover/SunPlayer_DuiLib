ExecCmd

Description 
Plug-in works with console applications - creates hidden child process with stdin from file (<stdin.txt) or sends stdin string to console window using WM_CHAR messages. Second method is more secure (for passwords) but does not work on Win98 and earlier systems. On Win98 exit code (Pop value) may be not correct as well. Plug-in has sync and async (background) process launch option - async is good for long running applications and for few applications running at the same time. It works out of section - for .onInit check outs. Maximum input (stdin) string size (i.e. plug-in second parameter) is up to 8kB in the special NSIS build, 1 kB otherwise.
'exec' return code depends on the execution mode: application exit code for sync mode and control thread handle for async one. Handle required for 'wait' - it helps to understand what application exit to wait for. If stack is not used between 'exec' and 'wait', both Pop after 'exec' and 'wait' parameter may be skipped - handle just sits in the stack.
Plug-in adds 'ComSpec' env. variable with /C key at the beginnig of the command line, this may additionally limit command line length. Current version was tested on XP - 2003. 
___________________________________
Syntax 
_______
	ExecCmd::exec [/NOUNLOAD /ASYNC] [/TEST] [/TIMEOUT=xxx] application_to_run stdin_stringExecutes console application. 
	
ASYNC 
	Not waits for process exit. Use 'wait' call if you want to get exit code. (/NOUNLOAD is mandatory!) 
TEST 
	Console window is visible with this key. 
TIMEOUT 
	TOTAL execution time, milliseconds, for example /TIMEOUT=10000. Default is big enough. Short timeouts may cause app to be terminated. 
application_to_run 
	application to run. 
stdin_string 
	all that application can get from stdin 
"wait" DLL function 
ExecCmd::wait handleWaits for process exit. 
handle 
Control thread handle returned by 'exec' call in the /ASYNC mode. 
___________________________________
Example 
_______Async execution with stdout to file: 

	ExecCmd::exec /NOUNLOAD /ASYNC /TIMEOUT=2000 \
		'"$EXEDIR\consApp.exe" >ExecCmd.log' "test_login$\r$\ntest_pwd$\r$\n"
	Pop $0 # thread handle for wait
	# you can add some installation code here to execute while application is running.
	ExecCmd::wait $0
	Pop $0 # return value
	MessageBox MB_OK "Exit code $0"Sync execution: 
___________________________________	
______Sync execution: 

ExecCmd::exec /TIMEOUT=2000 '"$EXEDIR\consApp.exe"' "test_login$\r$\ntest_pwd$\r$\n"
Pop $0 ; return value - process exit code or error or STILL_ACTIVE (0x103).
MessageBox MB_OK "Exit code $0"
___________________________________	

BAT files specifics:

On some of Win98 systems where "Close on exit" option is not set for DOS apps it was found 

that after batch execution was finished (and installer continue it's job) hidden window still remains in the system 

as "winoldapp". Following two lines solve the problem 

@echo off
# place your code here
cls
