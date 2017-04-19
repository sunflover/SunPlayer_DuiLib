  Overview
----------

  NxS is NSIS plug-in, displays banner with progress bar and Cancel button


  Usage
-------

Plug-in entry points: Show, Update, Destroy, HasUserAborted, getWindow

    nxs::Show /NOUNLOAD "Dialog caption text" \
      /top "Top text" \
      /sub "Sub text (more info)" \
      /h 1 \
      /pos 43 \
      /max 100 \
      /can 1 \
      /end

  TIP: Copy & paste into your script and modify the parameters.

  The parameters description:
    /top     Sets the top text (to the right of the icon)
             3 lines max.
    /sub     Sets the subtext (above the progress bar control)
             3 lines max.
    /h       Shows/hides taskbar' dialog button.
             Requires a number: 1 means hide. 0 means show.
    /pos     Sets the progress bar position.
    /max     Sets the number of steps the progress bar control
             has. Default value is 100.
    /can     Enables/disables Cancel button on dialog.
             Requires a number: 1 = enable, 0 = disable.
             Default is disabled.
    /end     Stops stack reading

  NOTES:
    Values for the /pos parameter range from 0 (zero) to 100 or the value
    specified for the /max parameter.

	Any other text passed on the stack (not one of the parameters) is used as
	the caption (title) of the dialog. If you pass multiple strings not recognized
	as a parameter the last one of these strings are used for the title. The rest
	is ignored.


  Update supports any of Show parameters, but in most cases it is simpler:

    nxs::Update /NOUNLOAD /top "Checking something..." /sub "78% complete" /pos 78 /end


  To get handle of the dialog (HWND) use:

    nxs::getWindow /NOUNLOAD
       Pop $0 ; $0 now contains the handle to the dialog window


  TIP: You don't need to use getWindow in order to modify the text. Just use the

    nxs::Update /NOUNLOAD "New dialog caption (title)"


  To check if the Cancel button has been pressed use:

    nxs::HasUserAborted /NOUNLOAD
        Pop $R0 ; $R0 now contains "1" if user clicked Cancel or "0" (zero) otherwise.


  To destroy the dialog and free resources use:

    nxs::Destroy


  See Example.nsi for an example.



Credits
-------

  NxS plugin written by Takhir Bedertdinov (2005-04-01  Moscow, Russia, ineum@narod.ru)

  Based on NxSMSILoaderDlg plugin written by saivert.

#EOF