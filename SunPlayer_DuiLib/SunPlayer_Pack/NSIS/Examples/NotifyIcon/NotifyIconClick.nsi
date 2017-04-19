; By Afrow UK
; Catches click event of NotifyIcon

!include MUI.nsh
!include LogicLib.nsh

Name "NotifyIcon Click Example"
OutFile "notifyicon.exe"

!define MUI_COMPONENTSPAGE_NODESC
!define MUI_CUSTOMFUNCTION_GUIINIT MyGUIInit

!define MUI_PAGE_CUSTOMFUNCTION_LEAVE PageLeave
!insertmacro MUI_PAGE_WELCOME
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE PageLeave
!insertmacro MUI_PAGE_DIRECTORY
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE PageLeave
!insertmacro MUI_PAGE_COMPONENTS
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE PageLeave
!insertmacro MUI_PAGE_INSTFILES
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE PageLeave
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE English

Function MyGUIInit
 NotifyIcon::Icon /NOUNLOAD "iyc" 103
FunctionEnd

Function PageLeave
 NotifyIcon::Icon /NOUNLOAD "d" 103
 Pop $R0
 ${If} $R0 = 1
   MessageBox MB_OK|MB_ICONINFORMATION "Minimized!"
   Abort
 ${ElseIf} $R0 = 2
   MessageBox MB_OK|MB_ICONINFORMATION "Maximized!"
   Abort
 ${EndIf}
FunctionEnd

Function .onGUIEnd
 NotifyIcon::Icon "r"
FunctionEnd

Section "Dummy!"
SectionEnd