# Function: CabExtracAll.
# Description: View the files store in the Cabinet with extraction.
# Syntax: CabDLL::CabExtractAll <path_of_cabinet> <target_directory_for_extraction>

SetCompressor lzma
XPStyle on

Name "CabDLL example #3"
OutFile "CabDLL_ex_3.exe"
InstallDir $EXEDIR
ShowInstDetails show

Var CAB
Var DIR

Function .onInit
InitPluginsDir
File /oname=$PLUGINSDIR\CabDLL.dll "${NSISDIR}\Plugins\CabDLL.dll"
#Here we set the global var that will handle the path of our cabinet:
StrCpy $CAB "$EXEDIR\sample.cab"
#Here we set the global var that will handle the target directory of extraction:
StrCpy $DIR "$EXEDIR\output"
FunctionEnd

Section -default
DetailPrint "CabDLL has started..."
#Let's be sure that the cabinet is in that folder:
IfFileExists $CAB green red

#Sorry cowboy!
red:
DetailPrint "Cabinet not found!!!"
Goto exit

#Eureka!
green:
CreateDirectory $DIR
CabDLL::CabExtractAll $CAB $DIR
#CabInfo function returns in "$R0" 0 if is a good cab, otherwise error:
StrCmp $R0 "1" exit



exit:
DetailPrint "CabDLL has finished"
SectionEnd
