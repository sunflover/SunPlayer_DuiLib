/*============================================================================
   readme.txt - Nullsoft Installer Secure Password Generation Plugin
   Public Domain. Written by: Chase Venters <cventers@southbyte.com>
============================================================================*/

This is a simple Nullsoft Installer plugin designed to generate a good,
secure random password. Doing this means we can't use a crappy PRNG like
the one(s) currently available for NSIS.

Our implementation method is simple: use the Microsoft CryptoAPI for the
random data, which we then squish into a certain limited character set
which defines the acceptable characters for a password. By default, this is
restricted to alphanumerics (62 characters total).

To use this plugin, place the pwgen.dll file in your NSIS\Plugins directory.
To use it in your script:

pwgen::GeneratePassword <number-of-digits-1-to-255>
Pop $0
MessageBox MB_OK "New random password: $0"

I compiled this with Cygwin/gcc-3.4.4. You should modify the makefile (or
spin your own) if you want to build a modified version of this plugin.
