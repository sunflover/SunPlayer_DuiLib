
 ==============================================================

 ToggleInstFiles.dll v0.5 (4kB) by Afrow UK

  Last build: 16th July 2006

  Adds a button to toggle the install files window.

 --------------------------------------------------------------

 Place ToggleInstFiles.dll in your NSIS\Plugins folder or
 simply extract all files in the Zip to NSIS\

 See Example.nsi and ExampleMUI.nsi for examples of use.

 ==============================================================
 The Functions:

  ToggleInstFiles::Set /NOUNLOAD

   Enables the features.
   This must be called from within a Section,
   e.g. in a hidden one:

   Section
    ToggleInstFiles::Set /NOUNLOAD
   SectionEnd

   ...more Sections below...

  ------------------------------------------------------------

  ToggleInstFiles::Unload

   Unloads the plugin.
   Without this call, the temporary folder created by NSIS
   will remain undeleted because the DLL is left in use.

   You should call this from the .onGUIEnd function, e.g.

   Function .onGUIEnd
    ToggleInstFiles::Unload
   FunctionEnd


 ==============================================================
 The Parameters for ToggleInstFiles::Set:

  /SHOWTEXT "string_label"
   Sets the text to be displayed on the button in the
   'show details' state.

  /HIDETEXT "string_label"
   Sets the text to be displayed on the button in the
   'hide details' state.

  /RIGHT
   Places the button on the right of the screen instead of the
   left (left is by default).

 ==============================================================
 Change Log:

  v0.7
   * Rebuilt under VC++ 6 (from .NET).

  v0.6
   * Added ToggleInstFiles::Unload to unload the plugin.
   * Fixed bug when "SetAutoClose true" was set. Installation
     would finish and plugin would turn itself off.

  v0.5
   * Fixed bug when using "AutoCloseWindow True" or
     "SetAutoClose True"; Finish button on Finish Page would
     stop working.

  v0.4
   * The top of the progress bar and button are now set to the
     top of the original progress bar in case of a custom UI
     (no longer a fixed value).

  v0.3
   * Added /SHOWTEXT and /HIDETEXT plugin parameters to set
     the button texts.
   * Plugin now uses original show details button rather than
     creating its own.
   * Added /RIGHT plugin parameter to place the button on the
     right (by default it's on the left).
   * Re-did code for resizing/positioning controls.

  v0.2
   * ToggleInstFiles::Free removed.
     Plugin now automatically resets window/dialog procedures
     on InstFiles page-leave.

  v0.1
   * First build.