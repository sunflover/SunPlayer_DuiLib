;handle to window 2
var hwindow2
;handle to controls
Var hBUTTON2
Var hEDIT2
Var hCHECKBOX2

Function nsWindowsPage2
  IsWindow $hwindow2 Create_End
	${NSW_CreateWindow} $hwindow2 "WND 2" 1018   ;创建窗口

  ;set the child window's pos to the center of parent window
  ${NSW_CenterWindow} $hwindow2 $hwndparent  ;将窗口$hwindow2居中于$hwndparent
  ;set the distransparent percentage
  ${NSW_SetTransparent} $hwindow2 80  ;设置窗口的不透明度

  EnableWindow $hwndparent 0   ;禁用主窗口
  ;call back function of window 2
	${NSW_OnBack} OnBack2    ;窗口的回调函数, 在点击X系统按钮关闭窗口时执行

	${NSW_CreateButton} 0 0 100% 12u Test
	Pop $hBUTTON2
	${NSW_OnClick} $hBUTTON2 OnClick2

	${NSW_CreateButton} 100 -30 50 18u 'WND 1'
	Pop $R0
	${NSW_OnClick} $R0 nsWindowsPage1

	${NSW_CreateButton} 50 -30 50 18u 'Close '
	Pop $R0
	${NSW_OnClick} $R0 OnBack2

	${NSW_CreateText} 0 35 100% 12u "hello (please drop one file to here)"
	Pop $hEDIT2
	${NSW_OnChange} $hEDIT2 OnChange2   ;更改内容时执行
	;DropFiles ;single file only
	${NSW_onDropFiles} $hEDIT2 onDropSingleFile  ;添加文件拽入支持

	${NSW_CreateCheckbox} 0 -40 100% 8u Test
	Pop $hCHECKBOX2
	${NSW_OnClick} $hCHECKBOX2 OnCheckbox

	${NSW_CreateLabel} 0 40u 75% 40u "* Type `hello there` above.$\n* Click the button.$\n* Check the checkbox.$\n* Hit the Back button."
	Pop $0

	${NSW_Show}
Create_End:
  ShowWindow $hwindow2 ${SW_SHOW}
FunctionEnd

Function OnClick2

	Pop $0 # HWND

	MessageBox MB_OK clicky

FunctionEnd


Function OnChange2

	Pop $0 # HWND

	${NSW_GetText} $hEDIT2 $0

	${If} $0 == "hello there"
		MessageBox MB_OK "right back at ya"
	${EndIf}

FunctionEnd

Function OnBack2
  EnableWindow $hwindow2 0
  MessageBox MB_YESNO "are you sure? $$hwindow2:$hwindow2" IDYES +3
  EnableWindow $hwindow2 1
	Abort
  ${NSW_DestroyWindow} $hwindow2
  EnableWindow $hwndparent 1
  BringToFront

FunctionEnd

; 拽入单个文件的处理函数
Function onDropSingleFile ;drop single file  ;拽入单个文件
	Pop $iDropFiles ;numbers of files   ;所拽入文件的个数
	Pop $sDropFiles ;full path of this (the first one) file  ;拽入的文件路径, 如果文件个数不止一个, 则按照顺序先后弹出
  ${For} $R0 2 $iDropFiles  ; 在文件个数大于1个时, 必须将堆栈中多余的不需要的文件路径释放掉, 防止错误
    Pop $R1   ;pop up the rest strings from static memory (if you droped more than one) ;释放掉堆栈中的其余文件路径
  ${Next}
  ;your code:
	;MessageBox MB_OK "onDropFiles $$sDropFiles:$sDropFiles"
  ${GetFileAttributes} "$sDropFiles" "ARCHIVE" $R0  ;获取文件属性, 这里仅限于 "ARCHIVE" , 属性符合 $R0 返回1, 不符返回0
  StrCmp $R0 1 0 +2  ;如果是 "ARCHIVE" (1), 就更改edit的文本为 所拽入的文件
	  ${NSW_SetText} $hEDIT2 "$sDropFiles"

FunctionEnd


