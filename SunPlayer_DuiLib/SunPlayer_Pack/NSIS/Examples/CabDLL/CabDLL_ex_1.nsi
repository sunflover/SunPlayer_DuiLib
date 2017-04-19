# Function: CabInfo.
# Description: Get general information about the Cabinet.
# Syntax: CabDLL::CabInfo <path_of_cabinet>

SetCompressor lzma
XPStyle on

Name "CabDLL example #1"
OutFile "CabDLL_ex_1.exe"
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

#Since is there, begin the procedure:
green:
CabDLL::CabInfo $CAB
#CabInfo function returns in "$R0" 0 if is a good cab, otherwise error:
StrCmp $R0 "0" continue stop
continue:
DetailPrint ""
DetailPrint "Total length of cabinet file: $0 bytes"
DetailPrint "Number of folders in cabinet: $1 folder(s)"
DetailPrint "Number of files in cabinet: $2 file(s)"
DetailPrint "Cabinet set ID: $3"
DetailPrint "Cabinet number in set: $4"
DetailPrint "RESERVE area in cabinet?: $5"
DetailPrint "Chained to prev cabinet?: $6"
DetailPrint "Chained to next cabinet?: $7"
DetailPrint ""
Goto exit

#Oops! Must be a foony cabinet:
stop:
DetailPrint "Cabinet procedure failed!"
Goto exit

#See, the Cabinet wasn't there:
red:
DetailPrint "Cabinet doesn't exists!"

exit:
DetailPrint "CabDLL has finished"
SectionEnd
