Name "nsRestartExplorer"
OutFile "nsRestartExplorer.exe"
ShowInstDetails show

Section "Restart"
;    nsRestartExplorer::nsRestartExplorer restart infinite
;    nsRestartExplorer::nsRestartExplorer restart ignore
    nsRestartExplorer::nsRestartExplorer quit 1000
    Pop $1
    DetailPrint $1
SectionEnd
