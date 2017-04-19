
What Is nsisUser:
-----------------

        nsisUser is a plugin for NSIS (Nullsoft Scriptable Install System) that
        provides easy user management and checking functions for Windows 2000
        and Windows XP (Vista not tested yet).
        
        For now, it only consists of only one function; I'll add more functionalities
        when I need them (or you request them of course). I needed a simple plugin to
        proof the identity and working status of several user accounts to assure running
        different operations with administrative rights by simple guessing some possible
        accounts that maybe exists on that machine. 
          
        nsisUser was tested on Windows 2000 and Windows XP so far.

        Please check out my homepage at http://www.unitedbytes.de or 
        http://nsis.sourceforge.net for further updates of nsisUser.
 

Usage And Installation:
-----------------------

        Simply copy the nsisUser.dll in the "Plugins" folder of the NSIS
        installation directory. If you don't want to put it there, you have to
        add a "!addplugindir" directive on the top of your install script. Read
        the NSIS manual for more information.
       

Functions:
----------
        
        Examples:
               
        Please also consider the provided example script "ExampleUser.nsi" for
        how to use the above functions in a real world installer.
        
        Available functions:
        
        nsisUser::IsLoginValid [Username:string] [Domain:string] [Password:string]
        
                Description:                
                Verifies if the specified user can login with the provided data.
                
                Return values:
                $R0 = "true" means, that a login is possible and valid. 
                $R0 = "false" means, that there went something wrong.
                
                Notes:
                If you don't have a domain, use "." instead. The local user account
                database will be used then.
                         
        ------------------------------------------------------------------------
               

Version History:
----------------

        v1.2.0 - 07/09/26
        -----------------
        
        - Improved: Support for Windows 2000.
       
        v1.0.0 - 07/08/19
        -----------------
        
        - First public version.


License:
--------

        nsisUser is Freeware.


Contact:
--------

        nsisUser was developed in C++ by Andreas Loeffler in August 2007.

        Web: http://www.unitedbytes.de
        E-Mail: info@unitedbytes.de
    
        Stuttgart, Germany, 2007

