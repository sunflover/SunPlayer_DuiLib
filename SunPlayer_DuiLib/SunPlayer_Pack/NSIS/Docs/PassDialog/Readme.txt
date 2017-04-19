
 ==============================================================

 PopupListBox.dll v0.1 (4.5kB) by Afrow UK

  Last build:2nd February 06

  A plugin to display a simple fully customisable top most
  popup dialog that contains a list box control.

 --------------------------------------------------------------

 Place PopupListBox.dll in your NSIS\Plugins folder or
 simply extract all files in the Zip to NSIS\

 See Example.nsi for examples of use.

 ==============================================================
 The Functions:

  PopupListBox::MultiSelect  [Parameters]
   Displays the dialog with a multiple selection list box
   control.

  PopupListBox::SingleSelect [Parameters]
   Displays the dialog with a single selection list box
   control.

 ==============================================================
 The Parameters:

  /HEADINGTEXT "Heading Text"
   Sets the text in the static text control of the dialog.

  /CAPTION "Caption Text"
   Sets the text to be displayed in the dialog caption.

  /TOOLWINDOW
   Applies the WS_EX_TOOLWINDOW extended window style to the
   dialog.

   All other parameters are counted as list box items.

 ==============================================================
 List box items may be passed to the plugin in two ways:

  Push /END # Stops plugin Popping from stack any further.
  Push "item 1"
  Push "item 2"
  Push $var1
  Push $var2
   PopupListBox::MultiSelect

  -- or --

   PopupListBox::SingleSelect "item 1" "item 2" $var1 $var2 /END

 ==============================================================
 Return Values:

  The return value is Pushed to the stack by the plugin, so
  that it can be Popped off again.

  PopupListBox::SingleSelect
   Pop $R0
   Pop $R1

  At this point, $R0 == "SUCCESS" on success, or
  "CANCEL" when the user has clicked Cancel, the X button
  or has not selected a list box item before clicking OK.
  Note: The first list box item will always be selected by
  default.

  $R1 will contain the text of the selected list box item.
  For multiple selection list boxes, a loop structure should be
  created which keeps Popping items from the stack until an
  item matches /END.

  To see examples of this, see Example.nsi

 ==============================================================
 Change Log:

  v0.1
   * First build.