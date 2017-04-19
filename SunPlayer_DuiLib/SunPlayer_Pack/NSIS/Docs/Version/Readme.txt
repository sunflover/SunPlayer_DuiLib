  Plugin DLL for NSIS 2 (Nullsoft Scriptable Install System Version version 2)

  "Version Information"

  Copyright (C) 2004 Denis (DNG) Gorbunov (software-development@gorbunov.ru)
  Created 3 sep 2004, version 0.1


Before use:

    Variant A:
       Copy "version.dll" to "Plugins" sub-directory of your NSIS installation
       (for example "C:\Program Files\NSIS2\Plugins\")

    Variant B:
       If your NSIS script file is "C:\MyDistribs\MyAppDistrib\myapp.nsi" then
       copy "version.dll" to "Plugins" sub-directory
       (for example "C:\MyDistribs\MyAppDirtrib\Plugins\")
       and append string
       !addplugindir "plugins"
       to your NSIS script file.


Script Examples:

  1. In your NSIS script file write (detect Windows XP example):

  ; variable declaration
  var Result
  ...
  ; call function from this plugin dll
  Version::IsWindowsXP
  ; get function result
  Pop $Result
  ; check result - it is "1" (if Windows XP) or "0" (if not Windows XP)
  StrCmp $Result "1" Label_ItIsWindowsXP Label_ItIsNotWindowsXP
  ...
  Label_ItIsWindowsXP:
  ; if Windows XP detected then
  ...
  Label_ItIsNotWindowsXP:
  ; if Windows XP not detected then
  ...

  2. or instead of "Version::IsWindowsXP" write (detect other Windows OS):
  Version::IsWindows31,
  Version::IsWindows95,
  Version::IsWindows98,
  Version::IsWindowsME,
  Version::IsWindowsNT351,
  Version::IsWindowsNT40,
  Version::IsWindows2000,
  Version::IsWindowsXP,
  or Version::IsWindows2003

  3. or instead of "Version::IsWindowsXP" write (detect Windows OS platform classes):
  Version::IsWindowsPlatformNT
  or Version::IsWindowsPlatform9x

  ; Platform "NT" is Windows NT 3.51, Windows NT 4.0, Windows 2000,
  ; Windows XP, or Windows 2003

  ; Platform "9x" is Windows 95, Windows 98, Windows ME

  4. or instead of "Version::IsWindowsXP" write (detect "good" Windows OS):
  Version::IsWindows98orLater

  ; "Good" Windows OS is Windows 98, Windows ME, Windows 2000, Windows XP, Windows 2003
  ; No "good" Windows OS is Windows 3.1, Windows NT 3.51, Windows NT 4.0, Windows 95

  5.  In your NSIS script file write:
  ; variable declaration
  var MajorVersion
  var MinorVersion
  var BuildNumber
  var PlatformID
  var CSDVersion  
  ...
  ; call function from this plugin dll
  Version::GetWindowsVersion
  ; get function result
  Pop $MajorVersion
  Pop $MinorVersion
  Pop $BuildNumber
  Pop $PlatformID
  Pop $CSDVersion
  ; show result
  MessageBox MB_OK "$PlatformID-platform, version $MajorVersion.$MinorVersion, build $BuildNumber, $CSDVersion"

  ; Platform ID is "NT", "9x", "Win32s" or "Unknown"
  ; Platform "NT" is Windows NT 3.51, Windows NT 4.0, Windows 2000,
  ; Windows XP, Windows 2003
  ; Platform "9x" is Windows 95, Windows 98, Windows ME
  ; Platform "Win32s" is Win32s on Windows 3.1

  ; CSD Version is name of latest Service Pack installed on the OS.
  ; If no Service Pack has been installed, the string is empty.
  ; For Windows 95, Windows 98, and Windows ME CSD Version is
  ; additional version information. For example,
  ; " C" indicates Windows 95 OSR2 and " A" indicates Windows 98 Second Edition.

  ; i.e
  ; for Windows XP Service Pack 1:
  ; Major Version is "5"
  ; Minor Version is "1"
  ; Build Number is
  ; Platform ID is "NT"
  ; Messager box show "NT-platform, version 5.1, build 2600, Service Pack 1"

  ; i.e  
  ; for Windows 98 Second Edition:
  ; Major Version is "4"
  ; Minor Version is "10"
  ; Build Number is "2222"
  ; Platform ID is "9x"
  ; Messager box show "9x-platform, version 4.10, build 2222, A"

