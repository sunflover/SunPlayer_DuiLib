; NSIS xtInfoPlugin Example Script by Jari Berg Jensen.
; File is part of NSIS xtInfoPlugin by Jari Berg Jensen.
;
; Copyright 2004 Jari Berg Jensen. All Rights Reserved.
;
; DISCLAIMER
; Please feel free to do anything with the code as long as the copyright message above
; and this disclaimer is present in the file.
; ALL USE OF THIS CODE IS AT YOUR OWN RISK
; ==================================================================================


; ==================================================================================
; Download xtInfoPlugin from
; http://www.razormotion.com/nsis/xtInfoPlugin.zip

; best to copy xtInfoPlugin.dll to NSIS\Plugins and remove below code
; but this is kind a handy feature...

!addplugindir ".\" ; detect xtInfoPlugin.dll in current directory
!addplugindir "..\" ; detect xtInfoPlugin.dll in parent directory
Name "NSIS xtInfoPlugin-MinimalExample"
OutFile "xtInfoPlugin-MinimalExample.exe"
SetCompress off ; Useful to disable compression under development

!include "${NSISDIR}\Include\MUI.nsh"
!include "${NSISDIR}\Include\LogicLib.nsh"

Function .onInit

    ; CompareVersion example
    ; (C++)CompareVersion("2.50.4403.9","2.50.4403.9") return 0 (a==b)
    ; (C++)CompareVersion("2.50.4403.9","2.71.9030.0") return 1 (b>a)
    ; (C++)CompareVersion("2.71.9030.0","2.50.4403.9") return -1 (a>b)
    
    StrCpy $2 "2.5"
    Push $2
    xtInfoPlugin::GetMDACVersion
    Pop $1
    Push $1
    xtInfoPlugin::CompareVersion
    Pop $0
    ${if} $0 >= 0
        MessageBox MB_OK "MDAC version is Newer or Equal to $2 (found: $1)"
    ${else}
        MessageBox MB_OK "MDAC version is OLDER than $2 (found: $1)"
    ${endif}

    ; ---------------------------------------------------------------------

    ; Say we wan't our application to only work with .NET Framework v1.1

    xtInfoPlugin::IsDotNetFrameworkInstalled
    Pop $0
    ${if} $0 == true
        xtInfoPlugin::GetDotNetFrameworkId
        ; GetDotNetFrameworkId (id methods) return x.x and not build info
        Pop $0
        ${if} $0 == "1.1"
            StrCpy $0 "Version 1.1 Installed"
        ${else}
            StrCpy $0 "Version 1.0 Installed"
        ${endif}
    ${else}
        StrCpy $0 "Not installed"
    ${endif}
    xtInfoPlugin::GetDotNetFrameworkVersion
    Pop $1
    MessageBox MB_OK ".NET Framework version check = $0 (found: $1)"

    Quit ; Quit before installer start

FunctionEnd

; Required by NSIS, we don't need it!
Section
SectionEnd
