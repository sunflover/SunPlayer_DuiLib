AnimGig.dll - plug-in that shows animated banner on the installer' page.
Based on the Juan Soulie code. Works faster compare to PictureEx based version, but,
even after I fixed few bugs (and added transparency support), it still not likes some 
images (as Juan Soulie original program does) so do not forget to test it with your GIF :)
PictureEx version may be found in AnimGifPe.zip file.

Usage:

1)   AnimGif::play /NOUNLOAD [/HALIGN=LEFT|RIGHT|CENTER] [/VALIGN=TOP|BOTTOM|CENTER] [/HWND=xxx] [/BGCOL=xxx] [/FIT=WIDTH|HEIGHT|BOTH] FileName

FileName - image filename. Bmp, gif and jpg image types are supported.
           Empty Filename string "" cleares image but not stops sound playing.

HALIGN - alignment (on the target window), left, right or center (default)

VALIGN - alignment, top, center or bottom (default)

HWND - target window handle, current page #32770 child is default.

BGCOL - color to use for image trasparent areas. If not defined, plug-in attempts
        to extract value from target window, but this is not possible if window is hidden.
        Color value may be hex (starting with 0x) and decimal (first is not 0). Hex value 
        will be used as RGB color, decimal - as Windows system color index in GetSysColor()
        API call, see MSDN. If value not specified and target window stays hidden (for
        example in custom 'Show' function), default COLOR_BTNFACE will be used.

FIT - image stretch to occupy window width or height. For screen dpi 120 mainly.
      Default - no stretch.

For example:

     AnimGif::play /NOUNLOAD "$PLUGINSDIR\felix_new.gif"

2)   AnimGif::stop

     stops playing and clears window


Takhir Bedertdinov
