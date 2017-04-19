SetCompressor lzma

!ifdef NSIS_UNICODE
!define SKINBTNDIR "..\Plugins\Unicode"
!else
!define SKINBTNDIR "..\Plugins"
!endif
!addplugindir "${SKINBTNDIR}"

!Include "MUI.nsh"

!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit
;!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "${__FILE__}"
!define MUI_PAGE_CUSTOMFUNCTION_SHOW DirPageShow
!insertmacro MUI_PAGE_DIRECTORY
!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstPageShow
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "SimpChinese"

Name "SkinBtn"
OutFile "SkinBtn.exe"
Caption "NSIS按钮皮肤插件"
InstallDir "$PROGRAMFILES\NSIS"
LicenseForceSelection checkbox

Section
SectionEnd

Function .onInit
  InitPluginsDir
  File /oname=$PLUGINSDIR\button1.bmp button1.bmp
  File /oname=$PLUGINSDIR\button2.bmp button2.bmp
  SkinBtn::Init "$PLUGINSDIR\button1.bmp"
FunctionEnd

Function onGUIInit
  ${For} $1 1 3
    GetDlgItem $0 $HWNDPARENT $1
    SetCtlColors $0 0x0C4E7C transparent
    SkinBtn::Set $0
  ${Next}
FunctionEnd

Function onBack
  MessageBox MB_ICONINFORMATION|MB_YESNO "你确实要返回前一个页面吗？" IDYES +2
  Abort
  SkinBtn::onClick $R0 0 ;取消对上一步按钮点击事件的处理
FunctionEnd

Function SkinBtn
  FindWindow $0 "#32770" "" $HWNDPARENT
  GetDlgItem $0 $0 $1
  SkinBtn::Set /IMGID=$PLUGINSDIR\button2.bmp $0
FunctionEnd

Function DirPageShow
  StrCpy $1 1001
  Call SkinBtn
  GetDlgItem $R0 $HWNDPARENT 3
  GetFunctionAddress $0 onBack
  SkinBtn::onClick $R0 $0
FunctionEnd

Function InstPageShow
  StrCpy $1 1027
  Call SkinBtn
FunctionEnd
