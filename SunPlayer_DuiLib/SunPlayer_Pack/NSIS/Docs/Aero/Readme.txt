Aero NSIS plug-in

Author:  Stuart 'Afrow UK' Welch
Company: Afrow Soft Ltd
Date:    24th April 2014
Version: 1.0.1.1

Enables Windows Aero glass effect on the NSIS UI. This effect is only
available on Vista/7, and when Aero is enabled. On Windows 8 the border
is extended in the same way but with no transparency.

See Examples\Aero\*.

------------------------------------------------------------------------
Usage (Modern UI)
------------------------------------------------------------------------

  !define MUI_CUSTOMFUNCTION_GUIINIT myGUIInit
  (insert pages & languages here)
  Function myGUIInit
    Aero::Apply [Options]
  FunctionEnd

------------------------------------------------------------------------
Usage (Classic UI)
------------------------------------------------------------------------

  Function .onGUIInit
    Aero::Apply [Options]
  FunctionEnd

------------------------------------------------------------------------
Back/Next/Cancel Button Rendering
------------------------------------------------------------------------

  The plug-in implements 2 different methods for rendering the buttons
  correctly on Aero glass; however neither of these methods are perfect.
  Both methods work on all supported Windows versions (Vista, 7, 8).

  New Method (Default):-

    Asks Windows to paint the button without any text to a memory buffer
    on behalf of the plug-in, and then draws the button text onto that
    image.

    Benefits:
    * Added glow effect to the button text.
    * Little or no flicker of buttons or text on navigation.

    Drawbacks:
    * Keyboard accelerators do not work and are hidden.

  Old Method (Pre 1.0.0.7):-

    Asks Windows to paint the button and its text to a memory buffer on
    behalf of the plug-in, and then ensures the content region of the
    button is opaque so that the button text is rendered correctly.

    Benefits:
    * Keyboard accelerators work correctly.

    Drawbacks:
    * Noticable white text flicker on navigation.
    * No text glow effect.

  Both methods result in the mouse in/out fade animation being lost and
  this is unavoidable.

------------------------------------------------------------------------
Options
------------------------------------------------------------------------

  /nobranding

  Do not draw any branding text.

------------------------------------------------------------------------

  /btnold

  Forces the use of the old button drawing method (from pre 1.0.0.7).

------------------------------------------------------------------------
Change Log
------------------------------------------------------------------------

1.0.1.1 - 24th April 2014
* Fixed bug where DWM rect was not invalidated on composition change.
* Added 64-bit builds.

1.0.1.0 - 30th November 2013
* Fixed ampersand handling on branding text.

1.0.0.9 - 2nd February 2013
* Fixed button and branding text rendering for right-to-left languages.
* Fixed bug which could cause a crash due to a variable not being
  initialized to NULL (only when Aero could not be enabled).
* Fixed Aero not being applied on classic UI installers with RTL
  languages.

1.0.0.8 - 27th May 2012
* Fixed buttons not being drawn and crash when using /nobranding.

1.0.0.7 - 26th April 2012
* Implemented a new button drawing method to fix white text flicker
  (/btnold switch reverts to the old method).
* Now disables Aero if the theme data cannot be loaded on theme change.

1.0.0.6 - 12th July 2011
* Fixed branding text not re-showing on DWM disable and re-enable.
* Centred branding text for classic UI.
* Nudged buttons down by 3 pixels for classic UI.

1.0.0.5 - 9th July 2011
* Branding text now hidden when branding text static text control is
  hidden.

1.0.0.4 - 1st July 2011
* Fixed transparent button text in some situations for Next/Back/Cancel
  buttons.

1.0.0.3 - 19th May 2011
* Now always uses GetWindowTextW for the branding text (as
  DrawThemeTextEx is Unicode only).

1.0.0.2 - 4th May 2011
* Fixed typo Window -> CompositedWindow::Window in WM_THEMECHANGED
  (thanks Anders).
* No longer uses layered window drawing when branding text isn't used
  (aero hack to avoid owner-drawing buttons, but may not work on Vista).
* Now uses theme text colour for branding text (but still original
  font).
* Improved fall-back drawing if DWM composition is disabled (all drawing
  then handled by Windows/NSIS).
* Now re-shows old branding text and horizontal ruler when DWM
  composition is disabled.
* Plug-in now loads even if DWM composition is disabled, but could be
  enabled.
* Now only handles WM_CTLCOLORBTN for the Back, Next and Cancel buttons.
* Now uses GetThemeBackgroundContentRect to determine the button area
  to draw opaque.

1.0.0.1 - 28th April 2011
* Now gets text glow size from current theme (12 by default).
* Used double buffered painting to fix button text transparency (only
  occurred on some machines).

1.0.0.0 - 24th April 2011
* First version.

------------------------------------------------------------------------
License
------------------------------------------------------------------------

This plug-in is provided 'as-is', without any express or implied
warranty. In no event will the author be held liable for any damages
arising from the use of this plug-in.

Permission is granted to anyone to use this plug-in for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this plug-in must not be misrepresented; you must not
   claim that you wrote the original plug-in.
   If you use this plug-in in a product, an acknowledgment in the
   product documentation would be appreciated but is not required.
2. Altered versions must be plainly marked as such, and must not be
   misrepresented as being the original plug-in.
3. This notice may not be removed or altered from any distribution.