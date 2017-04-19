!include "WordFunc.nsh"
#!include "nsWindows.nsh"
!include "MUI.nsh"
!include 'StdUtils.nsh'

SetCompressor /SOLID lzma


!define FILE_VERSION  "1.0.0.1"
!define PRODUCT_VERSION  "1.0.0.1"
!define PRODUCT_NAME  "SunPlayer"
!define DESKTOP_ICON  "SunPlayer"        ; 桌面快捷方式名字
!define INTERNAL_NAME "${PRODUCT_NAME}.exe"
!define FOLDERNAME "${PRODUCT_NAME}"	; 文件夹名称
!define MainExe "${PRODUCT_NAME}.exe"     ; 主程序名字
!define Company_Name "xxoo.com"


OutFile "${PRODUCT_NAME}Setup.exe"     ;生成的安装包名称


!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${FOLDERNAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

!define MUI_ICON "logo.ico"		;安装包的图标ico文件
!define MUI_UNICON "logo.ico"		;卸载程序的图标ico文件

; 安装卸载过程页面
!insertmacro MUI_UNPAGE_INSTFILES
; 安装界面包含的语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"
; 安装预释放文件
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS


VIProductVersion ${PRODUCT_VERSION}
VIAddVersionKey /LANG=${LANG_SimpChinese} "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=${LANG_SimpChinese} "LegalCopyright" "Copyright (C) 2015-2017 ${Company_Name}"
VIAddVersionKey /LANG=${LANG_SimpChinese} "FileDescription" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=${LANG_SimpChinese} "FileVersion" ${FILE_VERSION}
VIAddVersionKey /LANG=${LANG_SimpChinese} "ProductVersion" ${PRODUCT_VERSION}
VIAddVersionKey /LANG=${LANG_SimpChinese} "OriginalFilename" ${INTERNAL_NAME}
VIAddVersionKey /LANG=${LANG_SimpChinese} "InternalName" ${INTERNAL_NAME}
VIAddVersionKey /LANG=${LANG_SimpChinese} "CompanyName" "${Company_Name}"

RequestExecutionLevel admin

Function AddIcon
      ;写桌面快捷方式
      CreateShortCut "$DESKTOP\${DESKTOP_ICON}.lnk" "$INSTDIR\${MainExe}" "$INSTDIR\${MainExe}"
      ;写开始菜单快捷方式
      CreateDirectory "$SMPROGRAMS\${FOLDERNAME}"
      CreateShortCut "$SMPROGRAMS\${FOLDERNAME}\卸载${DESKTOP_ICON}.lnk" "$INSTDIR\Uninstall.exe"
      CreateShortCut "$SMPROGRAMS\${FOLDERNAME}\${DESKTOP_ICON}.lnk" "$INSTDIR\${MainExe}" "$INSTDIR\${MainExe}"
       ;任务栏锁定
      ${StdUtils.InvokeShellVerb} $0 "$INSTDIR" "${DESKTOP_ICON}.lnk" ${StdUtils.Const.ShellVerb.PinToTaskbar}
      ;开始菜单锁定
      ${StdUtils.InvokeShellVerb} $0 "$INSTDIR" "${DESKTOP_ICON}.lnk" ${StdUtils.Const.ShellVerb.PinToStart}
FunctionEnd

;添加控制面板卸载
Function AddControlPannel
      WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${FOLDERNAME}" "DisplayName" ${PRODUCT_NAME}
      WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${FOLDERNAME}" "DisplayVersion" ${PRODUCT_VERSION}
      WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${FOLDERNAME}" "Publisher" ${PRODUCT_NAME}
      WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${FOLDERNAME}" "DisplayIcon" "$INSTDIR\${MainExe}"
      WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${FOLDERNAME}" "UninstallString" "$INSTDIR\Uninstall.exe"
FunctionEnd


Function .onInit
      SetSilent silent

      StrCpy $INSTDIR "$PROGRAMFILES\${FOLDERNAME}" ;设置安装目录
      SetOutPath "$INSTDIR"

      SetOverwrite try
      File /r "BIN\*.*"   ;BIN 文件输入目录

      Call AddControlPannel         ;写注册表卸载项
      WriteUninstaller "$INSTDIR\Uninstall.exe" ;生成卸载exe
      Call AddIcon                  ;写快捷方式

      Exec '"$INSTDIR\${MainExe}"'

      Quit
FunctionEnd

Section Main
SectionEnd



#以下是安装程序的卸载部分
Section Uninstall

  ;任务栏解锁
  ${StdUtils.InvokeShellVerb} $0 "$INSTDIR" "${DESKTOP_ICON}.lnk" ${StdUtils.Const.ShellVerb.UnpinFromTaskbar}
  ;开始菜单解锁
  ${StdUtils.InvokeShellVerb} $0 "$INSTDIR" "${DESKTOP_ICON}.lnk" ${StdUtils.Const.ShellVerb.UnpinFromStart}
  Delete "$INSTDIR\${DESKTOP_ICON}.lnk"
  Delete "$DESKTOP\${DESKTOP_ICON}.lnk"
  RMDir /r "$SMPROGRAMS\${FOLDERNAME}"


  Delete "$INSTDIR\*.*"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKCU "Software\BestDRM"

  SetAutoClose true
SectionEnd


#-- 根据 NSIS 脚本编辑规则，所有 Function 区段必须放置在 Section 区段之后编写，以避免安装程序出现未可预知的问题。--#
Function un.onInit
      SetSilent silent

  FindProcDLL::FindProc ${MainExe}
    IntCmp $R0 1 0 norun
    MessageBox MB_ICONSTOP "${PRODUCT_NAME}正在运行,请先关闭程序再进行卸载！"
    Quit
  norun:
        MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确定要完全卸载${PRODUCT_NAME}吗？" IDYES +2
        Abort
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "${PRODUCT_NAME}已经卸载完成！"
FunctionEnd


