Name "nsMCI"
OutFile "nsMCI.exe"
AutoCloseWindow true

Function .onInit
# getting information from nsisext_mci
# get the first CD-ROM  drive
  nsMCI::GetFirstCDROMDrive
  Pop $R0
# get number of tracks on CD
  nsMCI::SendString "open $R0 type cdaudio alias nsis wait" "status nsis number of tracks wait"
  Pop $R1
  Pop $0 # error code not used
# MessageBox MB_OK "Number of tracks: $R1"
# get length of first track in milliseconds
  nsMCI::SendString "set nsis time format milliseconds wait" "status nsis length track 1 wait"
  Pop $R2
  Pop $0 #error code not used
# MessageBox MB_OK "Length of track 1: $R2 ms"
# close the device
  nsMCI::SendString "close nsis"

# check number of tracks
# 18 or what ever your track count is
  IntCmp $R1 18 lblTrackOK lblTrackBAD
  lblTrackBAD:
    MessageBox MB_OK "BAD CD!"
    Abort
  lblTrackOK:
    MessageBox MB_OK "GOOD CD!"

# check track length
# 321 or what ever your length of track 1 is (in seconds)
  IntOp $R2 $R2 / 1000
  IntCmp $R2 321 lblLengthOK lblLengthBAD
  lblLengthBAD:
    MessageBox MB_OK "BAD length!"
    Abort
  lblLengthOK:
    MessageBox MB_OK "GOOD length!"
FunctionEnd

Section
# Rest of the setup...
SectionEnd