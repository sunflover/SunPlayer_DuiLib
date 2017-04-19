SAFER plug-in

Version: 0.1 - 20061222
Supported on: Win XP/Vista (SAFER::SupportsSAFER call supported on all 32 bit versions) 

The SAFER plugin uses the SAFER api to create a new process with a restricted token. Based on code/info from http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dncode/html/secure11152004.asp 

Supported levels are: 

SAFER_LEVELID_CONSTRAINED
SAFER_LEVELID_UNTRUSTED
SAFER_LEVELID_NORMALUSER


Usage Example :
	# Check for SAFER api support (this call should be supported on any NT system,
	# but not Win9x so check for that before you call this dll (Links directly to CreateProcessAsUser)
	  SAFER::SupportsSAFER 
	# $0 now contains 1 if SAFER is supported or 0 if not  
	 
	#Start calculater with SAFER_LEVELID_CONSTRAINED
	SAFER::Exec CONSTRAINED "calc.exe"