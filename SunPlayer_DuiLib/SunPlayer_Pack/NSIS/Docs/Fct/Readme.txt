fct
¹Ø±Õ´°¿Ú²å¼þ

fct::fct [/NOUNLOAD] [/WC CLASS | /WCP CLASS_PART]  [/WT WINDOW_TITLE | /WTP TITLE_PART] [/ASYNC] [/MSGONLY] [/SCCLOSE] [/UDATA xxx] [/TIMEOUT xxxx] [/QUESTION CANNOT_CLOSE] [/END]

/WC or /WCP defines full or partial window class
/WT or /WTP defines full or partial window title
/UDATA limits windows to be closed with having this GWL_USERDATA value (mainly for Dialog and .NET Form classes based apps).
For example /udata=0x4d475201
sync call returns count of still running applications. the same value returns 'wait' call in async mode
/ASYNC 'fct' call returns thread_handle to be used with 'wait' call. You can start few async threads.
Default timeout 1000 ms, plug-in uses it first when sending WM_CLOSE, then in WaitForSingleObject() call
so maximum delay may be up to double timeout value.
if /QUESTION defined and application not exits after wm_close, plug-in popups message box with 
this question (but not in silent mode). Use DetailPrint before plug-in call to set current operation description.
/MSGONLY - not attempts to terminate process.
/SCCLOSE - uses WM_SYSCOMMAND SC_CLOSE instead of WM_CLOSE (for Windows Explorer).

fct::wait THREAD_HANDLE
waits for plug-in exit and returns count of still running apps with predefined class/title
