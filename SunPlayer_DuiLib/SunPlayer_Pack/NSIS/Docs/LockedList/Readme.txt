~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  LockedList.dll v0.7 (18.5KB) by Afrow UK

   An NSIS plugin to display or get a list of programs that are
   locking a selection of files that have to be uninstalled or
   overwritten.

   Last build: 26th February 2008, Microsoft Visual C++ 6

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 Place LockedList.dll in your NSIS\Plugins folder or
 simply extract all files in the Zip to NSIS\

 See Examples\LockedList for an example of
 use.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 More information
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  The main plugin functions loop through system handles and process
  modules to find a file that your installer has to overwrite or
  delete. It uses API's only available on Windows NT4 and upwards and
  therefore you must not allow the plugin to be called on a version
  of Windows that is older than Windows NT4.

  WinVer.nsh will help in this area...

  !include WinVer.nsh
  ...

    ${If} ${AtLeastWinNt4}
      ; Call LockedList plugin.
    ${EndIf}

  As of v0.4, LockedList supports listing of currently open
  applications.

  As of v0.7, the plug-in also supports listing of applications from
  window classes and captions.

  For the LockedList dialog, processes on the list will be removed
  when they have been closed or terminated, enabling the next
  button if the list becomes empty.

  LockedList also has support for silent installers with NSIS
  stack interaction as opposed to using a dialog. Silent searching
  can also be performed asynchronously so that other tasks can be
  performed while the plugin searches (such as a progress bar).

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Adding paths of locked files or modules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  These functions must be called before displaying the dialog
  or performing a silent search.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  LockedList::AddFile /NOUNLOAD "path\to\file.ext"

  This adds an ordinary file. These files are searched for case
  insensitively by iterating open file handles.

  You can also specify just the file name (with a leading backstroke)
  like so:
    "\file.ext"

  Note: /NOUNLOAD is mandatory.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  LockedList::AddModule /NOUNLOAD "path\to\file.dll"

  This adds a module file. This includes dlls, ocxs and executables.
  These files are searched for case insensitively by iterating
  running process modules.

  You can also specify just the file name (with a leading backstroke)
  like so:
    "\file.dll"

  Note: /NOUNLOAD is mandatory.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  LockedList::AddClass /NOUNLOAD "class_with_wildcards"

  This adds an application by window class. You can use wildcards
  such as * and ? for searching.

  Note: /NOUNLOAD is mandatory.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  LockedList::AddCaption /NOUNLOAD "caption_with_wildcards"

  This adds an application by window caption/title. You can use
  wildcards such as * and ? for searching.

  Note: /NOUNLOAD is mandatory.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Displaying the search dialog
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  LockedList::Dialog [optional_params]
   Pop $Var

  This is the normal way to display the dialog.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  LockedList::InitDialog /NOUNLOAD [optional_params]
   Pop $HWNDVar
  LockedList::Show
   Pop $Var

  This method allows you to modify controls on the dialog with
  SendMessage, SetCtlColors etc by using the $HWNDVar between
  the InitDialog and Show calls and also in the page's leave
  function.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  At this point, $Var will contain "error" on display error,
  "next" if the next button was pressed,
  "back" if the back button was pressed or
  "cancel" if the cancel button was pressed.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  These [optional_params] apply to both LockedList::Dialog and
  LockedList::InitDialog. The parameter names are case insensitive.

  /heading    "text"  - Set page heading text.

  /caption    "text"  - Set dialog caption text.

  /colheadings        - Set the column heading texts in the processes
   "application_text"   list. An empty string `` will use the default
   "processes_text"     text.

  /noprograms "text"  - Item text when no programs to be closed are
                        running.

  /searching  "text"  - Item text while searching is in progress.

  /endsearch  "text"  - Item text when user clicks back or cancel
                        during a search.

  /endmonitor "text"  - Item text when user clicks back or cancel
                        after a search (at which point the list of
                        programs is being monitored for closing).

  /usericons          - Program will use icons "search.ico" and
                        "info.ico" in the current working directory
                        instead of using icons from shell32.dll for
                        the searching list. If no icons are found,
                        the installer icon is used.

  /ignore     "text"  - Allow the user to click next even if there
                        are items on the list. The parameter sets
                        the button text.

  /autoclose          - Close all running process on exit with the
   "close_text"         confirmation message box "close_text".
   "kill_text"          Processes that cannot be closed safely with
   "failed_text"        WM_CLOSE are killed with the confirmation
                        message box "kill_text". If processes are
                        still running then the "failed_text" message
                        box is displayed. An empty string `` will use
                        the default text.

                        The /ignore switch can also be used to set
                        the Next button text.

  /autoclosesilent    - Same as the above switch except the close and
   "failed_text"        kill confirmation boxes are not displayed.
                        If some processes cannot be killed, the
                        "failed_text" message is still displayed and
                        the user is prevented from continuing with
                        setup.

  Examples:

  LockedList::Dialog /caption `I like cheese` /heading `I do really`
   Pop $Var

  LockedList::Dialog /autoclose `` `` `Couldn't kill 'em all, oops!`
   Pop $Var

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Searching silently
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  LockedList::SilentSearch [/NOUNLOAD /thread]

  Begins the search silently. Specify /NOUNLOAD /thread to allow the
  process to continue in a separate thread which you can check
  the progress of with the SilentWait and SilentPercentComplete
  functions listed below. Otherwise, the plugin returns only when it
  has finished searching at which point the results will be pushed
  onto the stack.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Searching silently with threading 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  These can only be used after calling:
  LockedList::SilentSearch /NOUNLOAD /thread

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  LockedList::SilentWait [/NOUNLOAD /time #]
   Pop $Var

  If SilentSearch /NOUNLOAD /thread was used, this function will wait
  until the thread has finished, or optionally, return in #
  milliseconds when using /NOUNLOAD /time #.

  $Var will contain either /wait or /done depending on whether or not
  the searching has finished. /wait means that your script still
  needs to wait and /done means the searching has finished and the
  list of found processes are now on the stack.

  Note that you may need to use the LockedList::Unload function after
  using LockedList::SilentWait /NOUNLOAD /time #. This is described
  in the next read-me section.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  LockedList::SilentPercentComplete /NOUNLOAD
   Pop $Var

  $Var will contain the current completion percentage, i.e. 65 for
  65%. This can be used in a progress message.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Accessing the result of a silent search
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  The list of programs are pushed onto the stack when either of the
  following plugin calls return:

  LockedList::SilentSearch
    (without /NOUNLOAD /thread)

  LockedList::SilentWait
    (without /NOUNLOAD /time #)

  LockedList::SilentWait /NOUNLOAD /time #
    (and the search finishes within # milliseconds)

  The list of processes will be placed on the NSIS stack:
    Process id, full path, window caption.

  /start marks the start of the list and /end marks the end allowing
  you to loop through the returned items using LogicLib or StrCmp.

  3 Pop's in succession will return 3 items, with another 3 Pop's
  returning the next 3 items and so on until /end is reached.

  Examples of this are shown in the included example script.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Freeing the plugin for deletion
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  If your final call to the plugin uses the /NOUNLOAD flag because
  it is required (e.g. for LockedList::SilentWait /NOUNLOAD /time #),
  then you can free the plugin by calling LockedList::Unload without
  the /NOUNLOAD flag. If this is not done, the LockedList.dll file
  will remain in $PLUGINSDIR and will prevent that folder from being
  deleted when the installer is closed.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Change log
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  v0.7 - 24th February 2008
   * Re-wrote /autoclose code and fixed crashing.
   * Added AddClass and AddCaption functions.
   * Fixed Copy List memory read access error.
   * Made thread exiting faster for page leave.
   * Progress bar and % work better.
   * Processing mouse cursor redrawn.
   * Ignore button text only set when list is not empty.
   * RC2: Fixed /autoclose arguments.

  v0.6 - 12th February 2008
   * Added /autoclose "close_text" "kill_text" "failed_text" and
     /autoclosesilent "failed_text".
     The /ignore switch can be used along with this to set the Next
     button text.
   * Added /colheadings "application_text" "process_text"

  v0.5 - 25th November 2007
   * Fixed memory leak causing crash when re-visiting dialog. Caused
     by duplicate call to GlobalFree on the same pointer.

  v0.4 - 27th September 2007
   * Module or file names can now be just the file name as opposed to
     the full path.
   * Folder paths are converted to full paths (some are short DOS
     paths) before comparison.
   * Fixed typo in AddModule function (ModulesCount>FilesCount).
     Thanks kalverson.
   * List view is now scrolled into view while items are added.
   * List changed to multiple columns.
   * Debug privileges were not being set under SilentSearch.
   * Added /ignore switch that prevents the Next button being
     disabled.
   * Added AddApplications to add all running applications to the
     list.
   * Added processing mouse cursor.
   * Added right-click context menu with Close and Copy List options.
   * Added progress bar.
   * Added default program icon for processes without an icon.
   * Added code to resize controls for different dialog sizes.

  v0.3 - 13th July 2007
   * Added LVS_EX_LABELTIP style to list view control for long item
     texts.
   * Width of list header changed from width-6 to
     width-GetSystemMetrics(SM_CXHSCROLL).
   * Added WM_SYSMENU existence check when obtaining window captions.
   * Files/modules lists memory is now freed when using SilentSearch.
   * Files and Modules lists count now reset after a search.
   * Added reference to Unload function to read-me.

  v0.2 - 12th July 2007
   * Added two new examples.
   * Fixed pointer error in FileList struct causing only first
     module/file added to be used.
   * Fixed caption repetition over multiple processes.
   * Fixed stack overflow in DlgProc. Special thanks, Roman
     Prysiazhniuk for locating the source.
   * Better percent complete indication.

  v0.1 - 10th July 2007
   * First build.