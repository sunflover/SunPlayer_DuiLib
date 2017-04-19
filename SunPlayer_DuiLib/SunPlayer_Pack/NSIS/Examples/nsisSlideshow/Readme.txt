nsisSlideshow -- Small NSIS plugin for displaying fading banners/slideshow
Web site: http://wiz0u.free.fr/prog/nsisSlideshow
-----------------------------------------------------------------

You can use it to display advertisements or tips during installation.
Display of banners can be manual (synchronized) or automatic (slideshow runs while NSIS script continues)

Notes
-----
* This plugin has been tested under Windows XP & Vista
but it should be compatible with Windows 2000, XP, Vista and more recent
* Check the sample scripts for practical examples.

Usage
-----
nsisSlideshow::show /NOUNLOAD [options] <picture filename>				(Manual mode)
nsisSlideshow::show /NOUNLOAD [options] /auto=<control file>			(Automatic mode)

options can be:
/HWND=<handle value>			use the bounds rectangle of the given window to draw the banner
								(by default, the banner occupies the area of the details listview)
/FIT=HEIGHT|WIDTH|BOTH|STRETCH	reduce/enlarge the picture(s) to fit the given constraint inside the rectangle
								(default: BOTH)
/HALIGN=LEFT|CENTER|RIGHT		horizontal placement within the rectangle (default: CENTER)
/VALIGN=TOP|CENTER|BOTTOM		vertical placement within the rectangle (default: CENTER)
/CCOLOR=0xBBGGRR				blue/green/red hexadecimal value for the color of the optional subtitle (default: white)
								(make sure the color of the bottom part of the picture allows for readability of the subtitle)

options in manual mode can also be:
/DURATION=<delay in ms>			fade-in duration to display the picture (default: 1000 ms)
"/CAPTION=<string>"				add the given subtitle string in the bottom of the picture (use quotes if there are spaces)

pictures format can be JPEG, PNG, GIF, BMP, WMF

automatic control file is a text file that defines the pictures to display in the slideshow, depending on the current language.
Format of definition groups:
[<language value>]			; Locale ID decimal value. See http://msdn.microsoft.com/en-us/library/0h88fahh%28VS.85%29.aspx
=<picture filename>,<fadein delay>,<tempo delay>[,<subtitle caption>]
=<picture filename>,<fadein delay>,<tempo delay>[,<subtitle caption>]
=<picture filename>,<fadein delay>,<tempo delay>[,<subtitle caption>]
...
The pictures should preferably be in the same directory as the control file. (you will typically extract the slideshow folder to $PLUGINSDIR)
Delay are in ms. Tempo delay is the time to wait before switching to the next picture.
Subtitle caption must be encoded in the adequate language codepage (like NSIS language strings)

If the group ends with a line containing only a period (.), the slideshow will stop at the last picture.
Otherwise, the slideshow will cycle back to the first picture.

You can put several language groups in the control file, and change the picture/captions/etc... according to the language.
If the current language is not found, it will default to group [1033] (english), and if not found to group [0].


nsisSlideshow::stop

Call this to abort or terminate the display of banner(s) when the installation ends
This will also release memory used by the plugin and unload the DLL



History
-------
2006-06-21 v1.0: initial EBanner plugin code by Takhir Bedertdinov
2009-01-08 v1.1: large rewrite. no more flickering
2009-02-17 v1.2: automatic crossfade in background
2009-06-16 v1.3: added automatic slideshow mode using a Slides folder
2009-08-19 v1.4: renamed plugin to nsisSlideshow. documentation
2009-09-07 v1.5: porting to Unicode NSIS
2010-04-27 v1.6: fixed 2 bugs in automatic mode
2011-05-07 v1.7: compatibility with IE9

License
-------
Copyright (c) 2009-2011 Olivier Marcoux

This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software.

Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.

    2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.

    3. This notice may not be removed or altered from any source distribution.
