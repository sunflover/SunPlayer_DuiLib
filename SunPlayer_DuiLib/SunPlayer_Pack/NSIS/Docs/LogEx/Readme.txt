 ==============================================================

 LogEx.dll v0.6 (32kB) by JP de Ruiter

  Last build: 28th November 2008

  C NSIS plugin that Writes log to a logfile.

 --------------------------------------------------------------

 Place LogEx.dll in your NSIS\Plugins folder or
 simply extract all files in the Zip to NSIS\

 See Examples\LogEx\Example.nsi for examples of use.

 ==============================================================

 Description:

 LogEx is a logging plugin. 
 It allows to append a string to a logfile and show this string 
 in the status listbox and/or the status bar (like DetailPrint) 

 ==============================================================
 The Functions:

 LogEx::Init /NOUNLOAD [bTruncateFile] FileName

    bTruncateFile
     If true, truncate file, else append to existing file. 
 
    FileName 
     Log file name.

 LogEx::Write /NOUNLOAD [bWriteToStatusList [bWriteToStatusBar]] LogString

    bWriteToStatusList 
     If equal to true, adds the string to the Status Listbox. 

    bWriteToStatusBar 
     If equal to true, adds the string to the Status Bar. 

    LogString 
     String to write to the logfile. 

 LogEx::AddFile /NOUNLOAD [ReadFromLine [ReadToLine]] Prefix FileName

    ReadFromLine 
     Write from line <ReadFromLine> from the file to the logfile. 

    ReadToLine 
     Write to line <ReadToLine> from the file to the logfile. 

    Prefix 
     Prefix to add at the beginning of each new line. 

    FileName 
     File to add to the logfile. 

 LogEx::Close
 ==============================================================
 Change Log:

  v0.1
   * First version

  v0.2
   * - Fixed stack bug
     - Added parameter "bTruncateFile" to Init function
     - Changed the way AddFile function reads the file (read the file at ones in a buffer allocated with VirtualAlloc)
     - Added comments in sourcecode

  v0.3
   * - Fixed bug in AddFile with empty file

  v0.4
   * - Removed newlines on ::Close

  v0.5
   * - Changed the Init function to open the log file in SHARE_READ mode

  v0.6
   * - Added Unicode support
     