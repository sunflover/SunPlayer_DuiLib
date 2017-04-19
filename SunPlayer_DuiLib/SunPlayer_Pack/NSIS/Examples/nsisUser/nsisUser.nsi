
/******************************************************************
(C) Copyright 2007 by Andreas Loeffler / United Bytes.

web:  http://www.unitedbytes.de
mail: info@unitedbytes.de

*******************************************************************

@file		ExampleMultiMonitor.nsi
@version	1.0
@date		19.08.07
@author		Andreas Loeffler

@brief      An example installer for the nsisUser plugin.
@remarks    -

******************************************************************/

;!addplugindir "Debug"         ; Only needed for development!

Function .onGUIInit

FunctionEnd

Name "ExampleUser"
Caption "Example For User Plugin"
OutFile "ExampleUser.exe"

InstallDir "$PROGRAMFILES\NSIS\Examples\UserInstall"

Section "Example"

	SetOutPath $INSTDIR
	
	;///////////////////////////////////////////////////////////////////////
        
        Push $R0                                        ; Save original content of $R0

        ; Check if the user "foo" with password "bar" can log in.
        ; Note that we don't use a domain here, so we have to use "." for the domain name!    
        ; Since you surely don't have a user called "foo" on your system, the function returns
        ; always "false". To get a positive result, enter real user data that's existing on this
        ; machine.
            
        nsisUser::IsLoginValid "foo" "." "bar"
        MessageBox MB_OK "Login is valid: $R0"
        
        Pop $R0                                         ; Restore original content of $R0
	
    ;///////////////////////////////////////////////////////////////////////
    
        MessageBox MB_OK "Thanks for watching this little demo! Developed by Andreas Loeffler in 2007."

SectionEnd
