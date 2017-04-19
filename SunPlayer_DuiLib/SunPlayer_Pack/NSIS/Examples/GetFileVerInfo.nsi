!include "FileVerInfo.nsh"

Name "GetFileVerInfo"
Caption "$(^Name)"
OutFile "GetFileVerInfo.exe"
XPStyle on

Function .onGUIInit

  StrCpy $0 "文件 $WINDIR\notepad.exe 的版本信息：$\r$\n"

  ${GetProductName} "$WINDIR\notepad.exe" $R0
  StrCpy $0 "$0$\r$\n - 产品名称 (ProductName): $R0"

  ${GetComments} "$WINDIR\notepad.exe" $R0
  StrCpy $0 "$0$\r$\n - 备注 (Comments): $R0"

  ${GetCompanyName} "$WINDIR\notepad.exe" $R0
  StrCpy $0 "$0$\r$\n - 公司 (CompanyName): $R0"

  ${GetLegalCopyright} "$WINDIR\notepad.exe" $R0
  StrCpy $0 "$0$\r$\n - 版权 (LegalCopyright): $R0"

  ${GetFileDescription} "$WINDIR\notepad.exe" $R0
  StrCpy $0 "$0$\r$\n - 描述 (FileDescription): $R0"

  ${GetFileVersion} "$WINDIR\notepad.exe" $R0
  StrCpy $0 "$0$\r$\n - 文件版本 (FileVersion): $R0"

  ${GetProductVersion} "$WINDIR\notepad.exe" $R0
  StrCpy $0 "$0$\r$\n - 产品版本 (ProductVersion): $R0"

  ${GetInternalName} "$WINDIR\notepad.exe" $R0
  StrCpy $0 "$0$\r$\n - 内部名称 (InternalName): $R0"

  ${GetLegalTrademarks} "$WINDIR\notepad.exe" $R0
  StrCpy $0 "$0$\r$\n - 合法商标 (LegalTrademarks): $R0"

  ${GetOriginalFilename} "$WINDIR\notepad.exe" $R0
  StrCpy $0 "$0$\r$\n - 源文件名 (OriginalFilename): $R0"

  ${GetPrivateBuild} "$WINDIR\notepad.exe" $R0
  StrCpy $0 "$0$\r$\n - 个人用内部版本说明 (PrivateBuild): $R0"

  ${GetSpecialBuild} "$WINDIR\notepad.exe" $R0
  StrCpy $0 "$0$\r$\n - 特殊内部版本说明 (SpecialBuild): $R0"

  ${GetUserDefined} "ProductBuild" "$WINDIR\notepad.exe" $R0
  StrCpy $0 "$0$\r$\n - ProductBuild (自定义版本名): $R0"

  MessageBox MB_OK|MB_ICONINFORMATION $0

  Quit

FunctionEnd

Section -Main

SectionEnd