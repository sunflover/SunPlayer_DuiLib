nsMCI DLL Readme
================

  This plug-in allows the use of Media Control Interface (MCI) commands
  strings to play multimedia devices and record multimedia resource
  files.

1. How to use
-------------

  1.1 Functions Reference
  -----------------------

    1.1.1 nsMCI::GetFirstCDROMDrive
          Pop "ResultVar"
    -----------------------------------

      Gets the first letter associated to a CD-ROM drive in the system.

      ResultVar

        Variable where to return the result.

      Return Value:

        Returns the first letter associated to a CD-ROM drive (i.e. "D")
        plus the colon ":" character. If none exists, an empty value is
        returned.

      Example:

        nsMCI::GetFirstCDROMDrive
        Pop $0

        $0 = "D:" (depends on the computer this code is used)

    1.1.2 nsMCI::SendString "Command" ...
          Pop "ResultVar"
          Pop "ErrorResultVar"
    --------------------------------------------

      Sends a set of commands strings to a MCI device.

      Command

        A MCI command string. See:

        Syntax of command strings:
        http://msdn.microsoft.com/library/default.asp?url=/library/en-us/multimed/htm/_win32_command_strings.asp

        Types and a list of command strings:
        http://msdn.microsoft.com/library/default.asp?url=/library/en-us/multimed/htm/_win32_classifications_of_mci_commands.asp

      ResultVar

        Variable where to return the result.

      ErrorResultVar

        Variable where to return the error code resultant from the
        last command called. It returns zero if successful or an error
        otherwise.

      Return Value:

        Returns the return information for the last command called.

      Example:

        This code verifies the number of tracks in a "CD Audio" type of CD
        if it exists or it will give an error otherwise.

        nsMCI::SendString "open D: type cdaudio alias nsis wait" "status nsis number of tracks wait"
        Pop $0

        $0 = "0" (depends on the computer this code is used)

    1.1.3 nsMCI::GetErrorString "ErrorCode"
          Pop "ResultVar"
    ------------------------------------------

      Gets the error description of an error code.

      ErrorCode

        Error code returned from a call to "nsMCI::SendString".

      ReturnVar

        Variable where to return the result.

      Return Value:

        Returns the description of the error number. If the error code is
        "0" or out of range of MCI supported error codes, then the result
        is an empty string.

      Example (used along with the example from
      "nsMCI::SendString" function):

        nsMCI::GetErrorString $0
        Pop $0

        $0 = "" (depends on the computer this code is used)

2. Versions History
-------------------

1.3 - 22/Oct/2005 (by deguix)
  - Changed function names:
    - "nsisGetFirstCDROMDrive" -> "GetFirstCDROMDrive".
    - "nsisMCISendString" -> "SendString".
  - Added a new function called "GetErrorString".
  - Adapted code to use stack to output the return value.

1.2 - 29/Aug/2005 (by deguix)
  - Renamed plug-in from "NSISExt_MCI" -> "nsMCI".
  - Adapted to support the current ExDLL plug-in version.

1.1 - 14/12/2001
  - Improved plug-in to take any command from stack to be executed
    (thanks petersa).

1.0 - 13/12/2001
  - First plug-in version.

3. Credits
----------

  Plug-in created by Florian Heidenreich (aka "F. Heidenreich").

4. License
----------

  Copyright (C) 2001-2005 Florian Heidenreich (nsis@mp3tag.de)

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.