
What Is nsisMultiMon:
---------------------

        nsisMultiMon is a plugin for NSIS (Nullsoft Scriptable Install System) that
        provides easy multi monitor management for installers. With this plugin, you
        can determine the number of monitors, get various coordinates and sizes, 
        monitor namings or simply put the complete installer on another connected
        monitor.  

        nsisMultiMon was tested on Windows 2000 and Windows XP so far.

        Please check out my homepage at http://www.unitedbytes.de or 
        http://nsis.sourceforge.net for further updates of nsisMultiMon.
 

Usage And Installation:
-----------------------

        Simply copy the nsisMultiMon.dll in the "Plugins" folder of the NSIS
        installation directory. If you don't want to put it there, you have to
        add a "!addplugindir" directive on the top of your install script. Read
        the NSIS manual for more information.
       

Functions:
----------
        
        Examples:
               
        Please also consider the provided example script "ExampleMultiMon.nsi" for
        how to use the above functions in a real world installer.
        
        Available functions:
        
        nsisMultiMon::GetAllMonitorCount
        
                Description:
                Returns all available monitors.
                
                Return values:
                $R0 = Number of all available monitors.
        
        ------------------------------------------------------------------------
        
        nsisMultiMon::GetActiveMonitorCount
        
                Description:
                Returns all active monitors.
                
                Return values:
                $R0 = Number of all active monitors.
        
        ------------------------------------------------------------------------
        
        nsisMultiMon::GetVirtualDesktopRect
        
                Description:
                Returns the position and size of the virtual desktop (all monitors).
                
                Return values:
                $R0,$R1 = Start X, Start Y
                $R2,$R3 = Size X, Size Y
        
        ------------------------------------------------------------------------
                        
        nsisMultiMon::GetMonitorRect [ID:int]
                
                Description: 
                Returns the rectangle of the monitor with the given ID (zero-based).
                
                Return values:
                $R0,$R1 = Left, Top
                $R2,$R3 = Right, Bottom
                
        ------------------------------------------------------------------------
                
        nsisMultiMon::GetWorkArea [ID:int]
        
                Description:
                Returns the work area of the monitor with the given ID (zero-based).
                Note: The work area is the "pure" desktop without task bar and other
                status bars docked to the desktop.
                
                Return values:
                $R0,$R1 = Left, Top
                $R2,$R3 = Right, Bottom
        
        ------------------------------------------------------------------------
        
        nsisMultiMon::IsPointOnMonitor [ID:int] [X:int] [Y:int]
        
                Description:
                Verifies if the given point X,Y is on the monitor with the given
                ID (zero-based).
                
                Return values:
                $R0 = "true" means, that the point is on the given monitor. 
                $R0 = "false" means, that the point is NOT on the given monitor.
                
        ------------------------------------------------------------------------                
        
        nsisMultiMon::GetMonitorName [ID:int]
        
                Description:
                Returns the name of the monitor with the given ID (zero-based).
                
                Return values:
                $R0 = Name of the monitor.
                        
        ------------------------------------------------------------------------
        
        nsisMultiMon::CenterInstallerOnMonitor [ID:int] [UseWorkarea:int]
        
                Description:
                Centers the installer window on the monitor with the 
                given ID (zero-based).
                
                If parameter "UseWorkarea" is 0, the window will be centered on
                the monitor's real coordinates & sizes.
                
                If parameter "UseWorkarea" is 1, the window will be centered on
                the monitor's workspace. 
                
                Note: The work area is the "pure" desktop without task bar and other
                status bars docked to the desktop.
        
                Return values:
                None. 
          
        ------------------------------------------------------------------------
               

Version History:
----------------

        v1.1.0 - 06/12/14
        -----------------
        
        - First public version.


License:
--------

        nsisMultiMon is Freeware.


Contact:
--------

        nsisMultiMon was developed in C++ by Andreas Loeffler in December 2006.

        Web: http://www.unitedbytes.de
        E-Mail: info@unitedbytes.de
    
        Stuttgart, Germany, 2006

