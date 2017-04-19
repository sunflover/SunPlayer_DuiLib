
 ==============================================================

 ShutdownAllow.dll v0.1 (2.5KB) by Afrow UK

  Last build: 11th August 2006

  A plugin that allows Windows to shut down while the installer
  is still running.

 --------------------------------------------------------------

 Place ShutdownAllow.dll in your NSIS\Plugins folder or
 simply extract all files in the Zip to NSIS\

 See Examples\ShutdownAllow\* for examples of use.

 ==============================================================
 The Functions:

  ShutdownAllow::Allow /NOUNLOAD
   Enables the feature.
   The user may now log off or shut down the computer.
   This must be called once in the .onGUIInit function.
   If using Modern UI, you must create your own onGUIInit
   function with !define MUI_CUSTOMFUNCTION_GUIINIT "onGUIInit"

          -------------------------------------------

  ShutdownAllow::Unload
   Unloads the plugin. This must be called once in the
   .onGUIEnd function.
   If this is not used, the plugin DLL will remain
   undeleted in $PLUGINSDIR.

   Note: Never use /NOUNLOAD here.

 ==============================================================
 Change Log:

  v0.1 [11th August 2006]
   * First build.