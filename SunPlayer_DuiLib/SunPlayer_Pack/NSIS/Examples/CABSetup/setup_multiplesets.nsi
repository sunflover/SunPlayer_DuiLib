SetCompressor       /SOLID LZMA

Name                "Setup"
XPStyle             On
InstProgressFlags   Smooth
ShowInstDetails     Show
Caption             "Setup"

OutFile             _setup.exe
;InstallDir          "$PROGRAMFILES"
InstallDir          "D:\CAB\TEST"

; Source directory for dataset files.
!define SOURCEPATH  "D:\CAB\"

!include            "mui.nsh"
!include            "LogicLib.nsh"
!insertmacro        MUI_PAGE_DIRECTORY
!insertmacro        MUI_PAGE_INSTFILES
!insertmacro        MUI_LANGUAGE "English"

; Holds the path to the parent executable, which should be the source path for
; the cabinet files.
Var SourcePath

Section "BaseFiles" BaseFiles
    Call GetParentPath
    Pop $SourcePath

    InitPluginsDir
    SetDetailsPrint None
    File /oname=$PLUGINSDIR\SET1.RPT ${SOURCEPATH}SET1\SET1.RPT
    File /oname=$PLUGINSDIR\SET2.RPT ${SOURCEPATH}SET2\SET2.RPT
    SetDetailsPrint Both
    CABSetup::Extract "/SOURCE=$SourcePathDATA1_1.CAB" "/TARGET=$INSTDIR" /ALL "/reportfile=$PLUGINSDIR\SET1.RPT" |
    Pop $R0
    CABSetup::Extract "/SOURCE=$SourcePathDATA2_1.CAB" "/TARGET=$INSTDIR" /ALL "/reportfile=$PLUGINSDIR\SET2.RPT" |
    Pop $R0

    StrCmp $R0 0 Done 0
    DetailPrint "Extract failed with error code $R0"
    Done:
SectionEnd

;
; BaseFiles section must preceed the .onInit function so that we can change it's size at runtime.
;
Function .onInit
    InitPluginsDir
    ; Extract the report files for each dataset for DataSetSize to use.
    File /oname=$PLUGINSDIR\SET1.RPT ${SOURCEPATH}SET1\SET1.RPT
    File /oname=$PLUGINSDIR\SET2.RPT ${SOURCEPATH}SET2\SET2.RPT

    CABSetup::DataSetSize "/reportfile=$PLUGINSDIR\SET1.RPT" |
    Pop $R1
    ${If} $R1 = 0
        Pop $R1
    ${Else}
        MessageBox MB_OK "Get DataSetSize for SET1 failed with code $R1"
        StrCpy $R1 "0"
    ${EndIf}
    
    CABSetup::DataSetSize "/reportfile=$PLUGINSDIR\SET2.RPT" |
    Pop $R2
    ${If} $R2 = 0
        Pop $R2
    ${Else}
        MessageBox MB_OK "Get DataSetSize for SET2 failed with code $R2"
        StrCpy $R2 "0"
    ${EndIf}

    ; Convert the dataset sizes into KB.
    ; We need to use the System plug-in because NSIS operators use signed 
    ; quantities and therefore cannot handle dataset sizes greater than 2GB.
    System::Int64Op $R1 / 1024
    Pop $R1
    System::Int64Op $R2 / 1024
    Pop $R2
    
    SectionGetSize ${BaseFiles} $R0
    ; Using 32 bit arithmetic means that dataset cannot be bigger than 4TB.
    ; I think this is OK for now...
    IntOp $R0 $R0 + $R1
    IntOp $R0 $R0 + $R2
    SectionSetSize ${BaseFiles} $R0

FunctionEnd

;
; Basic function to parse the parent executables path from the command line
; Currently assumes that no other parameters are specified (other than
; those that are parsed by NSIS before being passed to us.)
;
Function GetParentPath
    Push $R0
    Push $R1
    Push $R2
    Push $R3
    Push $R4

    ; Initialize the pointer variable
    StrCpy $R1 0
    StrLen $R2 $CMDLINE
    ; Determine the termination character.
    ; If the command line starts with a quote, search for the ending quote.
    ; If the command line does not start with a quote, a space will separate
    ; the executable name from the parameters.
    StrCpy $R0 $CMDLINE 1 0
    StrCmp $R0 '"' +2 0
    StrCpy $R0 " "
    ; Start loop to find the parameter portion of the $CMDLINE
    FindParam:
        IntOp $R1 $R1 + 1
        StrCpy $R3 $CMDLINE 1 $R1
        ; Exit if we reach the end of the command line without finding either
        ; a space or a double quote. This will happen if no parameters are
        ; specified.
        StrCmp $R1 $R2 ExitFindParam
        ; Exit the loop if we find a double quote or a space.
        ; Either signifies the end of the executable name and the start of the
        ; parameters.
        StrCmp $R3 $R0 ExitFindParam ; Found terminating quote
        Goto FindParam
    ExitFindParam:

    ; If the search terminated on a double quote, skip it.
    StrCmp $R3 '"' 0 SkipSpace
    IntOp $R1 $R1 + 1
    SkipSpace:
    ; Skip the space between the executable and the parameters (if it present)

    StrCmp $R3 ' ' 0 TerminatePath
    IntOp $R1 $R1 + 1
    StrCpy $R3 $CMDLINE 1 $R1
    Goto SkipSpace

    TerminatePath:
    IntOp $R3 $R2 - $R1	; Difference between total string length and the length
                        ; of the parameter portion
                        ; If this value is zero, then no parameters have been
                        ; defined (exit)
    IntCmp $R3 0 PathDone PathDone 0
    StrCpy $R0 $CMDLINE $R3 $R1

    ; Ensure that the path is terminated with a trailing backslash.
    StrLen $R3 $R0
    StrCmp $R3 "0" PathDone
    StrCpy $R1 $R0 1 $R3
    StrCmp $R1 "\" PathDone
    StrCpy $R0 "$R0\"

PathDone:
    Pop $R4
    Pop $R3
    Pop $R2
    Pop $R1
    Exch $R0
FunctionEnd