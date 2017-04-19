                        ExtractDLL v0.1 beta
                        --------------------
			   Copyright 2002 
                            by Tim Kosse
                          tim.kosse@gmx.de

What is this?
-------------

  ExtractDLL is a extension DLL for NSIS. It can decompress files 
  which were compressed with compressfile.exe before. It is especially
  useful in combination with NSISdl so that you don't have to 
  download large files uncompressed.

Usage
-----

  Decompression (within NSIS script):
  - Push path and name of compressed file and then path and name of 
    destination file on top of the stack.
  - Call the function "extract" with CallInstDLL
  - On Success, the string "success" is on top of the stack, else an 
    error message.
  
  Compression (outside NSIS script or using !system):
  - Call CompressFile.exe with the name of the uncompressed file and 
    of the compressed file as parameters


Known limitations
-----------------

  Only zlip compression at this time, bzip2 will follow later

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
