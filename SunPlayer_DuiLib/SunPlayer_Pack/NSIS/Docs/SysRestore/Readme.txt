System Restore Plugin for NSIS

2005 - 2006 MouseHelmet Software

Author: Jason Ross aka JasonFriday13 on the forums

Will only work on Windows Me and Windows XP.

Updated 8th November 2007

Introduction
~~~~~~~~~~~~

This plugin was written because I noticed other installers set a restore point
when they were run, so I set about writing a plugin for NSIS that does the same.

Functions
~~~~~~~~~

Note: Avoid renaming files on windows ME as NSIS does not callback the function
(like Quit does not return after being called) after a reboot. Because of this,
FinishRestorePoint cannot be called after a reboot to finish setting up the restore point.

SysRestore::StartInstallPoint /NOUNLOAD TEXT

SysRestore::StartUninstallPoint /NOUNLOAD TEXT
	
	Starts the restore point. TEXT is the description of the restore
	point. Recommended text: "Installed $(^Name)" or "Uninstalled $(^Name)"
	for the uninstaller. I recommend putting this call at the start of a
	section. This function must be called with the /NOUNLOAD switch. 
	Returns on the top of the stack. Except for 0, the error indicates 
	the function failed to set a restore point. Here is a list of the 
	possible return values:
 
	0	The function was successful.

	1	Start point already set (start function only).

	10 	The system is running in safe mode. 
	
	13 	The sequence number is invalid. Either the last restore point
    operation failed or the restore point with the sequence number
    no longer exists.

	80	Windows Me: Pending file-rename operations exist in the 
		file %windir%\Wininit.ini.	

	112	System Restore is in standby mode because disk space is low. 
		Windows Me:  This value is not supported. 
				
	1058	System Restore is disabled. 
	
	1359  	An internal error with system restore occurred.	

	1460 	The call timed out due to a wait on a mutex for setting restore points.

	Note: I don't know if these are the actual error codes, I just seached 
	the platform sdk include files for the defines shown in the platform sdk help.
	I have tested on the university computers and it returned a 1058 code which is
	system restore is disabled, and I have tested in safe mode and this gave me
	an error code of 10, so I am guessing that the codes are correct.

SysRestore::FinishRestorePoint [/NOUNLOAD]

	Closes the restore point. Required, because then system restore knows
	what files have been added/changed/removed. Returns the same codes above, 
	as well as an extra return value:

	2	Start point not set.

	I recommend putting this call at the end of the last section. Does not require 
	the /NOUNLOAD switch. Only use /NOUNLOAD if you may need to remove the restore
  point later.

SysRestore::RemoveRestorePoint

  Removes the last restore point started or created.
  Returns the same codes above, as well as an extra return value:

	3	Restore point not started.

  /NOUNLOAD should not be used.

SysRestore::Unload

  Unloads the plugin in case the last plugin call used the /NOUNLOAD switch.
  Unloading is required to allow the plugin to be deleted on reboot.

Change Log
~~~~~~~~~~

  v1.2 - 8th November 2007 ~ Afrow UK
   * 'Start point set' bool was being set to true even if system restore point
     creation failed.

  v1.1 - 25th October 2007 - Afrow UK
   * Added Unload and RemoveRestorePoint functions.

  v1.0 - 15th June 2006
   * Original version.