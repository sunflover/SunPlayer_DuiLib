
 ==============================================================

 ButtonLinker.dll v1.0 (7KB) by zhfi

  An NSIS plug-in that allows NSIS coder to add a custom button or menu and tie a NSIS function to it.

 --------------------------------------------------------------

 Place ButtonLinker.dll in your NSIS\Plugins folder or
 simply extract all files in the Zip to NSIS\

 See Examples\ButtonLinker\ButtonLinkerMUI.nsi for example of use.

 ==============================================================
 Adding The Button(s) To Your Dialog(s):

  The ButtonLinker plug-in does not add the command button(s)
  itself. This is so because across different OS' different
  languages and fonts are used and therefore the NSIS dialog
  will vary in size. This means that we cannot specify a
  fixed position for a new button at run time because
  it may overlap other controls on the dialog across
  different systems.

  You must add the command button with Resource Hacker.
  Download Resource Hacker from:
  http://www.angusj.com/resourcehacker/

  Make a copy of the default UI file you are using and copy
  it to your installer's folder.
  The UI files are under Contrib\UIs.
  MUI: modern.exe, Classic: default.exe

  You can use the new UI with:
  (MUI)
  !define MUI_UI ui_file
  (Classic)
  ChangeUI all ui_file

  When adding the button to the dialog of your choice, give it
  a control ID of 1200 or 1201 etc.
  The control ID is what you must specify when calling the
  ButtonLinker plug-in.

 ==============================================================
 The Functions:

  ButtonLinker::AddEventHandler /NOUNLOAD control_id /NOTIFY|$FuncAddress

   Adds an event handler to a button with an ID if control_id
   and ties the $FuncAddress NSIS function to it or
   executes the page LEAVE function when using /NOTIFY.

   Use this instruction in the SHOW function of the page
   that contains your new button.

   $FuncAddress is obtained by using GetFunctionAddress:

     GetFunctionAddress $R0 MyFunction
     ButtonLinker::AddEventHandler /NOUNLOAD 2000 $R0
     ...
     Function MyFunction
     ...

   The /NOTIFY flag is used like so:

     !include MUI.nsh
     !include LogicLib.nsh
     ...
     !define MUI_PAGE_CUSTOMFUNCTION_SHOW  PageShow
     !define MUI_PAGE_CUSTOMFUNCTION_LEAVE PageLeave
     !insertmacro MUI_PAGE_*
     ...
     Function PageShow
       ButtonLinker::AddEventHandler /NOUNLOAD 2000 /NOTIFY
     FunctionEnd

     Function PageLeave

       ButtonLinker::WhichButtonId /NOUNLOAD
         Pop $R0

       ${If} $R0 == 2000
         ; Do stuff here.

         Abort
       ${EndIf}

     FunctionEnd
   
   Note: Always use /NOUNLOAD with this function.
         Otherwise your installer will crash.

          -------------------------------------------

  ButtonLinker::WhichButtonId /NOUNLOAD
    Pop $Var

   Returns the control_id in $Var that triggered the page's
   leave function (/NOTIFY) or the function at $FuncAddress.
   
   Note: Always use /NOUNLOAD with this function.
         Otherwise your installer will crash.

          -------------------------------------------

  ButtonLinker::UnsetEventHandler /NOUNLOAD control_id
    Pop $Var

   The ButtonLinker plug-in is compiled to allow 8 event handlers
   per installer. Use this to remove the event handler from
   control_id allowing another event handler to take its place.
   
   Note: Always use /NOUNLOAD with this function.
         Otherwise your installer will crash.

          -------------------------------------------

 ==============================================================
Transform static labels into links.

Link function
~~~~~~~~~~~~~

Transforms a label into a link.

Must always be called with /NOUNLOAD to prevent a crash.

Takes HWND and URL. For example:

ButtonLinker::CreateLinker /NOUNLOAD $HWND "http://www.google.com/"

Unload function
~~~~~~~~~~~~~~~

Dummy function that allows unloading the DLL so it won't be left
over in the plug-ins directory. Normally called from .onGUIEnd.

Function .onGUIEnd
	ButtonLinker::unload
FunctionEnd


 ==============================================================
Source Codecs from:
ButtonEvent.dll v0.5 (4KB) by Afrow UK
linker.dll