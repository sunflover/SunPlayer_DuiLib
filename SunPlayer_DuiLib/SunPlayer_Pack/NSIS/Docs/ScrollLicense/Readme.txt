
 ==============================================================

 ScrollLicense.dll v0.7 (5kB) by Afrow UK

  Last build: 19th July 2007

  A plugin that stops the user passing the License page without
  scrolling to the end of the License agreement.
  Also has support for two "Accept" check-boxes when
  "LicenseForceSelection checkbox" is set.

 --------------------------------------------------------------

 Place ScrollLicense.dll in your NSIS\Plugins folder or
 simply extract all files in the Zip to NSIS\

 See Examples\ScrollLicense\ for examples of use.

 ==============================================================
 The Functions:
 ==============================================================

* ScrollLicense::Set /NOUNLOAD

   Enables the feature.
   This must be called from within the License page's SHOW
   function.

* ScrollLicense::Unload

   Unloads the plugin from memory.
   This allows the ScrollLicense.dll file to be deleted from
   $PLUGINSDIR. This function should be called from the
   .onGUIEnd function, e.g.

   Function .onGUIEnd
    ScrollLicense::Unload
   FunctionEnd

   * Note: No /NOUNLOAD used here.

 ==============================================================
 The Parameters:
 ==============================================================

* /CHECKBOX "check box text"

   Adds an additional check-box to the License page if using
   "LicenseForceSelection checkbox". Feature requested by
   cyrusazar.

   Use an empty string for "check box text" to use the default.

* /LINES X

   Sets how many lines are visible at any one time in the
   License box. This must be used if you change the License
   box size (e.g. with Resource Hacker) or if you use a
   different font. Default is 13.

 ==============================================================
 Change Log:
 ==============================================================

  v0.7
   * Code cleanup and fix for next button when not using
     LicenseForceSelection.
   * Plug-in window procedures now kept until .onGUIEnd.
   * Better example scripts.
   * Fixed excessive reading of stack items.

  v0.6
   * Rebuilt under VC++6 (from .NET).

  v0.5
   * Fixed bug where going onto the license page, back a page,
     and forward again would cause the 2 check-boxes to stay
     disabled (when using /CHECKBOX).

  v0.4
   * Added Unload plugin function to unload the plugin.

  v0.3
   * Added bools to remember check-box and next button states
     when using /CHECKBOX.

  v0.2
   * Fixed bug when going back to the license page with
     /CHECKBOX set would cause new checkbox to disappear.

  v0.1
   * First build.