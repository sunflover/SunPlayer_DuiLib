
 ==============================================================
 Base64.dll v001 (3kB) by Angelo Dureghello, Italy

  Last build: 9th January 2007

  Performs tasks to reboot, shutdown or log off a workstation
 --------------------------------------------------------------

 Place Release\Base64.dll in your NSIS\Plugins folder.

 ==============================================================
 The Functions:

  Base64::Encrypt
   Base64 data encryption.

   parameters: string, length
   result: encoded string is on the stack

  Base64::Decrypt
   Base64 data dencryption.

   parameters: string, length
   result: decoded string is on the stack

 ==============================================================
 Example:

   Base64::Encrypt STRINGTOCRYPTB64 16
   
   pop $R7
   
   MessageBox MB_OK|MB_ICONINFORMATION "You crypted: $R7"

   StrLen $5 $R7
   Base64::Decrypt $R7 $5
   
   pop $R7
   
   MessageBox MB_OK|MB_ICONINFORMATION "You crypted: $R7"

 