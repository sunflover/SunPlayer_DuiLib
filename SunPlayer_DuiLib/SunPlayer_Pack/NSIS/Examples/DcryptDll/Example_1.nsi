; Sample Script showing NGenKeys + Ncrypt / DcryptDll plugin example, installs supporting program
;    NGenKeys.exe itself in some user chosen directory. Note DcryptDll folder and its subfolders MUST
;    exist in NSIS\Contrib directory for this script to work. You also need Modern UI, InstallOptions
;    plugin and the NSIS\Contrib\Graphics installed.
;    Also note the !include .\Get_parent_directory.nsi below: this is just SunJammer's GetParent
;    function wrapped with  !macro GetParent UN   ...  !macroend  and the name of the function changed
;    to:  Function ${UN}GetParent  so it can be called from either Installer or Uninstaller, here its
;    being called from uninstaller (see the !insertmacro GetParent "un." line), thanks SunJammer!

; MAKE SURE YOU HAVE COPIED THE DcryptDll.dll PLUGIN to the PLUGINS Directory before compiling the script!
; The installer exe that gets created will be: ${NSDIR}\Contrib\DcryptDll\NGenKeysSetup.exe

;  This sample demonstrates the Use of the DcryptDll Plugin to decrypt the actual program being installed
;  which is encrypted before being included. This encryption / decryption is an example of a "part of"
;  a Licensing / Registration scheme, where the idea is that we do a CUSTOM installer build for each
;  user. The key that is used for the encryption and decryption BECOMES the "Registration License Key".
;  We would normally Generate this key OUTSIDE the script and send it to the user through a different
;  channel (perhaps email) with instructions to place the file into the same directory as the installer
;  exe itself. We would NOT include the key in installer as shown here.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "NGenKeys"
!define PRODUCT_VERSION "1.0"
!define PRODUCT_PUBLISHER "Ron Bishop"
!define PRODUCT_WEB_SITE "http://nsis.sourceforge.net/"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\NGenKeys.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_STARTMENU_REGVAL "StartMenuDir"
; want to control compression with SetCompress off, SetCompress auto, so have to use zlib
SetCompressor zlib
;SetCompressor lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"

;PreBuilt Functions used by script
!include .\Get_parent_directory.nsi
!insertmacro GetParent "un."

;General
Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${NSISDIR}\Contrib\DcryptDll\NGenKeysSetup.exe"
InstallDir "$PROGRAMFILES\NGenKeys"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""

;vars used by script
var START_MENU_FOLDER
var SPARENT

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

; Note NOT using Start Menu Folder in this script

; Instfiles page
!insertmacro MUI_PAGE_INSTFILES

; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\NGenKeys.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Section "MainSection" SEC01

  ; extract the files
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer

  ; Note on MY system NGenKeys.exe AND Ncrypt.exe are in a folder that is included in my PATH environement
  ; variable.  To compile THIS script you need to have them available, you could put them in ${NSISDIR}\BIN
  ; and insert a !cd ${NSISDIR}\Bin statement here if you dont have them in one of your PATH folders
  
  ; note: would NORMALLY use some OTHER method (outside NSIS entirely) to generate a key and would then,
  ; SEND the key to the end user through email or something, definitely would NOT include the key file
  ; IN the installer (a TERRIBLE idea).  For THIS demo, however, am going to generate key file AND include
  ; it in the distribution, just to show an example of using the key generator in addition to showing how
  ; to encrypt on development (installer MAKER) system using Ncrypt.exe and how to decrypt on TARGET
  ; system using DcryptDll plugin.

  ; STEP 1: generate a key:
  ; generate a key (using a passphrase for seed (see above note)
  ; 1st parm says generate a key & write it to an output file, HEX encoded, using passphrase as a SEED (-HS)
  ; 2nd parm is desired key size (binary NOT hex encoded size, i.e 8 will produce 16 bytes hex encoded)
  ; 3rd parm is the passphrase, note be sure to enclose the passphrase in quotes if contains whitespace
  ; 4th parm is the name of the keyfile to contain the HEX ENCODED key that gets generated

  ; You would normally want to keep this key in a database along with user registration info in case
  ; the user ever loses it and needs to request it again (or maybe to REQUIRE user to send it back for
  ; verification purposes, etc.)
  
  ; Create an 8 byte key and store in NGenKeys.lky, using "mary had a little lamb" as passphrase for seed
  ; NGenKeys.lky will contain the 8 byte key hex encoded to 16 bytes, DcryptDll will do the necessary
  ; hex DECODING to get it back to an 8 byte binary key on the target machine.
  !system '"${NSISDIR}\Bin\NGenKeys" "-HS" "8" "mary had a little lamb" "${NSISDIR}\Contrib\DcryptDll\NGenKeys.lky"' = 0
  
  ; STEP 2: compress the file BEFORE encrypting as encrypted data will NOT compress well.
  ; if keyfile created okay, compress the file FIRST as encrypted files dont compress worth a damm!
  ; note on my system, I have put lzma.exe into NSIS\Bin
  !system '"${NSISDIR}\Bin\lzma" "e" "${NSISDIR}\Contrib\DcryptDll\NGenKeys\NGenKeys.Exe" \
  "${NSISDIR}\Contrib\DcryptDll\NGenKeys.lza" ' = 0

  ; STEP 3: encrypt the compressed file:
  ; file compressed now use Ncrypt.exe to encrypt it using key in file NGenkeys.lky created above
  ; 1st parm (-FF) says use a keyfile containing a hex encoded key to encrypt a FILE to an Output FILE
  ; 2nd parm is the name of the keyfile, 3rd parm is the name of the file to encrypt,
  ; 4th parm is the name of the encrypted file
  !system '"${NSISDIR}\Bin\Ncrypt" "-FF" "${NSISDIR}\Contrib\DcryptDll\NGenKeys.lky" \
  "${NSISDIR}\Contrib\DcryptDll\NGenKeys.lza" "${NSISDIR}\Contrib\DcryptDll\NGenKeys.dat"' = 0

  ; now that file has been compressed and ENCRYPTED, just do our file statements
  InitPluginsDir
  ; since encrypted files dont compress we compressed BEFORE encrypting, will need to decompress AFTER
  ; decrypting on target system so (for now) inluding lzma itself to do decompression on target system
  ; output to PLUGINSDIR so lzma.exe will get cleaned off target system
  File /oname=$PLUGINSDIR\lzma.exe "${NSISDIR}\Bin\lzma.exe"

  ; note here I am including the keyfile (would NOT normally do, see above notes)
  ; also note /oname on file statement as DONT want the encrypted, compressed file to go to $INSTDIR
  ; will need to decrypt (on target system using DcryptDll) 1st, then decompress using above included lzma
  ; on target system. We will decompress to the $INSTDIR, note using $PLUGINSDIR as it gets cleaned up

  ; note extracting key file to $EXEDIR, this is where would probaby tell the user to put the file
  ; if we sent it thru email
  File /oname=$EXEDIR\NGenKeys.lky "${NSISDIR}\Contrib\DcryptDll\NGenKeys.lky" ;the key

  ; since file was compressed BEFORE encrypting, tell NSIS NOT to compress
  SetCompress off
  File /oname=$PLUGINSDIR\NGenKeys.dat "${NSISDIR}\Contrib\DcryptDll\NGenKeys.dat" ;the encrypted file

  ; turn compression back on (to auto)
  SetCompress auto

  push $R0  ; habit to save vars before using

  ; FIRST push "Stack Marker". This plugin REQUIRES use of --End-- as stack marker before pushing parms.
  ; Note: COULD (and probably should) include as LAST parm on the invocation line below instead of pushing 1st.
  push "--End--" 
  
  ; Plugin call to decrypt the encrypted NGenkeys.exe (named NGenKeys.dat in PluginsDir)
  ;Use function that [D]ecrypts using hex encoded key in [File] to decrypt [File] to [File]
  ; i.e. using Decrypt "FFF"
  
  ; Parms for DcryptDll::Decrypt  1: Function, 2: HexKeyFileName, 3: FileToDecrypt, 4: UnencryptedOutputFile
  ; note decrypting to PLUGINSDIR as need to decompress before putting into $INSTDIR
  DcryptDll::Decrypt "FFF" "$EXEDIR\NGenKeys.lky" "$PLUGINSDIR\NGenKeys.dat" "$PLUGINSDIR\NGenKeys.lza"

  ; check return status message (pop from stack)
  pop $R0 ; if no errors will be "OK", otherwise an error message
  StrCmp $R0 "OK" dcryptok 0
  MessageBox MB_ICONEXCLAMATION|MB_OK "Error with Installation: $R0 ...Installation Aborting!"
  Abort ; error occurred, could test status message in $R0 for more elegant handling

  dcryptok: ; decrypted okay

  ; now use Extracted lzma to decompress decrypted file (NGenKeys.lza) directly to the INSTALLATION directory
  ExecWait '"$PLUGINSDIR\lzma.exe" "d" "$PLUGINSDIR\NGenKeys.lza" "$INSTDIR\NGenKeys.exe"' $R0
  
  ;test lzma decompress result code
  IntCmp $R0 0 dcompressok
  MessageBox MB_OK|MB_ICONSTOP "Error Decompressing File NGenKeys.lza"
  Abort
  
  dcompressok: ; lzma decompressed okay, can finish the installation
  
  ; delete key file NOTE probably would NOT usually do this, would probably email it to user with
  ; instructions to put it in the same directory as the install program itself ($EXEDIR), and tell the
  ; user to backup the installer directory (installer program AND key file) before running installation
  ClearErrors
  Delete "$EXEDIR\NGenKeys.lky"
  IfErrors 0 +2
  MessageBox MB_ICONEXCLAMATION|MB_OK "Error deleting $EXEDIR\NGenKeys.lky"

  pop $R0 ; done using $R0, restore saved $R0 from stack: habit

  ; Create the Start Menu Folder and Desktop shortcuts
  StrCpy $START_MENU_FOLDER "$SMPROGRAMS\StarBirth Software\NGenKeys"
  CreateDirectory "$START_MENU_FOLDER"
  CreateShortCut "$START_MENU_FOLDER\NGenKeys.lnk" "$INSTDIR\NGenKeys.exe"
  CreateShortCut "$DESKTOP\NGenKeys.lnk" "$INSTDIR\NGenKeys.exe"

  ; clean up files on DEVELOPMENT (Installer MAKER) system, we no longer need
  ; would NOT normally delete the KEY! but then would NOT normally INCLUDE the key (send it via email)
  !system 'del ${NSISDIR}\Contrib\DcryptDll\NGenkeys.lky'
  !system 'del ${NSISDIR}\Contrib\DcryptDll\NGenKeys.lza'
  !system 'del ${NSISDIR}\Contrib\DcryptDll\NGenKeys.dat'

SectionEnd

; hidden section for additional shortcuts / registry entry
Section -AdditionalIcons
  ; create the website and unistall shortcuts
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$START_MENU_FOLDER\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$START_MENU_FOLDER\Uninstall.lnk" "$INSTDIR\uninst.exe"

SectionEnd

; hidden section for registry entries / unistaller creation
Section -Post
  ; save registry keys and create the uninstaller program
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\NGenKeys.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\NGenKeys.exe"
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
  Delete "$INSTDIR\NGenKeys.exe"

  Delete "$START_MENU_FOLDER\Uninstall.lnk"
  Delete "$START_MENU_FOLDER\Website.lnk"
  Delete "$DESKTOP\NGenKeys.lnk"
  Delete "$START_MENU_FOLDER\NGenKeys.lnk"

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
