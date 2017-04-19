
 ==============================================================
 email.dll v001 (3kB) by Angelo Dureghello, Italy

  Last build: 9th January 2007

  Performs email validation tasks,
 --------------------------------------------------------------

 Place Release\email.dll in your NSIS\Plugins folder.

 ==============================================================
 The Functions:

  EmailValidation::EmailValidation
   Base64 data encryption.

   parameters: email address
   result: "ok" or "fialed" strings


 ==============================================================
 Example:

   EmailValidation::EmailValidation pippo@gino.com
   pop $R0
   
   StrCmp $R0 "failed" abort ''
   

 
