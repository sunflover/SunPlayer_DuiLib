
; if "version.dll" copied in NSIS plugin sub-directory
; this line is not necessary

!addplugindir "plugins"


; it is not example
; it is for this empty intallation only

OutFile "example_Version_NSIS_plugin.exe"


Section Dummy
; it is not example
; it is for this empty intallation only
SectionEnd


; variables declaration

var TempResult
var MajorVersion
var MinorVersion
var BuildNumber
var PlatformID
var CSDVersion


Function .onInit

  ; detect Windows XP
  ; it is simply

  ; call plugin dll function 

  Version::IsWindowsXP

  ; get result

  Pop $TempResult

  ; check result

  StrCmp $TempResult "1" ItIsWindowsXP IsIsNotWindowsXP

  ItIsWindowsXP:
  MessageBox MB_OK "This OS is Windows XP"
  Goto Go2

  IsIsNotWindowsXP:
  MessageBox MB_OK "This OS not is Windows XP"
  Goto Go2


  ; get Windows OS version info

  Go2:

  ; call plugin dll function 

  Version::GetWindowsVersion

  ; get result

  Pop $MajorVersion
  Pop $MinorVersion
  Pop $BuildNumber
  Pop $PlatformID
  Pop $CSDVersion

  ; show result
  MessageBox MB_OK "$PlatformID-platform, version $MajorVersion.$MinorVersion, build $BuildNumber, $CSDVersion"

FunctionEnd
