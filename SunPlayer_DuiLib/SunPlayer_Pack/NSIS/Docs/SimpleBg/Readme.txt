SimpleBg plugin for NSIS

Coded by Jason Ross aka JasonFriday13

2007 MouseHelmet Software

Introduction
------------

This plugin displays a background window with a border and titlebar. I coded
this plugin for my InstallSpider user interface, but can be used for any
installer.

Functions
---------

Only two functions here.

SimpleBg::SetBg /NOUNLOAD R G B R G B "Text on background"

The first set of RGB is the top colour. 0 255 0 would make a green top color.
The second set of RGB is the bottom colour. 255 0 0 would make a red bottom colour.
The "Text on background" is obviously the text that is displayed on the background.
This function must be used in the .onguiinit function.

SimpleBg::Destroy

This safely unloads the plugin when you are finished with it.
Can be called whenever you like, but I prefer the .onguiend function.