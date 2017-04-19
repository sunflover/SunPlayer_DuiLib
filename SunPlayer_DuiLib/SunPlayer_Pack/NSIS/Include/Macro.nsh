/*
NSIS 资源合集
By:Ansifa
*/

#宏头文件
#$INSTDIR	NSIS目录
#$S_DOC     程序菜单帮助目录
Var S_DOC
Var S_ExExamples
############################################
#安装插件宏
#用法：!insertmacro Plugins "AnimGif" "在程序中添加 GIF 动画" "AnimGif.dll"
############################################
!macro Plugins Name Comment DLLName
Section "${Name} (${Comment})"
SectionIn 1 2
SetOutPath "$INSTDIR"
File /r "Plugins\${Name}\*"
IfFileExists "$INSTDIR\Docs\${Name}\${Name}.txt" +1 +2
CreateShortCut "$S_DOC\${Name} (${Comment}).lnk" "$INSTDIR\Docs\${Name}\${Name}.txt"
IfFileExists "$INSTDIR\Docs\${Name}\Readme.txt" +1 +2
CreateShortCut "$S_DOC\${Name} (${Comment}).lnk" "$INSTDIR\Docs\${Name}\Readme.txt"
;WriteINIStr "$INSTDIR\ExtRes.ini" Plugins "${Name}" 1
SectionEnd
!macroend

############################################
#安装代码示例
#用法：!insertmacro Examples "NSIS 获取最大容量盘符" "NSIS 获取最大容量盘符.nsi"
############################################
!macro Examples Name File
Section "${Name}"
SectionIn 1 3
SetOutPath "$INSTDIR\ExExamples"
File /r "..\..\trunk\代码\${File}"
IfFileExists "$INSTDIR\ExExamples\${File}" +1 +2
CreateShortCut "$S_ExExamples\${Name}.lnk" "$INSTDIR\ExExamples\${File}"
;WriteINIStr "$INSTDIR\ExtRes.ini" Examples "${Name}" 1
SectionEnd
!macroend

############################################
#卸载插件宏
#用法：!insertmacro Plugins "AnimGif" "在程序中添加 GIF 动画" "AnimGif.dll"
############################################
!macro UnPlugins Name Comment DLLName
Section "Un.${Name} (${Comment})"
SectionIn RO
RMDir /r "$INSTDIR\Docs\${Name}"
RMDir /r "$INSTDIR\Examples\${Name}"
Delete "$INSTDIR\Examples\${Name}.nsi"
Delete "$INSTDIR\Plugins\${DLLName}"
Delete "$S_DOC\${Name} (${Comment}).lnk"
;DeleteINIStr "$INSTDIR\ExtRes.ini" Plugins "${Name}"
SectionEnd
!macroend

############################################
#卸载代码示例
#用法：!insertmacro Examples "NSIS 获取最大容量盘符" "NSIS 获取最大容量盘符.nsi"
############################################
!macro UnExamples Name File
Section "Un.${Name}"
SectionIn RO
Delete  "$INSTDIR\ExExamples\${File}"
Delete "$S_ExExamples\${Name}.lnk"
;DeleteINIStr "$INSTDIR\ExtRes.ini" Examples "${Name}"
SectionEnd
!macroend
