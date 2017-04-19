; Sample Script showing NGenKeys + Ncrypt / DcryptDll plugin example, installs supporting program
;    Ncrypt.exe itself in some user chosen directory. Note the DcryptDll folder and its subfolders MUST
;    exist in NSIS\Contrib directory for this script to work. You also need Modern UI, InstallOptions
;    plugin and the NSIS\Contrib\Graphics installed.

;    Also note the !include .\Get_parent_directory.nsi below: this is just SunJammer's GetParent
;    function wrapped with  !macro GetParent UN   ...  !macroend  and the name of the function changed
;    to:  Function ${UN}GetParent  so it can be called from either Installer or Uninstaller, here its
;    being called from uninstaller (see the !insertmacro GetParent "un." line), thanks SunJammer!

;    You also need the Trim.nsi function from the archive in the NSIS\Include folder

;    This script also uses the RegLicKey.ini file that is in the NSIS\Contrib\DcryptDll folder.

; MAKE SURE YOU HAVE COPIED THE DcryptDll.dll PLUGIN to the PLUGINS Directory before compiling the script!
; The installer exe that gets created will be: ${NSDIR}\Contrib\DcryptDll\NcryptSetup.exe

;  This sample demonstrates the Use of the DcryptDll Plugin to decrypt the actual program being installed
;  which is encrypted before being included. This encryption / decryption is an example of a "part of"
;  a Licensing / Registration scheme.

;  The first example script was an example based on the idea of a custom build for each Registered user.
;  This can be impratical in terms of distributing the program, so this example uses a variation which
;  does NOT require custom builds, but DOES require the user to enter a Valid Registration "License"
;  key to install the unencrypted program.

;  The idea here is that we generate a single, static key that is used to encrypt the program.
;  This key is only changed when we have a good reason to change it, so the installer only needs to be
;  BUILT once (or occassionally). I have included the call to NGenKeys to generate this key, but that is
;  just for convenience. In the REAL scenario this call to NGenKeys WONT BE IN THE INSTALLER.

;  The static key that is used to encrypt the program, would NEVER be included or sent to any user in its
;  normal form!
;  Instead, we would have some process (perhaps during registration) that builds a unique .dat file
;  for a particular registered user, and either emails the unique .dat file or allows the user to
;  immediately download it as part of the "registration" process. This unique .dat file will contain
;  TWO pieces of information.

;  In addition to the unique .dat file, we Generate another unique key. We do this for each user at
;  the same time we build the unique .dat file. In fact, we NEED this key in order TO BUILD the unique
;  .dat file. This unique key becomes the "License Key". We send this key to the user (probably through
;  an email, and probably SEPERATE from the unique .dat file).

;  We calculate the MD5 Hash of the unique "License" key, hex encoded. This is the FIRST piece of
;  information that goes into the unique .dat file. We then use the just generated unique "License"
;  key to ENCRYPT the binary form of the static key that was used to encrypt the program.
;  We hex encode this encrypted key, and it becomes the SECOND piece of information that goes into the
;  unique .dat file.

;  I have also included the call to NGenKeys to Generate the 2nd unique, per user "License" key in this
;  script, as well as the calls to build the unique, per user .dat file, again for convenience ONLY.
;  Again, these calls DO NOT BELONG in the installer script in a REAL WORLD scenario.

;  This script, at the appropriate point will prompt for the "License" key. I will have written this
;  to a file named "Ncrypt_lic.txt" to the ${NSISDIR}\Contrib\DcryptDll folder, "pretend" it has been
;  sent to you in an email. You can just open the file, say with notepad, select the hex string, copy
;  to the clipboard, and then paste it into the installer "License" key screen field.

;  The script will also generate and write the unique, per user .dat file to the same folder. Again
;  this code DOES NOT BELONG in the installer script of a REAL WORLD scenario.  Just pretend that we
;  have somehow already distributed this file to the user with instructions to put it in the same
;  directory as the installer .exe file. The name used for the unique .dat file is Ncrypt_reg.dat

;  The rest of the processing after that will be code that WOULD BE in the installer,
;  in the REAL WORLD scenario.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Ncrypt"
!define PRODUCT_VERSION "1.0"
!define PRODUCT_PUBLISHER "Ron Bishop"
!define PRODUCT_WEB_SITE "http://nsis.sourceforge.net/"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\Ncrypt.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_STARTMENU_REGVAL "StartMenuDir"

; want to control compression with SetCompress off, SetCompress auto, so have to use zlib
SetCompressor zlib
;SetCompressor lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"

;PreBuilt Functions used by script
!include ..\Include\Trim.nsi
!include .\Get_parent_directory.nsi
!insertmacro GetParent "un."

;BEGIN General
Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${NSISDIR}\Contrib\DcryptDll\NcryptSetup.exe"
InstallDir "$PROGRAMFILES\Ncrypt"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""

;vars used by script
var START_MENU_FOLDER
var SPARENT
var License_hash ; holds stored MD5 hash of (hex encoded) per user "License" key
var LICENSE_GUID ; holds the per user (hex encoded) "License" key itself
var EKEY         ; holds the hex encoded, decrypted, static key used to decrypt the program itself

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_UNFINISHPAGE_NOAUTOCLOSE
!define MUI_BGCOLOR C1C4C9
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\win-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\win-uninstall.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\win.bmp"

; Welcome page
!insertmacro MUI_PAGE_WELCOME

; License page
!define MUI_LICENSEPAGE_RADIOBUTTONS
!insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Contrib\DcryptDll\License.txt"

; Directory page
!insertmacro MUI_PAGE_DIRECTORY

; additional custom page for Registration License Entry
; key will be put into LICENSE_GUID, hash calculated on and tested in function TestRegLicense
  Page custom ShowRegLicense TestRegLicense

; Note NOT using Start Menu Folder in this script

; Instfiles page
!insertmacro MUI_PAGE_INSTFILES

; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\Ncrypt.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; Reserve files
ReserveFile "RegLicKey.ini" ; the screen for entering the Registration "License" key
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------
  ; Note on MY system lzma, NGenKeys.exe, and Ncrypt.exe are in a folders that are included in my PATH
  ; environement variable.  To compile THIS script you need to have them available, you could put them
  ; in ${NSISDIR}\BIN and insert a !cd ${NSISDIR}\Bin statement here if you dont have them in one of
  ; your PATH folders, OR use defines like  !define NCRYPT ${NSISDIR}\Contrib\DcryptDll\Ncrypt\Ncrypt.exe
  ; and then use !system '${NCRYPT} "bla" "blahblah" ....' = 0 in the Ncrypt calls below
  ; and do the same for lzma.exe and NGenKeys.exe

;BEGIN block of code that DOES NOT BELONG in the script in the REAL WORLD scenario.

  ; STEP 1: generate a key:
  ; generate an Auto Random key (this would be the STATIC key normally already done, OUTSIDE the script)
  ; 1st parm says generate a key & write it to an output file in BINARY form (we are going to renecrypt
  ;      it with per user key, dont want to encrypt hex form but binary form),  (-BA)
  ; 2nd parm is desired key (binary) size in bytes
  ; 3rd parm is the name of the Output File to write it to, I am going to put this into DcryptDll folder
  ;       would normally already exist in a file somewhere.

  ; Create an 8 byte key and store in NcryptKey.bin
  ; NcryptKey.bin will contain the 8 byte binary static key. Note we will need to get a hex encoded
  ;          form of this for actually doing the program encryption, but we want it binary for using
  ;          the per user, unique "License" key to encrypt the static key itself
  !system 'NGenKeys "-BA" "8" "${NSISDIR}\Contrib\DcryptDll\NcryptKey.bin"' = 0

  ; Hex encode the static key for when we actually encrypt the program later on
  !system 'Ncrypt "-HE" "${NSISDIR}\Contrib\DcryptDll\NcryptKey.bin" \
                        "${NSISDIR}\Contrib\DcryptDll\NcryptKey.hex"' = 0

  ; now we need the per user, unique "License" key. Again this code WOULD NOT BE IN THIS SCRIPT in the
  ;    REAL WORLD scenario, just here for your convenience
  ;   note I generated the key as binary and then use Ncrypt.exe to Hex encode it with optional format
  ;     string so it will be more human readable
  !system 'NGenKeys "-BA" "8" "${NSISDIR}\Contrib\DcryptDll\Ncrypt_lic.bin"' = 0

  ; now make the "License" key human readable
  ; You would normally want to keep this key in a database along with user registration info in case
  ; the user ever loses it and needs to request it again (or maybe to REQUIRE user to send it back for
  ; verification purposes, etc.)
  !system 'Ncrypt "-HE" "${NSISDIR}\Contrib\DcryptDll\Ncrypt_lic.bin" \
                        "${NSISDIR}\Contrib\DcryptDll\Ncrypt_lic.txt" "####-####-####-####' = 0

  ; calculate MD5 hash of the human readable, hex encoded form of the "License" key
  ;  for inclusion into the unique, per user .dat file (doing this as we will have the user include
  ;  the hyphens and just do our dynamic MD5 hash of the resulting, formated hex string)
  !system 'Ncrypt "-MH" "${NSISDIR}\Contrib\DcryptDll\Ncrypt_lic.txt" \
                        "${NSISDIR}\Contrib\DcryptDll\Ncrypt_reg.dat"' = 0

  ; encrypt the "static" encryption/decryption key WITH the per user, unique "License" key
  ; note its okay that this hex string is FORMATTED, Ncrypt just throws away non hex chars for KEYSTRINGS
  !system 'Ncrypt "-FF" "${NSISDIR}\Contrib\DcryptDll\Ncrypt_lic.txt" \
                        "${NSISDIR}\Contrib\DcryptDll\NcryptKey.bin"  \
                        "${NSISDIR}\Contrib\DcryptDll\USerNcryptKey.bin"' = 0

  ; now hex encode the encrypted "static" key for inclusion into the unique, per user .dat file
  ;   note not using optional format string here, just want unformated, hex encoded key
  !system 'Ncrypt "-HE" "${NSISDIR}\Contrib\DcryptDll\USerNcryptKey.bin" \
                        "${NSISDIR}\Contrib\DcryptDll\USerNcryptKey.hex"' = 0

  ;concatenate hex encoded, encrypted static key to the .dat file
  !system 'type "${NSISDIR}\Contrib\DcryptDll\USerNcryptKey.hex" >> \
                "${NSISDIR}\Contrib\DcryptDll\Ncrypt_reg.dat"' = 0
;END block of code that DOES NOT BELONG in the script in the REAL WORLD scenario.

; The rest of the script (except for some clean up later) IS code that WOULD BE IN the script in the
; REAL WORLD scenario

  ; STEP 1: compress the file BEFORE encrypting as encrypted data will NOT compress well.
  ; if keyfile created okay, compress the file FIRST as encrypted files dont compress worth a damm!
  ; note on my system, I have put lzma.exe into NSIS\Bin
  !system '${NSISDIR}\Bin\lzma "e" "${NSISDIR}\Contrib\DcryptDll\Ncrypt\Ncrypt.exe" \
  "${NSISDIR}\Contrib\DcryptDll\Ncrypt.lza" ' = 0

  ; STEP 2: encrypt the compressed file using our "static" key, would normally be in some OTHER folder:
  ; file compressed now use Ncrypt.exe to encrypt it using "static" key in file NcryptKey.hex
  ; 1st parm (-FF) says use a keyfile containing a hex encoded key to encrypt a FILE to an Output FILE
  ; 2nd parm is the name of the keyfile, 3rd parm is the name of the file to encrypt,
  ; 4th parm is the name of the encrypted file
  !system 'Ncrypt "-FF" "${NSISDIR}\Contrib\DcryptDll\NcryptKey.hex" \
  "${NSISDIR}\Contrib\DcryptDll\Ncrypt.lza" "${NSISDIR}\Contrib\DcryptDll\Ncrypt.enc"' = 0

;END General

;Function PreSetup checks that user has put our Ncrypt_reg.dat file in the folder containing
;   the Installer .exe, loads the precalculated MD5 Hash of the "License" key for verification
;   of the License key that will be entered by user,
;   Loads the ENCRYPTED, hex encoded static program encryption/decryption key
Function PreSetup

  InitPluginsDir

  ; target system: check for .dat file (user given instructions to put in same directory as installer)
  ifFileExists "$EXEDIR\Ncrypt_reg.dat" ok1
  MessageBox MB_OK|MB_ICONSTOP "Error In Installation, can't find registration file Ncrypt_reg.dat!"
  Abort
  ok1:
  
  ; target system: load our registration data file data to a string using DcryptDll::LoadStr
  ; save registers going to use
  push $R0
  push $R1

  ; LoadStr requires single parm: the InputFileName, but don't forget stack end marker!
  DcryptDll::LoadStr "$EXEDIR\Ncrypt_reg.dat" "--End--"
  ; check return status message (pop from stack)
  pop $R0 ; if no errors will be "OK", otherwise an error message
  StrCmp $R0 "OK" regdataread 0
  MessageBox MB_OK|MB_ICONSTOP "Error Reading registration file Ncrypt_reg.dat, Installation Aborting!"
  Abort

  regdataread:
  pop $R0 ; status was okay pop the string
  ; make sure str is 48 bytes (32 for MD5 Hash, 16 for Hex Encoded, encrypted 8 byte static key)
  Strlen $R1 $R0
  IntCmp $R1 48 regdataok
  MessageBox MB_OK|MB_ICONSTOP "Error Reading registration file Ncrypt_reg.dat, Installation Aborting!"
  Abort

  regdataok:
  ; break registration data into seperate fields License_hash, EKEY,
  ; get 1st 32 bytes into License_hash for test against dynamically calculated hash of entered key
  StrCpy $License_hash $R0 32

  ; get last 16 bytes into EKEY for later decryption by License Key
  StrCpy $EKEY $R0 16 32

  ;restore saved registers
  pop $R1
  pop $R0
  
FunctionEnd

;--------------------------------
;Installer Functions cuz added custom page for license key registration
Function .onInit
  ; call function PreSetup to load necessary info from registration data file Ncrypt_reg.dat into vars
  call PreSetup

 ;Extract my InstallOptions custom license page INI file
  !insertmacro MUI_INSTALLOPTIONS_EXTRACT_AS "${NSISDIR}\Contrib\DcryptDll\RegLicKey.ini" "RegLicKey.ini"

FunctionEnd

; RegLicKey custom page titles
LangString TEXT_IO_TITLE ${LANG_ENGLISH} "Ncrypt Registration License Key Entry"
LangString TEXT_IO_SUBTITLE ${LANG_ENGLISH} "Entry Format is: ########-########-########-########"

; function to Init and Show my custom Registration License page
Function ShowRegLicense
  !insertmacro MUI_HEADER_TEXT "$(TEXT_IO_TITLE)" "$(TEXT_IO_SUBTITLE)"
  !insertmacro MUI_INSTALLOPTIONS_DISPLAY "RegLicKey.ini"
FunctionEnd

; AFTER my custom Registration License Page (i.e. on NEXT buttom): test the entered key
Function TestRegLicense
  ; get the license key
  !insertmacro MUI_INSTALLOPTIONS_READ $LICENSE_GUID "RegLicKey.ini" "Field 1" "State"

  push $R0  ; habit to save vars before using
  push $R1  ; habit to save vars before using
  push $R2  ; habit to save vars before using

  ; trim any leading or trailing blanks from key
  push $LICENSE_GUID
  call Trim
  pop  $LICENSE_GUID

  ; check length (should be 16 + 3 hyphens = 19
  StrLen $R0 $LICENSE_GUID
  IntCmp $R0 19 ok2
  MessageBox MB_OK|MB_ICONSTOP "Invalid Registration Key, please Reenter."
  Abort ; note aborts from this funct DONT abort the program, just the "leaving" of the page
  ok2:

  ; test that key got entered correctly by having DecCryptDll calc hash of just entered key and
  ; comparing it against our saved hash, Remember DcryptDll's MD5 hash ALWAYS hex encodes

  ; MD5Hash of the key STRING enterend to a hex encoded STRING: DcryptDll::MD5Hash SS InputString
  DcryptDll::MD5Hash "SS" "$LICENSE_GUID" "--End--"
  ; check return status message (pop from stack)
  pop $R0 ; if no errors will be "OK", otherwise an error message
  StrCmp $R0 "OK" ok3 0
  MessageBox MB_OK|MB_ICONSTOP "Invalid Registration Key, please Reenter."
  Abort
  ok3:

  pop $R0 ; have the hash
  ; compare against already loaded saved hash
  StrCmp $R0 $License_hash ok4  ;test computed digest in R0 against saved digest
  MessageBox MB_OK|MB_ICONSTOP "Invalid Registration Key, please Reenter."
  Abort
  ok4:

  ;hash digests were equal, key license file okay, can continue
  pop $R2 ; restore saved registers
  pop $R1 ; restore saved registers
  pop $R0 ; restore saved registers

FunctionEnd

Section "MainSection" SEC01

  ; folder for extracting the files
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer

  ; since encrypted files dont compress we compressed BEFORE encrypting, will need to decompress AFTER
  ; decrypting on target system so (for now) inluding lzma itself to do decompression on target system
  File /oname=$PLUGINSDIR\lzma.exe ${NSISDIR}\Bin\lzma.exe

  ; since file was compressed BEFORE encrypting, tell NSIS NOT to compress
  ; note extracting to PLUGINSDIR as needs to be decrypted and decompressed before going to $INSTDIR
  SetCompress off

  ; our file statements
  File /oname=$PLUGINSDIR\Ncrypt.enc ${NSISDIR}\Contrib\DcryptDll\Ncrypt.enc ;the encrypted file

  ; turn compression back on (to auto) for other normal (i.e. not encrypted files)
  SetCompress auto

  push $R0  ; habit to save vars before using

  ; at this point we should have our hex encoded license key in $LICENSE_GUID and
  ; the hex encoded, ENCRYPTED static key used to encrypt the program in $EKEY
  ; 1st need to get EKEY back to binary, so will use DcryptDll HexDecoder "SF" (String to File) function
  ; note we cant use the "SS" string to string function because our hex DECODED string will be BINARY
  ; i.e. may contain binary 0's anywhere in it
  
  DcryptDll::HexDecoder "SF" "$EKEY" "$PLUGINSDIR\tmp1.dat" "--End--"

  ; check return status message (pop from stack)
  pop $R0 ; if no errors will be "OK", otherwise an error message
  StrCmp $R0 "OK" decodeok 0
  MessageBox MB_ICONEXCLAMATION|MB_OK "Error with Installation: $R0...Installation Aborting!"
  Abort ; error occurred, could test status message in $R0 for more elegant handling

  decodeok:
  ; now use our license key to Decrypt the binary encrypted static key directly to a hex encoded string
  ; so we can use the decrypted key for decrypting our program, note this keeps our decrypted static
  ; key 1: hex encoded, and 2: NEVER on users disk, only in memory!

  ; Parms for DcryptDll::Decrypt  1: Function, 2: HexKeyString, 3: FileToDecrypt
  DcryptDll::Decrypt "SFH" "$LICENSE_GUID" "$PLUGINSDIR\tmp1.dat" "--End--"

  ; check return status message (pop from stack)
  pop $R0 ; if no errors will be "OK", otherwise an error message
  StrCmp $R0 "OK" dcryptok1 0
  MessageBox MB_ICONEXCLAMATION|MB_OK "Error with Installation: $R0...Installation Aborting!"
  Abort ; error occurred, could test status message in $R0 for more elegant handling

  dcryptok1: ; decrypted okay, pop the decrypted, hex encoded static key into our var
  pop $EKEY
  delete $PLUGINSDIR\tmp1.dat ; done with tmp1.dat delete it
  ; we could let Installer remove tmp1.dat but like to get rid of key type info as soon as possible

  ; Plugin call to decrypt the encrypted, compressed Ncrypt.exe (named Ncrypt.enc in PluginsDir)
  ;Use function that [D]ecrypts using hex encoded key in [String] to decrypt [File] to [File]
  ; i.e. using Decrypt "SFF"
  
  ; Parms for DcryptDll::Decrypt  1: Function, 2: HexKeyString, 3: FileToDecrypt, 4: UnencryptedOutputFile
  DcryptDll::Decrypt "SFF" "$EKEY" "$PLUGINSDIR\Ncrypt.enc" "$PLUGINSDIR\Ncrypt.lza" "--End--"

  ; check return status message (pop from stack)
  pop $R0 ; if no errors will be "OK", otherwise an error message
  StrCmp $R0 "OK" dcryptok2 0
  MessageBox MB_ICONEXCLAMATION|MB_OK "Error with Installation: ...Installation Aborting!"
  Abort ; error occurred, could test status message in $R0 for more elegant handling

  dcryptok2: ; decrypted okay

  ; now use Extracted lzma to decompress decrypted file (Ncrypt.lza) directly to the INSTALLATION directory
  ExecWait '"$PLUGINSDIR\lzma.exe" "d" "$PLUGINSDIR\Ncrypt.lza" "$INSTDIR\Ncrypt.exe"' $R0
  
  ;test lzma decompress result code
  IntCmp $R0 0 dcompressok
  MessageBox MB_OK|MB_ICONSTOP "Error Decompressing File Ncrypt.lza"
  Abort
  
  dcompressok: ; lzma decompressed okay, can finish the installation
  
  pop $R0 ; done using $R0, restore saved $R0 from stack: habit

  ; Create the Start Menu Folder and Desktop shortcuts
  StrCpy $START_MENU_FOLDER "$SMPROGRAMS\StarBirth Software\Ncrypt"
  CreateDirectory "$START_MENU_FOLDER"
  CreateShortCut "$START_MENU_FOLDER\Ncrypt.lnk" "$INSTDIR\Ncrypt.exe"
  CreateShortCut "$DESKTOP\Ncrypt.lnk" "$INSTDIR\Ncrypt.exe"

  ; note would probably normally write the $LICENSE_GUID to the registry here for use by the program
  ; itself, but not bothering for this little example, cuz Ncrypt.exe doesn't REALLY require any
  ; Registration! ;-)
  
  ; clean up files on DEVELOPMENT (Installer MAKER) system, we no longer need
  !system 'del ${NSISDIR}\Contrib\DcryptDll\Ncrypt_lic.bin'
  !system 'del ${NSISDIR}\Contrib\DcryptDll\UserNcryptKey.bin'
  !system 'del ${NSISDIR}\Contrib\DcryptDll\UserNcryptKey.hex'
  !system 'del ${NSISDIR}\Contrib\DcryptDll\Ncrypt.lza'
  !system 'del ${NSISDIR}\Contrib\DcryptDll\Ncrypt.enc'

  ; would NOT normally delete the KEY! but would not normally be generating inside the script!
  !system 'del ${NSISDIR}\Contrib\DcryptDll\NcryptKey.bin'
  !system 'del ${NSISDIR}\Contrib\DcryptDll\NcryptKey.hex'

SectionEnd

; hidden section for additional shortcuts / registry entry
Section -AdditionalIcons
;  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  ; create the website and unistall shortcuts
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$START_MENU_FOLDER\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$START_MENU_FOLDER\Uninstall.lnk" "$INSTDIR\uninst.exe"
;  !insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

; hidden section for registry entries / unistaller creation
Section -Post
  ; save registry keys and create the uninstaller program
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\Ncrypt.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\Ncrypt.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "StartMenuDir" "$START_MENU_FOLDER"
  
SectionEnd

; uninstaller sections:
Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall

  ; Get START MENU Folder shortcuts created in, note NOT using Start Menu Page
   ;!insertmacro MUI_STARTMENU_GETFOLDER "Application" $START_MENU_FOLDER
  ReadRegStr $START_MENU_FOLDER ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "StartMenuDir"

  ;Delete the shortcuts
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\Ncrypt.exe"

  Delete "$START_MENU_FOLDER\Uninstall.lnk"
  Delete "$START_MENU_FOLDER\Website.lnk"
  Delete "$DESKTOP\Ncrypt.lnk"
  Delete "$START_MENU_FOLDER\Ncrypt.lnk"

  ; get shortcut folders parent, thanks sunjammer!
  push $R0 ; save current value of R0 : good habit
     push "$START_MENU_FOLDER" ; put startmenu forder onto stack
     call un.GetParent ; get startmenu folder's parent
     pop $SPARENT ; pop GetParent's "return" value off stack
  pop $R0 ; restore R0: good habit

  ; remove directories (start menu and install folders)
  RMDir "$START_MENU_FOLDER"
  RMDir "$SPARENT" ; note will only remove if empty
  RMDir "$INSTDIR"

  ; clean up the registry
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose false
  
SectionEnd
; thats all folks!