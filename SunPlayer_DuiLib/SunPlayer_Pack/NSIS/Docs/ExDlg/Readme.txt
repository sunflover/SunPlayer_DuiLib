ExDlg Plug-in v.1.0.1
---------------------

Description
-----------

  This plug-in shows custom NSIS pages using compiled resource files instead of INI files.
This plug-in only works on sections.

How To Use
----------  

  1) Create your dialog with your favorite editor. The following control classes are
     supported by this version completely (comparing with the current InstallOptions
     control types):

      --------------------------------------------------------------------------------------------
     | ExDlg Control Classes | InstallOptions Control Types | InstallOptionsEx Control Types      |
     |--------------------------------------------------------------------------------------------|
     | "COMBOBOX"            | DropList/ComboBox            | DropList/ComboBox                   |
     | "EDIT"                | Text/Password                | Text (or Edit)/Password             |
     | "LISTBOX"             | ListBox                      | ListBox                             |
     | "DIR_BROWSE"          | DirRequest                   | Text + Button w/ DIRREQUEST flag    |
     | "FILE_BROWSE"         | FileRequest                  | Text + Button w/ *_FILEREQUEST flag |
     | "START_BROWSE"        | None                         | None                                |
     | "BUTTON"              | Button/GroupBox/CheckBox/    | Button/GroupBox/CheckBox/RadioButton|
     |                       | RadioButtion                 |                                     |
     | TRACKBAR_CLASS        | None                         | TrackBar                            |
      --------------------------------------------------------------------------------------------

     Others are also supported, but the function exdlg::push_windowtext will only retrieve the
     text of the rest of the control classes.

     For the IDs of controls, try to use numbers instead of defines for the numbers.

  2) Compile the resource file into a .res file.

  3) DLL Functions Reference:

     3.1) exdlg::create_dlg "DialogID" "ResourceFile"
          Pop "PageHandle_ResultVar"
     ------------------------------------------------

       Creates a dialog using the resource file specified.

       DialogID

         Specifies the ID of the dialog to use when creating the dialog.

       ResourceFile

         Specifies where the resource file is located.

       PageHandle_ResultVar

         Variable where to output the handle for the dialog structure. This
         handle is the handle to a structure, not a page, so this cannot be
         used in other operations other than what this plug-in supports. This
         outputs "0" if the dialog couldn't be loaded when there is not
         enough memory.


     3.2) exdlg::push_windowtext "ControlID" "PageHandle"
          Pop "State_ResultVar"
     ---------------------------------------------------

       Gets the state value for a control.

       ControlID

         Specifies the ID of the control to use for getting the control's state.

       PageHandle

         Specifies the handle to the dialog structure outputted by
         exdlg::create_dlg.

       State_ResultVar

         Variable where to output the state of the control. If the control is a
         checkbox type, this outputs "checked" if the control is checked. If
         the control is of a trackbar control type, this retrieves the position
         of the slider. For the rest of the cases (even when the checkbox
         control type is unchecked) the text of the control is retrieved. If the
         control ID doesn't exist, "! invalid id" value is returned.

     3.3) exdlg::dealloc "PageHandle"
     ---------------------------------------------------

       Frees the memory allocated for the page structure in "exdlg::create_dlg"
       function.

       PageHandle

         Specifies the handle to the dialog structure outputted by
         exdlg::create_dlg.

  Note About The Usage
  --------------------

    1) Adding a static icon control of ID 1004 adds the installer's
    icon to your dialog.

    2) The "START_BROWSE" control only detects the folders in the all users
    "Start Menu" folder. StartMenu plug-in has a better implementation, but
    it is not supported as a control for ExDlg, nor InstallOptions and
    InstallOptionsEx.

Versions History
----------------

1.0.1 - 15/Aug/2005 - by deguix
- Brought plug-in status to "usable". Very few people in the past got this
  plug-in working correctly, and this discoraged people from using this
  plug-in's source.
- Updated plug-in and script to NSIS 2.08.
- Re-made readme for better readibility.
- Plug-in now has 20KB of size.

- Note: Bug-fixes were not implemented for historical reasons of the plug-in.
        deguix won't be maintaining this plug-in for long.

1.0 - 21/Dec/2001
- First version.

Credits
-------
- Author: pjw62 (aka Peter Windridge).

License
-------

  This software is provided 'as-is', without any express or implied
  warranty. In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute
  it freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented;
     you must not claim that you wrote the original software.
     If you use this software in a product, an acknowledgment in the
     product documentation would be appreciated but is not required.
  2. Altered versions must be plainly marked as such,
     and must not be misrepresented as being the original software.
  3. This notice may not be removed or altered from any distribution.


Original readme by pjw62
------------------------

For the NullSoft Install system, by Peter Windridge.

Instructions

- create your dlg with your favourite dialog editor and compile to a .res
  Currently, the extra control classes are available..
    "FILE_BROWSE", "DIR_BROWSE", "START_BROWSE".
  
  If you use the "FILE_BROWSE" control, you can use the Extended style to
  specify extra flags for the GetSaveFileName function, so you can do things
  like only allow them to specify files that are read only or something.
  
  (tip, when designing dialogs, give all the control ids simple numbers rather
  than smbols you need to look up in the resource.h for).
- Compile the script (or save it as a .res)
- In your NSIS script, push the filename of the resource file.
  e.g. push "$TEMP\script1.res"
  THen push the id of the dialog you want to display.
  e.g. push "101"
- Call create_dlg 
  e.g. CallInstDLL exdlg.dll create_dlg
  Now, the buffer address for all the data is on the top of the stack. You 
  will not need to pop it to a temporary variable unless you plan on doing 
  anything that might disturb the stack order.
- To get values, 
  1. push the id of the component you want the value of..
  2. call push_windowtext, e.g. CallInstDLL exdlg.dll push_windowtext
  3. pop the window value and do whatever with it.

  For this function, the stack should be as follows, [id,buffer_addr] (with 
  id on top).
- REMEMBER TO FREE THE BUFFER AFTERWARDS WITH dealloc, e.g. 
  CallInstDLL exdlg.dll dealloc
  For this, the address should be on top of the stack.

Errmm.. some notes..

1. Adding a static icon control of ID 1004 addes the installer
   icon to your dialog.

2. If you use a check box, 'push_windowtext' gives 'checked' if it is 
   checked or the text if it is not a check box or it is unchecked.

3. Similarly, using a slider control with 'push_windowtext' gives the 
   result of TBM_GETPOS.

4. If for some reason, the buffer value after create_dlg is 0 (so if you 
   want you can check to see if the dialog was created and values saved 
   successfully).


Peter.