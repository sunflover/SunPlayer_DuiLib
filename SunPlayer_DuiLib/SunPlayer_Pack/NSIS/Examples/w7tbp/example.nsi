Outfile "$%temp%\Win7TaskbarProgress.exe"
Name "Win7TaskbarProgress Test"
Caption $(^Name)
RequestExecutionLevel user
ShowInstDetails show
!addplugindir ".\"

Function createInstFiles
w7tbp::Start
FunctionEnd


page components
page instfiles "" createInstFiles

Section dummy
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
SectionEnd