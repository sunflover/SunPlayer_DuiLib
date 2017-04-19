CRCCheck.dll - small (3k) NSIS plugin that generates a standard ZIP
CRC32 for a file you specify.

To use:

Add the following lines to your .NSI file, in any function or section:

CRCCheck::GenCRC "$INSTDIR\app.exe"
Pop $R1

At this point $R1 (or any variable you specify) contains either a 10
char CRC, or "0", depending on whether the operation was successful or
not.

Note: this plugin simply reuses the CRC algorithm from VPatch, with a
few tweaks.

The latest version can be found here: http://editor.nfscheats.com/private/crccheck.dll

*****************************
V1.3
 - A few little fixes

V1.2
 - Changed _ui64toa to _ultoa,
   now uses unsigned longs

V1.1
 - Rewritten in VC++ 7, file-
   size from 168KB to 3KB

V1.0
 - Initial Release, in Delphi
*****************************


Cheers,
-Brett Dever, aka SpiderVenom


*****************************
Copyright © 2003 Brett Dever

Portions Copyright © 2002-2003:
- Van de Sande Productions