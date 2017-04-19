; Example.nsi
;
; This script is a quick demonstration of how to use GetFirstRemovable.
; This creates a program "GetFirstRemovableExample.exe" which shows the results of the functions
; in the "GetFirstRemovable.DLL" plug-in.
;
; The example script "RealisticExample.nsi" creates an installer for this example program, which uses
; the "GetFirstRemovable.DLL" plug-in to create a typical installer for a portable application. When the
; resulting installer is executed, it will install "GetFirstRemovableExample.exe" as "MyApp" on the portable device.
;
; Support for the environment provided by "PortableApps.com" is included. If this environment is not detected,
; the installation program will support the creation of an AUTORUN.INF file for the application.
;
;--------------------------------

/*
GetFirstRemovable是NSIS获取可移动磁盘盘符的插件。
GetFirstRemovable有两个接口GetFirst和GetAll分别用于获取第一个移动设备盘符和所有移动设备盘符。
*/

Name "GetFirstRemovable Example"

OutFile "GetFirstRemovableExample.exe"

XPStyle on

;--------------------------------

Page instfiles

;--------------------------------

Section ""

  SetAutoClose true

  ; Get the first removable drive:
  GetFirstRemovable::GetFirst
  Pop $R1

  ; And show it...
  MessageBox MB_OK "First removable drive: $R1"

  ; Get all removable drives:
  GetFirstRemovable::GetAll
  Pop $R2

  ; And show them...
  MessageBox MB_OK "All removable drives: $R2"
  
SectionEnd
