/*

---------------------------------------------
        FileVersionInfo Header v1.2.2

          All Functions comes from:
      http://nsis.pastebin.com/f5e461c4d
              Written by Anders
       Collected and modified by JiaKe
---------------------------------------------

Copyright 2011 Nullsoft Install System

Usage in script:

!include "FileVerInfo.nsh"

[Section|Function]

 ${FileVerInfoFunc} FILEPATH $var

# $var=["error"|""|Result]
# "error": This version info doesn't exist
# "": This version info exsits but is blank
# Result: The value of this version info

[SectionEnd|FunctionEnd]

FileVerInfoFunc can be:
  [un.]GetFileVersion
  [un.]GetProductVersion
  [un.]GetProductName
  [un.]GetCompanyName
  [un.]GetFileDescription
  [un.]GetComments
  [un.]GetLegalCopyright
  [un.]GetLegalTrademarks
  [un.]GetInternalName
  [un.]GetOriginalFilename
  [un.]GetSpecialBuild
  [un.]GetPrivateBuild
  [un.]GetUserDefined <Userdefined Name>

---------------------------------------------

 Examples:
  ${GetCompanyName} $WINDIR\Notepad.exe $R0
  ${un.GetComments} $SYSDIR\registry.exe $R0

---------------------------------------------

*/

!ifndef FILEVERINFO_INCLUDED
!define FILEVERINFO_INCLUDED

!include Util.nsh
!include LogicLib.nsh

!verbose push
!verbose 3
!ifndef _FILEVERINFO_VERBOSE
  !define _FILEVERINFO_VERBOSE 3
!endif
!verbose ${_FILEVERINFO_VERBOSE}
!define FILEVERINFO_VERBOSE `!insertmacro FILEVERINFO_VERBOSE`
!verbose pop

!macro FILEVERINFO_VERBOSE _VERBOSE
  !verbose push
  !verbose 3
  !undef _FILEVERINFO_VERBOSE
  !define _FILEVERINFO_VERBOSE ${_VERBOSE}
  !verbose pop
!macroend

!macro GetFileVerInfoCall _VERINFO_STR_NAME _FILENAME_INPUT _VERINFO_OUTPUT
  !verbose push
  !verbose ${_FILEVERINFO_VERBOSE}
  Push `${_FILENAME_INPUT}`
  Push `${_VERINFO_STR_NAME}`
  ${CallArtificialFunction} GetFileVerInfo_
  Pop `${_VERINFO_OUTPUT}`
  !verbose pop
!macroend

!macro __DefineVersionInfoName _VERINFO_STR_NAME
  !define Get${_VERINFO_STR_NAME}    `!insertmacro GetFileVerInfoCall ${_VERINFO_STR_NAME}`
  !define un.Get${_VERINFO_STR_NAME} `!insertmacro GetFileVerInfoCall ${_VERINFO_STR_NAME}`
!macroend

!insertmacro __DefineVersionInfoName ProductName
!insertmacro __DefineVersionInfoName Comments
!insertmacro __DefineVersionInfoName CompanyName
!insertmacro __DefineVersionInfoName LegalCopyright
!insertmacro __DefineVersionInfoName FileDescription
!insertmacro __DefineVersionInfoName FileVersion
!insertmacro __DefineVersionInfoName ProductVersion
!insertmacro __DefineVersionInfoName InternalName
!insertmacro __DefineVersionInfoName LegalTrademarks
!insertmacro __DefineVersionInfoName OriginalFilename
!insertmacro __DefineVersionInfoName PrivateBuild
!insertmacro __DefineVersionInfoName SpecialBuild

!define GetUserDefined    `!insertmacro GetFileVerInfoCall`
!define un.GetUserDefined `!insertmacro GetFileVerInfoCall`

!macro GetFileVerInfo_

  !verbose push
  !verbose ${_FILEVERINFO_VERBOSE}

  Exch $R0
  Exch
  Exch $R1
  System::Store S
  System::Call `version::GetFileVersionInfoSize(tR1,*i)i.R2`
  IntCmpU $R2 0 +15
    System::Alloc $R2
    System::Call `version::GetFileVersionInfo(tR1,in,iR2,isR3)i.R4?e`
    Pop $R2
    IntCmpU $R2 0 0 +11 +11
    IntCmpU $R4 0 +10
      System::Call `version::VerQueryValue(iR3,t"\VarFileInfo\Translation",*i.R4,*i)i.R5`
      IntCmpU $R5 0 +8
        System::Call `*$R4(&i2.R6,&i2.R7)`
        IntFmt $R6 "%04x" $R6
        IntFmt $R7 "%04x" $R7
        System::Call `version::VerQueryValue(iR3,t"\StringFileInfo\$R6$R7\$R0",*i.R6,*i.R7)i.R8`
        IntCmpU $R8 0 +3
          System::Call `*$R6(&t$R7.s)`
        Goto +2
          Push `error`
    IntCmpU $R3 0 +2
    System::Free $R3
  System::Store L
  Exch 2
  Exch
  Pop $R1
  Pop $R0

  !verbose pop

!macroend

!endif