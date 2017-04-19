!AddPluginDir "..\..\Plugins"

Name "随机密码生成插件"

OutFile "pwgen-test.exe"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\SimpChinese.nlf"

Function .onInit
	pwgen::GeneratePassword 10
	Pop $0
	MessageBox MB_OK "随机密码 : $0"
FunctionEnd

Section
SectionEnd
