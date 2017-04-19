nsisStartMenu -- Small NSIS plugin for ensuring a given order of shortcuts in Start Menu
Web site: http://wiz0u.free.fr/prog/nsisStartMenu
-----------------------------------------------------------------

You can typically use it to ensure that the shortcut for your main program executable appears first 
and the shortcut for the uninstaller appears last, in Windows' Start Menu

Notes
-----
* This plugin has been only tested under Windows XP
but it should be compatible with Windows 2000, XP and more recent
* This plugin requires Unicode so it won't work under Windows 9x
* Under Windows XP, both the Classic Menu and the XP-Style Menu are handled
* If your installer is running under an administrator account, different from the current user, then this plugin
will have an effect on the administrator's start menu, not on the current user's start menu

Usage
-----
nsisStartMenu::RegenerateFolder "<folder name>"
nsisStartMenu::RegenerateFolderW "<folder name>" (for use with Unicode-NSIS only)

<folder name> is the name of your folder under the $SMPROGRAMS folder
	It should not contain the prefix $SMPROGRAMS\, but it can contain backslashes if you're working on a subfolder

This will force an update of the state of the corresponding shell menu (just as if the user has displayed the menu)
=> All deleted entries (since the last state of the menu) will be pruned from the menu
=> All new entries (since the last state of the menu) will be added at the end of the menu in alphabetical order



Return Value
------------

nsisStartMenu returns an integer status on the top of the stack
Possible status are:
	0:  Failure
	1:  Success


Strategy
--------

If you are creating a new folder under $SMPROGRAMS :
First, create the shortcut you want to appear at the top of the menu
Second, call nsisStartMenu::RegenerateFolder on the folder
Then create the other shortcuts

If you have several shortcuts and you want to ensure that "Uninstall" will be at the bottom :
First, create your shortcuts,
Second, call nsisStartMenu::RegenerateFolder on the folder
Then create the "Uninstall" shortcut

See the sample script provided.


Exports
-------

nsisStartMenu DLL can be used either as NSIS plugin or as a simple DLL
To this aim, you can link the LIB file and use the following convenient exported function :
extern "C" BOOL __declspec(dllimport) _RegenerateFolder(LPCWSTR progPath)


History
-------
2008-05-01 v1.1: compatible with Unicode-NSIS
2007-11-03 v1.0: First version

License
-------
Copyright (c) 2007-2008 Olivier Marcoux

This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software.

Permission is granted to anyone to use this library for any purpose, including commercial applications, and to redistribute it freely, subject to the following restriction:

The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
