!ifndef LR_LOADFROMFILE
  !define LR_LOADFROMFILE     0x0010
!endif

!ifndef LR_CREATEDIBSECTION
  !define LR_CREATEDIBSECTION 0x2000
!endif

!ifndef STM_SETIMAGE
  !define STM_SETIMAGE        370
!endif

!ifndef IMAGE_BITMAP
  !define IMAGE_BITMAP        0
!endif

!ifndef sysLoadImage
  !define sysLoadImage        "user32::LoadImageA(i, t, i, i, i, i) i"
!endif

!ifndef sysDeleteObject
  !define sysDeleteObject     "gdi32::DeleteObject(i) i"
!endif

!define MUI_UI "${NSISDIR}\Contrib\UIs\modern_instpic.exe"
ShowInstDetails nevershow

!macro DisplayImage IMG_NAME
	Push $0
	Push $1
	Push $6
	GetTempFileName $1
	File /oname=$1 "${IMG_NAME}"
        FindWindow $0 "#32770" "" $HWNDPARENT
        GetDlgItem $0 $0 2000
        System::Call '${sysLoadImage} (0, s, ${IMAGE_BITMAP}, 0, 0, ${LR_CREATEDIBSECTION}|${LR_LOADFROMFILE}) .r6' "$1"
        SendMessage $0 ${STM_SETIMAGE} ${IMAGE_BITMAP} $6
        System::Call "${sysDeleteObject} (r6)"
	Delete $1
        Pop $6
	Pop $1
	Pop $0
!macroend
