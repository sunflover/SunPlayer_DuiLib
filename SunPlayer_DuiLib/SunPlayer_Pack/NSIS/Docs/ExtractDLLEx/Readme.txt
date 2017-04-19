                        ExtractDLLEx v1.0
                        -----------------
Original:

Copyright 2002 by Tim Kosse (tim.kosse@gmx.de)
                          
Changes:

	- LZMA compression with crc check
	- file container support
	- wildcard support
	- relative path support
	- as small as possible dll filesize (7680 byte)

Copyright 2004 by Achim Winkler (achim@lkcc.org)


What is this?
-------------

  ExtractDLLEx is a extension DLL for NSIS. It can decompress one or 
  more files from a container file which was created with 
  compressfile.exe before. It is especially useful in combination
  with NSISdl so that you don't have to download large files 
  uncompressed.
  

Usage
-----

  Decompression (within NSIS script):
  - Push path and name of compressed file and then path and name of 
    temporary destination file on top of the stack.
  - Call the function "extract" with CallInstDLL
  - On Success, the string "success" is on top of the stack, else an 
    error message.
  - The decompressed files are created in the same directory like 
    the script executable NSIS script file.
  - The second filename is only used for temporary file access!
  
  Compression (outside NSIS script or using !system):
  - Call CompressFile.exe with the name of the compressed file 
    and the uncompressed files as parameters. You can use relative
    paths of the actual directory. The usage of wildcards like * and
    ? is also supported!
  - Use always / and not \ in your paths!
  - Don't use / in front of relative paths.
  - ../ is not supported in relative paths.
  - CompressFile needs the lzma.exe file!
  
  
Example
-------

  Compression Example:
  
  CompressFile.exe test.7z test.* te?t.exe test1/test2/test.txt
  
  
  Decompression Example (NSIS script):

    Push "test.7z"
    Push "update.tmp"
  
    ExtractDllEx::extract
  
    ;get the result
    Pop $0
    StrCmp $0 success SUCCESS
      MessageBox MB_OK|MB_ICONSTOP "$0"
  
    SUCCESS:
    
    
Process Overview
----------------

  ; batch file to compress files
  CompressFile.exe test.7z test.* test/test.txt
  
  
         test.exe      test.dat    test/test.txt
                 \        |        /
                  \       |       /
                   \      |      /
                    \     |     /
  CompressFile.exe   \    |    /
                      pack.tmp (hardcoded in CompressFile)
                          |
                          |
                       test.7z
  --------------------------------------------------------
                       test.7z   
                          |
                          |
                      update.tmp (temporary file!)
  ExtractDLLEx.dll    /   |   \
                     /    |    \
                    /     |     \
                   /      |      \
                  /       |       \
          test.exe     test.dat    test/test.txt
          
  
  ; nsis script to unpack files
  Push "test.7z"
  Push "update.tmp"
    
  ExtractDllEx::extract
    
  ;get the result
  Pop $0
  StrCmp $0 success SUCCESS
    MessageBox MB_OK|MB_ICONSTOP "$0"
    
  SUCCESS:


Known limitations
-----------------

  Zlip and LZMA compression are included. The included plugin supports
  only LZMA because of the better compression ans smaller filesize.
  

Legal Stuff
-----------

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
