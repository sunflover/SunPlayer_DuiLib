SelfDel Plug-In
Plug-in for setup in place deletion without exe copy or reboot. 


Description :
Plug-in launches hidden Window Explorer, it waits installer (uninstaller) to finish and deletes exe. Optionaly removes exe' directory. After this Explorer exits as well.

Syntax :
SelfDel::del [/RMDIR]



Creates remote thread in the hidden Windows Explorer process, it waits parent process to exit and deletes it's file. 

RMDIR :	if exe' directory is empty after file deletion, removes directory as well with this option. 



Example :

	Function .onInstSuccess
	SelfDel::del
	FunctionEnd