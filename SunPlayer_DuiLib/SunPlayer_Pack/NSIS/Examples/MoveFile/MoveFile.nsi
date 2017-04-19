;Unicode与Ansi版本通用移动复制文件(夹)dll by 见与不见
;示例脚本 by 少轻狂

;注:文件夹路径请不要以\结尾
;0=复制文件/文件夹 
;1=移动文件/文件夹 
;? u=调用完成后立即卸载dll，多次调用可在最后一次时加

!define PRODUCT_NAME "移动复制文件(夹)"

SetCompressor lzma

Name "${PRODUCT_NAME}"
OutFile "${PRODUCT_NAME}.exe"
SilentInstall silent
Section
    Strcpy $R1 "$EXEDIR\abc"
    Strcpy $R2 "$EXEDIR\123"
	  StrCmp $R1 $R2 +6 +1   ;如果目录相同则不转移
    System::Call 'MoveFile::MoveFile_Ex(i1,mR1,mR2)m.R0 ? u'
    StrCmp $R0 "error" +2 +1
    StrCmp $R0 "假" +1 +2
		MessageBox MB_ICONINFORMATION|MB_OK "失败！"
		MessageBox MB_ICONINFORMATION|MB_OK "成功！"
SectionEnd

Function .onInit
 	InitPluginsDir
	File /oname=$PLUGINSDIR\MoveFile.dll "${NSISDIR}\Plugins\MoveFile.dll"
  System::Call 'kernel32::LoadLibraryA(m "$PLUGINSDIR\MoveFile.dll")'  ;把DLL加载到内存
FunctionEnd
