; 安装程序初始定义常量
!define PRODUCT_NAME "文本操作处理插件"
!define PRODUCT_VERSION "by 简单工作室"
!define PRODUCT_PUBLISHER "My company, Inc."
!define PRODUCT_WEB_SITE "http://www.jjdd925.com"

SetCompressor /SOLID lzma
SetCompressorDictSize 32

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "文本操作处理插件.exe"
;InstallDir "$PROGRAMFILES\Hello Word"
Icon "Setup.ico"
SilentInstall silent
BrandingText " "
Section
  strcpy $R1 "$EXEDIR\hosts.txt"
  strcpy $R2 "1234567890"
  #### m=文本型 i=整数型  (m,m,i)参数类型 (R1,R2,1) 参数信息 ####  by 见与不见
  System::Call 'Stringplug::Text_ReplaceText_Ex(m,i,i,m,m)(R1,,,"CCTV","jjdd")m.R0 '  ## 文本_替换_Ex 命令
  MessageBox MB_ICONINFORMATION|MB_OK $R0
SectionEnd

Function .onInit
  InitPluginsDir
  File /oname=$PLUGINSDIR\StringPlug.dll "StringPlug.dll"
  #程序运行时自动将DLL加载到内存
  System::Call 'kernel32::LoadLibraryA(m "$PLUGINSDIR\StringPlug.dll")'
FunctionEnd

Function .onGUIEnd
  System::Free
FunctionEnd

