SpiderBanner plugin for NSIS

Coded by Jason Ross aka JasonFriday13

2007 MouseHelmet Software


Introduction
------------

This plugin displays a custom dialog that looks like a small installing dialog.
This plugin was originally coded for the InstallSpider user interface, but can
be used in any installer.

Functions
---------

There are only two functions in this plugin. 'Show' must be called in a section.

SpiderBanner::Show /NOUNLOAD POS DIST

POS is the position of the dialog.
  /TL	   Top Left
  /TR	   Top Right
  /BL	   Bottom Left
  /BR      Bottom Right
  /CENTER  Center the dialog. DIST is ignored. Is the default if the input
	   doesn't match any in the list, even nothing defaults to /CENTER.
	   If there is a value placed in DIST, it will appear on the stack
	   after the plugin returns.

DIST is the distance from the corner specified in pixels.
If the commandline is like this:

SpiderBanner::Show /NOUNLOAD /BR 48

It means that the dialog will be placed 48 pixels up and left from the bottom
right hand corner.

SpiderBanner::Destroy

Destroys the dialog and restores the original size of the installer.