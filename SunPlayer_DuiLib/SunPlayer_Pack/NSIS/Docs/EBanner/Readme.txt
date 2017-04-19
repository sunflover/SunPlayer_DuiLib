ebanner.dll - plug-in that shows banner on the 
bottom of the installer' page window
Supported formats: all the current IE can show.

Usage:

1)   ebanner::show /NOUNLOAD [/HALIGN=LEFT|RIGHT|CENTER] [/VALIGN=TOP|BOTTOM|CENTER] [/HWND=xxx] [/FIT=WIDTH|HEIGHT|BOTH] FileName

HALIGN - alignment (on the target window), left, right or center (default)

VALIGN - alignment, top, center or bottom (default)

HWND - target window handle, default is current page #32770 child.

FIT - image stretch to occupy window width or height or full window. For screen
      dpi 120 mainly. Default - no stretch.

FileName - image filename. Bmp, gif and jpg image types are supported.
           Empty Filename string "" cleares image but not stops sound playing.

For example, default bottom-center position and orifinal size:

     ebanner::show /NOUNLOAD "$PLUGINSDIR\catch.gif"

2)   ebanner::stop

     Destroys image, clears window, stops sound (if any).
     Optional, on the page close auto-stop should work (I guess).


3)   ebanner::play /NOUNLOAD [/LOOP] FileName

FileName - sound filename to play (with extension, wav, mp3 ...).
           Empty Filename string "" stops sound.

For example:

     ebanner::play /NOUNLOAD /LOOP "$PLUGINSDIR\snd.mp3"


Takhir Bedertdinov
