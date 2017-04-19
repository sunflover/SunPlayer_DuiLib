
Name "NewAdvSplash.dll StopFade test"
OutFile "stopfade.exe"

!define IMG_NAME2 aist.gif

!include WinMessages.nsh


; MUI requires custom function definition
Function .onGUIInit

    InitPluginsDir
    SetOutPath "$PLUGINSDIR"


;  Modeless banner with variable initialization time - up to 10 sec
;  uses 'soft' stop()  with fade out

    File ${IMG_NAME2}
    newadvsplash::show /NOUNLOAD 10000 1000 500 -2 /BANNER "$PLUGINSDIR\${IMG_NAME2}"
    Sleep 2000 ; add here your initialization code (up to 11 sec) instead of sleep
    newadvsplash::stop /fadeout
#    newadvsplash::stop /wait
#    newadvsplash::stop
    Delete "$PLUGINSDIR\${IMG_NAME2}"
    SetOutPath "$EXEDIR"

FunctionEnd



Section
SectionEnd