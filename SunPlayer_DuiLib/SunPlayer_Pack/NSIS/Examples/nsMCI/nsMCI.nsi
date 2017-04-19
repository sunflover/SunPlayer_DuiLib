Name "nsMCI"
OutFile "nsMCI.exe"
AutoCloseWindow true

Function .onInit
  #Get the first CD Drive
  nsMCI::GetFirstCDROMDrive
  Pop $0

  #Copy it to "$0" to show in a MessageBox later
  StrCpy $2 $0
  
  #Try to show number of tracks of a media CD in that drive
  nsMCI::SendString "open $0 type cdaudio alias nsis wait" "status nsis number of tracks wait"
  Pop $1
  Pop $2

  StrCmp $2 0 0 Error
    MessageBox MB_OK "Number of audio tracks on disk($0) $1"
    Goto End

  Error:
    #Show the error number and the error description.
    nsMCI::GetErrorString $2
    Pop $1
    
    MessageBox MB_OK "Error $2: $1"
  End:
FunctionEnd

Section
SectionEnd