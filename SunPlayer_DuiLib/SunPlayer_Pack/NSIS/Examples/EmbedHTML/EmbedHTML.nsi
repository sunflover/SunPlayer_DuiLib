!include MUI2.nsh

Name EmbedHTML
OutFile EmbedHTML.exe
RequestExecutionLevel user
BrandingText `Nullsoft Install System`

!insertmacro MUI_PAGE_WELCOME
!define MUI_PAGE_CUSTOMFUNCTION_SHOW LicenceShow
!insertmacro MUI_PAGE_LICENSE Empty.txt
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE English

Function LicenceShow

	FindWindow $R0 `#32770` `` $HWNDPARENT
	GetDlgItem $R0 $R0 1000
	EmbedHTML::Load /replace $R0 `http://blog.csdn.net/shuijing_0`

FunctionEnd

Section

SectionEnd
