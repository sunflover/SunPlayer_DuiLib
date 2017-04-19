SetCompressor       /SOLID LZMA

Name                "Setup"
XPStyle             On
InstProgressFlags   Smooth
ShowInstDetails     Show
Caption             "Setup"

OutFile             _setup.exe

; Defines for common disk size elements.
!define             KILOBYTE    1024
!define /math       MEGABYTE    1024 * ${KILOBYTE}
!define /math       GIGABYTE    1024 * ${MEGABYTE}

; Dataset name for source Dataset.
!define DATASET_NAME        "DATASET"

; Report file name.
!define REPORT_FILE         "${DATASET_NAME}.RPT"

; Source directory for dataset files.
!define SOURCE_PATH         "D:\CAB\${DATASET_NAME}"

; Default directory to extract the dataset files to.
!define TARGET_PATH         "D:\CAB\TEST\${DATASET_NAME}"

; Source report file.
!define SOURCE_REPORT_FILE  "${SOURCE_PATH}\${REPORT_FILE}"

InstallDir          ${TARGET_PATH}

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
    File /oname=$PLUGINSDIR\SETUP.RPT ${SOURCE_REPORT_FILE}
    SetDetailsPrint Both
    CABSetup::Extract "/SOURCE=$SourcePathDATA1.CAB" "/TARGET=$INSTDIR" /ALL "/reportfile=$PLUGINSDIR\SETUP.RPT" "/showrate" "/resume" |
    Pop $R0

    ; Quit if the extraction completed without error.
    ${IfThen} $R0 = 0 ${|} Goto Done ${|}

    ; Handle case where extraction was cancelled.
    ${If} $R0 = 995
        DetailPrint "Extract process was cancelled"
        SetDetailsPrint None
        Goto Done
    ${EndIf}

    DetailPrint "Extract failed with error code $R0"
    Done:
SectionEnd

; BaseFiles section must preceed the .onInit function so that we can change it's size at runtime.
;
Function .onInit
    InitPluginsDir
    File /oname=$PLUGINSDIR\SETUP.RPT ${SOURCE_REPORT_FILE}

    CABSetup::DataSetSize "/reportfile=$PLUGINSDIR\SETUP.RPT" |
    Pop $R1
    ${If} $R1 = 0
        Pop $R1
    ${Else}
        MessageBox MB_OK "Get DataSetSize failed with code $R1"
     ${EndIf}
    
    ; Convert the dataset size into KB.
    ; We need to use the System plug-in because NSIS operators use signed 
    ; quantities and therefore cannot handle dataset sizes greater than 2GB.
    System::Int64Op $R1 / 1024
    Pop $R1
    
    ; Using 32 bit arithmetic means that dataset cannot be bigger than 4TB.
    ; I think this is OK for now...
    SectionGetSize ${BaseFiles} $R0
    IntOp $R0 $R0 + $R1
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