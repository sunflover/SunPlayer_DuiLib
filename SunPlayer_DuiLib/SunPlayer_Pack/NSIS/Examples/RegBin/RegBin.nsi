Name RegBinExample
OutFile RegBinExample.exe

InstallDir "$TEMP"

Page instfiles

ShowInstDetails show

Section "" sec1
  StrCpy $R0 "FFFF0000"
  StrCpy $R0 "$R0$R0"
  ;Write the value in one step
  RegBin::writeRegBin "HKLM" "SOFTWARE\RegBinExampleKey" "RegBinExampleValue1" $R0
  pop $0
  DetailPrint "writeRegBin: $0"
  
  ;Write a large value in multiple steps
  ;Initialize the buffer
  RegBin::init /NOUNLOAD "HKLM" "SOFTWARE\RegBinExampleKey" "RegBinExampleValue2" $R0
  pop $0
  DetailPrint "init: $0"
  ;Append to the buffer
  RegBin::append /NOUNLOAD $R0
  pop $0
  DetailPrint "append: $0"
  ;Write the buffer
  RegBin::write $R0
  pop $0
  DetailPrint "write: $0"
SectionEnd

