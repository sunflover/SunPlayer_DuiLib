;		Chngvrbl示例
;		Ansifa
;		2008-12-12
SetCompressor /SOLID lzma
SetCompress force
XPStyle on
SetFont /LANG=2052 "tahoma" 8
LoadLanguageFile "${NSISDIR}\Contrib\Language files\SimpChinese.nlf"
OutFile "Chngvrbl.EXE"
Name "Chngvrbl Test"
InstallDir "$TEMP"

Page components
Page directory
Page instfiles
Function .onInit

;	你可以用下面方法获取用户在命令行里面使用的临时文件夹值
;	即取消下面注释后,我们可以使用
;	"Chngvrbl.EXE /TEMP=C:\UserTemp"
;	命令行去指定此程序使用的临时文件夹

;Push "/TEMP="
;Call GetParam
;Pop $0

;下面这句指定此程序使用的临时文件夹,也可以去掉此句,此句$0值来自上面三句
StrCpy $0 "C:\UserTemp"

;如果没有自定义临时文件夹的话,使用默认的$PLUGINSDIR文件夹
StrCmp $0 "" nousertemp usertemp
usertemp:
	SetOutPath $0
	File /oname=$0\chngvrbl.dll "${NSISDIR}\Plugins\chngvrbl.dll"
	Push $0
	Push 25 ; $PLUGINSDIR
	CallInstDLL "$0\chngvrbl.dll" changeVariable
	Delete "$0\chngvrbl.dll"
;下面这个MessageBox只是提示作用
MessageBox MB_ICONINFORMATION|MB_OK '现在的临时文件夹是 $0 此程序的临时文件都在里面,打开看看?'
nousertemp:
	InitPluginsDir
FunctionEnd
Section "这是一个示例"
SectionEnd
