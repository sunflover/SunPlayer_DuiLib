;InstallOptionsEx Test Script
;Original Version Written by Joost Verburg
;-----------------------------------------

!define TEXT_COLOR FFFFFF
!define BGCOLOR 3d66ab
!define TEMP1 $R0 ;Temp variable

;The name of the installer
Name "InstallOptionsEx Test"

;The file to write
OutFile "Test2.exe"

; Show install details
ShowInstDetails show

ReserveFile "${NSISDIR}\Plugins\InstallOptionsEx.dll"
ReserveFile "test2.ini"

;Order of pages
Page custom SetCustom ValidateCustom ": Testing InstallOptions" ;Custom page. InstallOptions gets called in SetCustom.
Page instfiles

Section "Components"

  ;Get Install Options dialog user input

  ReadINIStr ${TEMP1} "$PLUGINSDIR\test2.ini" "Field 2" "State"
  DetailPrint "Install X=${TEMP1}"
  ReadINIStr ${TEMP1} "$PLUGINSDIR\test2.ini" "Field 3" "State"
  DetailPrint "Install Y=${TEMP1}"
  ReadINIStr ${TEMP1} "$PLUGINSDIR\test2.ini" "Field 4" "State"
  DetailPrint "Install Z=${TEMP1}"
  ReadINIStr ${TEMP1} "$PLUGINSDIR\test2.ini" "Field 5" "State"
  DetailPrint "File=${TEMP1}"
  ReadINIStr ${TEMP1} "$PLUGINSDIR\test2.ini" "Field 6" "State"
  DetailPrint "Dir=${TEMP1}"
  ReadINIStr ${TEMP1} "$PLUGINSDIR\test2.ini" "Field 9" "State"
  DetailPrint "File=${TEMP1}"
  ReadINIStr ${TEMP1} "$PLUGINSDIR\test2.ini" "Field 10" "State"
  DetailPrint "Dir=${TEMP1}"
  
SectionEnd

Function .onInit

  ;Extract InstallOptions files
  ;$PLUGINSDIR will automatically be removed when the installer closes
  
  InitPluginsDir
  File /oname=$PLUGINSDIR\test2.ini "test2.ini"
  
		File "/oname=$PLUGINSDIR\button.bmp" "${NSISDIR}\Contrib\skinnedbutton\skins\ishield.bmp"
		
FunctionEnd

Function SetCustom
  Push $R0
  Push $R1
	SetCtlColors $HWNDPARENT "${TEXT_COLOR}" "${BGCOLOR}"

	InstallOptionsEx::initDialog /NOUNLOAD "$PLUGINSDIR\test2.ini"
  Pop $R0
  
  SetCtlColors $R0 "${TEXT_COLOR}" "${BGCOLOR}"
  
		GetDlgItem $R1 $R0 1200
		SetCtlColors "$R1" "${TEXT_COLOR}" "${BGCOLOR}"
		GetDlgItem $R1 $R0 1201
		SetCtlColors "$R1" "${TEXT_COLOR}" "${BGCOLOR}"
		GetDlgItem $R1 $R0 1202
		SetCtlColors "$R1" "${TEXT_COLOR}" "${BGCOLOR}"
		GetDlgItem $R1 $R0 1203
		SetCtlColors "$R1" "${TEXT_COLOR}" "${BGCOLOR}"
		GetDlgItem $R1 $R0 1206
		SetCtlColors "$R1" "${TEXT_COLOR}" "${BGCOLOR}"

		; set the background of the icon
		; but has no effect with InstalloptionsEx......
		GetDlgItem $R1 $R0 1207
		SetCtlColors "$R1" "${TEXT_COLOR}" "${BGCOLOR}"
		
	InstallOptionsEx::show
  
  Pop $R1
  Pop $R0
FunctionEnd

Function ValidateCustom

  ReadINIStr ${TEMP1} "$PLUGINSDIR\test2.ini" "Field 2" "State"
  StrCmp ${TEMP1} 1 done
  
  ReadINIStr ${TEMP1} "$PLUGINSDIR\test2.ini" "Field 3" "State"
  StrCmp ${TEMP1} 1 done

  ReadINIStr ${TEMP1} "$PLUGINSDIR\test2.ini" "Field 4" "State"
  StrCmp ${TEMP1} 1 done
    MessageBox MB_ICONEXCLAMATION|MB_OK "You must select at least one install option!"
    Abort

  done:
  
FunctionEnd



	Function .onGUIInit
		skinnedbutton::skinit /NOUNLOAD "$PLUGINSDIR\button.bmp"
		Pop $0
		StrCmp $0 "success" noerror
			MessageBox MB_ICONEXCLAMATION|MB_OK "skinned button error: $0"
		noerror:
	FunctionEnd

	Function .onGUIEnd
		skinnedbutton::unskinit
	FunctionEnd
