Name                "MakeSetup"
XPStyle             On
InstProgressFlags   Smooth
ShowInstDetails     Show
Caption             "MakeSetup"

OutFile             makesetup.exe

; Defines for common disk size elements.
!define             KILOBYTE    1024
!define /math       MEGABYTE    1024 * ${KILOBYTE}
!define /math       GIGABYTE    1024 * ${MEGABYTE}

; Dataset name for source Dataset.
!define DATASET_NAME        "DATASET"

; Report file name.
!define REPORT_FILE         "${DATASET_NAME}.RPT"

; Source directory for dataset files.
!define SOURCE_FILES        "$PROGRAMFILES\NSIS\*.*"

; Directory to place dataset cabinets in.
!define TARGET_PATH         "D:\CAB\${DATASET_NAME}"

; Target report file.
!define TARGET_REPORT_FILE  "${TARGET_PATH}\${REPORT_FILE}"

InstallDir          ${TARGET_PATH}

!include            "mui.nsh"
!insertmacro        MUI_PAGE_DIRECTORY
!insertmacro        MUI_PAGE_INSTFILES

!insertmacro        MUI_LANGUAGE "English"

!include            "FileFunc.nsh"
!insertmacro        GetSize

Section	"BaseFiles"

    SetDetailsPrint both

; UNLOAD is allowed here since all options are specified within one call to
; the CABSetup plugin.
;
;    CABSetup::BuildSetupFiles /create "/diskname=$R1" \
;                              "/cabname=DATA*.CAB" "/disksize=1.44M" \
;                              "/disk1size=1.2M"    "/diskdir=Disk*" \
;                              "/compress=LZX" \
;                              "/dataset=SETUP" \
;                              "/datasetpath=$INSTDIR" \ 
;                              "/add=$PROGRAMFILES\NSIS\*.*" /s \
;                              /close \
;                              /makefiles "/target=$INSTDIR" \
;                              /destroy |
;    Pop $R0
;
; These are examples of creating multiple datasets within the one setup script.
;
;    CABSetup::BuildSetupFiles /create "/diskname=SETUP#*" \
;                              "/cabname=DATA1_*.CAB" "/disksize=${GIGABYTE}" \
;                              "/disk1size=1073541632" "/diskdir=Disk*" \
;                              "/datasetpath=D:\CAB\SET1" \
;                              "/dataset=SET1" \
;                              "/compress=LZX" \
;                              "/add=D:\PROJECT\*.DAT" /s \
;                              /close \
;                              /makefiles "/target=D:\CAB\SET1" \
;                              /destroy |
;    Pop $R0
    
;    CABSetup::BuildSetupFiles /create "/diskname=SETUP#*" \
;                              "/cabname=DATA2_*.CAB" "/disksize=${GIGABYTE}" \
;                              "/disk1size=1073541632"   "/diskdir=Disk*" \
;                              "/datasetpath=D:\CAB\SET2" \
;                              "/dataset=SET2" \
;                              "/compress=none" \
;                              "/add=D:\PROJECT\*.7Z" /s \
;                              /close \
;                              /makefiles \
;                              /destroy |
;    Pop $R0

; This is a technique for allowing space on the first disk for setup.exe.
;
; This assumes that the setup.exe file is in the current directory i.e. the
; same directory as this script.
;

    ; $R0 holds the disk size for the dataset.
    StrCpy $R0 ${MEGABYTE}

    ; Get the size of setup.exe in bytes.
    ${GetSize} ".\" "/M=setup.exe /S=0B /G=0" $R1 $R2 $R2

    ;
    ; Round the new disk size to a multiple of 512 bytes (for MAKECAB) and
    ; 2KB (allocation units for optical media).
    ;
    System::Int64Op $R1 + 2047
    Pop $R1
    System::Int64Op $R1 / 2048
    Pop $R1
    System::Int64Op $R1 * 2048
    Pop $R1
    ; Calculate the new disk size for disk1 in $R2.
    System::Int64Op $R0 - $R1
    Pop $R2

    DetailPrint "Disk1Size set to $R2 bytes to allow for setup.exe ($R1 bytes)."

    CABSetup::BuildSetupFiles /NOUNLOAD /create "/diskname=SETUP#*" \
                              "/cabname=DATA*.CAB" "/disksize=$R0" \
                              "/disk1size=$R2" "/diskdir=Disk*" \
                              "/dataset=${DATASET_NAME}" \
                              "/datasetpath=$INSTDIR" \
                              "/compress=LZX" |
    Pop $R0
    StrCmp $R0 "0" CreateOK 0
    DetailPrint "Create failed with code $R0"
    Goto Exit

CreateOK:
    CABSetup::BuildSetupFiles /NOUNLOAD "/add=${SOURCE_FILES}" /s |
    StrCmp $R0 "0" AddOK 0
    DetailPrint "Add failed with code $R0"
    Goto Exit

AddOK:
    CABSetup::BuildSetupFiles /NOUNLOAD /close |
    Pop $R0
    StrCmp $R0 "0" CloseOK 0
    DetailPrint "Close failed with code $R0"
    Goto Exit

CloseOK:
    CABSetup::BuildSetupFiles /NOUNLOAD /makefiles "/target=${TARGET_PATH}" |
    Pop $R0
    StrCmp $R0 "0" MakeOK 0
    DetailPrint "MakeFiles failed with code $R0"
    Goto Exit

MakeOK:
    ; Important: The last call to CABSetup must not include the UNLOAD switch
    ; otherwise CABSetup.dll is not deleted from the $PLUGINSDIR
    CABSetup::BuildSetupFiles /destroy |
    Pop $R0
    StrCmp $R0 "0" DestroyOK 0
    DetailPrint "Destroy failed with code $R0"
    Goto Exit

DestroyOK:

Exit:
    SetDetailsPrint None

SectionEnd
