# Function: CabView.
# Description: View the files store in the Cabinet without extraction.
# Syntax: CabDLL::CabView <path_of_cabinet>

SetCompressor lzma
XPStyle on

Name "CabDLL example #2"
OutFile "CabDLL_ex_2.exe"
InstallDir $EXEDIR
ShowInstDetails show

Var CAB

Function .onInit
InitPluginsDir
File /oname=$PLUGINSDIR\CabDLL.dll "${NSISDIR}\Plugins\CabDLL.dll"
#Here we set the global var that will handle the path of our cabinet:
StrCpy $CAB "$EXEDIR\sample_.cab"
FunctionEnd

Section -default
DetailPrint "CabDLL has started..."
#Let's be sure that the cabinet is in that folder:
IfFileExists $CAB green red

#Nop, try again!
red:
DetailPrint "Cabinet not found!!!"
Goto exit

#Yes, baby! Is in there:
green:
CabDLL::CabView $CAB
#CabInfo function returns in "$R0" 0 if is a good cab, otherwise error:
StrCmp $R0 "1" exit

exit:
DetailPrint "CabDLL has finished"
SectionEnd
