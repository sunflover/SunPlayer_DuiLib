
 ==============================================================

 BrandingURL.dll v0.1 (4KB) by Afrow UK

  Last build: 7th June 2007

  An NSIS plugin to set branding text to a clickable hyperlink.

 --------------------------------------------------------------

 Place BrandingURL.dll in your NSIS\Plugins folder or
 simply extract all files in the Zip to NSIS\

 See Examples\BrandingURL\ExampleMUI.nsi for example of
 use.

 ==============================================================
 The Functions:

  BrandingURL::Set /NOUNLOAD [color_r] [g] [b] [link_url]

   Set the branding text to a clickable hyperlink.

   [color_r]     : Red of hyperlink color.
   [g]           : Green of hyperlink color.
   [b]           : Blue of hyperlink color.
   [link_url]    : The web address to open in the default
                   web browser.

   Note: This should be called in .onGUIInit.
         /NOUNLOAD is required.
         Use empty "" values for r g b to use the default
         link color.

          -------------------------------------------

  BrandingURL::Unload

   Unloads the plugin DLL for deletion.

   Note: This should be called in .onGUIEnd.

 ==============================================================
 Change Log:

  v0.1 [7th June 2007]
   * Recompiled under Microsoft Visual C++ 6.

  v0.1 [21st April 2006]
   * First build.