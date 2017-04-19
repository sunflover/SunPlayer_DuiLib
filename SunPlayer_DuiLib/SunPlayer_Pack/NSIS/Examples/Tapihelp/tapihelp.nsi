!addplugindir ./debug
!addplugindir ./release
Name	"tapihelp.dll test"
OutFile	"tapihelp.dll test.exe"
ShowInstDetails show
Function .onInit
	InitPluginsDir
	tapihelp::getmodemid
	Pop $0
	tapihelp::getmodemname
	Pop $1
FunctionEnd
Section
	DetailPrint "Modem ID: $0"
	DetailPrint "Modem Name: $1"
	DetailPrint ""
SectionEnd
