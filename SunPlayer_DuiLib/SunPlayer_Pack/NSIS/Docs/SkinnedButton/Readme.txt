Skinned Button 1.1 - Read Me
----------------------------


This plugin for NSIS is based on the wansis plug-in of Saivert and can skin all buttons of your installer.
It was developed with an aim of integrate it in UltraModernUI, an new user interface with a style like the most recent installers for NSIS. (http://www.ultramodernui.com4.ws)



USAGE without Modern UI
-----------------------

See Example.nsi in the Examples\skinnedbutton directory

_ First, in the .onInit function, extract the button bitmap:

	Function .onInit
		InitPluginsDir
		File "/oname=$PLUGINSDIR\button.bmp" "${NSISDIR}\Contrib\skinnedbutton\skins\ishield.bmp"
	FunctionEnd


_ Second, in the .onGUIInit function, it is time to let the plugin do the work

	Function .onGUIInit
		skinnedbutton::skinit /NOUNLOAD "$PLUGINSDIR\button.bmp"
		Pop $0
		StrCmp $0 "success" noerror
			MessageBox MB_ICONEXCLAMATION|MB_OK "skinned button error: $0"
		noerror:
	FunctionEnd


_ Finally, in the .onGUIEnd function, it is time to kill the plugin.

	Function .onGUIEnd
		skinnedbutton::unskinit
	FunctionEnd


_ It's the same thing for the uninstaller:

	Function un.onInit
		InitPluginsDir
		File "/oname=$PLUGINSDIR\button.bmp" "${NSISDIR}\Contrib\skinnedbutton\skins\ishield.bmp"
	FunctionEnd

	Function un.onGUIInit
		skinnedbutton::skinit /NOUNLOAD "$PLUGINSDIR\button.bmp"
		Pop $0
		StrCmp $0 "success" noerror
			MessageBox MB_ICONEXCLAMATION|MB_OK "skinned button error: $0"
		noerror:
	FunctionEnd

	Function un.onGUIEnd
		skinnedbutton::unskinit
	FunctionEnd


_ That's all!



USAGE with Modern UI
--------------------

See Example_MUI.nsi in the Examples\skinnedbutton directory

_ First, in the .onInit function, extract the button bitmap:

	Function .onInit
		InitPluginsDir
		File "/oname=$PLUGINSDIR\button.bmp" "${NSISDIR}\Contrib\skinnedbutton\skins\ishield.bmp"
	FunctionEnd


_ Second, create a function, for example, named myGUIInit

	Function myGUIInit
		skinnedbutton::skinit /NOUNLOAD "$PLUGINSDIR\button.bmp"
		Pop $0
		StrCmp $0 "success" noerror
			MessageBox MB_ICONEXCLAMATION|MB_OK "skinned button error: $0"
		noerror:
	FunctionEnd
	
   And add this line before the insertion of  macro page. 

  !define MUI_CUSTOMFUNCTION_GUIINIT myGUIInit
  
  
_ Third, in the .onGUIEnd function, it is time to kill the plugin.

	Function .onGUIEnd
		skinnedbutton::unskinit
	FunctionEnd


_ It's the same thing for the uninstaller:

	Function un.onInit
		InitPluginsDir
		File "/oname=$PLUGINSDIR\button.bmp" "${NSISDIR}\Contrib\skinnedbutton\skins\ishield.bmp"
	FunctionEnd

   create an uninstall function, for example, named un.myGUIInit
	Function un.myGUIInit
		skinnedbutton::skinit /NOUNLOAD "$PLUGINSDIR\button.bmp"
		Pop $0
		StrCmp $0 "success" noerror
			MessageBox MB_ICONEXCLAMATION|MB_OK "skinned button error: $0"
		noerror:
	FunctionEnd
   And add this line before insert macro page. 
   !define MUI_CUSTOMFUNCTION_UNGUIINITun. myGUIInit
  
	Function un.onGUIEnd
		skinnedbutton::unskinit
	FunctionEnd


_ Finally, Don't forget to add the "XPStyle off" instruction after the insertion of macro page. Otherwise, no buttons will appear.


_ That's all!



BITMAP
------

To skin the buttons, the plugin need an bitmap image.
The image size is 47 pixel in width and 30 pixel in height.
The first 15 pixel in height, is for the normal button and the 15 next pixels is for the activate button.



Version history
---------------

	* Version 1.1 (15/08/2005)
          o Littles bug fix
	* Version 1.0 (19/07/2005)
          o First public release!
          
     
     
KNOW BUG
--------

	* During the installation, the button "Show Detail" is unskinned.
	* When the plug-in is used, if you used this code line:
		SendMessage $HWNDPARENT "0x408" "-1" ""
	  to automatically return to the previous page, the installer will crash.
	  
     
TODOO for the next version
--------------------------

	* support of the transparency for the buttons          
       
       
          
Credits
-------

Written by SuperPat
http://www.ultramodernui.com4.ws

Based on the wansis plug-in of Saivert
http://nsis.sourceforge.net/wiki/Wansis

Uses wa_dlg.h courtesy of Nullsoft, Inc.



License
-------

Copyright © 2005 SuperPat

Skinned Button plugin is based on the wansis plugin of Saivert (http://nsis.sourceforge.net/wiki/Wansis) and it use the wa_dlg.h courtesy of Nullsoft, Inc.

This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software.

Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software.
   If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
2. Altered versions must be plainly marked as such, and must not be misrepresented as being the original software.
3. This notice may not be removed or altered from any distribution.