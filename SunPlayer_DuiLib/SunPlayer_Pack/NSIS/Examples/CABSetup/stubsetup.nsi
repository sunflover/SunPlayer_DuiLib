;
; Stub Setup launcher for installs that remove the installer completely.
;
; This is most useful for the multi-volume installer where the original
; setup.exe may not be available during volume changes and is therefore copied
; to the temporary directory. This program allows the media the original
; installer was launched from to be 'released' and 'InstStub.exe' removes both
; the program it launches and itself when the program is complete.
;
; Uses the silent install option to ensure that there is no user interface
; displayed by NSIS while we launch the real installer.

;
; Duncan McKellar, February 2006
;
Name            "SetupStub"
OutFile         "Setup.exe"
SilentInstall    silent

; Name of the real executable to launch.
!define         INSTALLER_EXE   "_setup.exe"

; We need at least one section otherwise the script won't compile.
Section "Stub"
    ; Drop the stub files into the temporary directory.
    SetOutPath $TEMP
    File "Inststub.exe"
    File ${INSTALLER_EXE}

    ; Run the 'real' installer from the temporary directory passing our path
    ; to it to locate the source cabinets.
    Exec "$TEMP\Inststub.exe $TEMP\_setup.exe $EXEDIR"
SectionEnd
