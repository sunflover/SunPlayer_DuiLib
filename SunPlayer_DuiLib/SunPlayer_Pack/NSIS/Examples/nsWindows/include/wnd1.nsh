;handle to window 1
var hwindow1  ;用于保存窗口1句柄的变量
;handle to controls
Var hBUTTON1
Var hEDIT1
Var hCHECKBOX1
Var hMEMO

Function nsWindowsPage1
  IsWindow $hwindow1 Create_End
  ;define the window style
  ; 定义要创建窗口的风格
  !define ExStyle ${WS_EX_CLIENTEDGE}|${WS_EX_APPWINDOW}|${WS_EX_WINDOWEDGE}  ;扩展风格
  !define Style ${WS_VISIBLE}|${WS_SYSMENU}|${WS_CAPTION}|${WS_OVERLAPPEDWINDOW} ;基本风格
  ;${NSW_CreateWindowEx} 宏可以创建你自己风格的窗口, 具体用法参考说明
	${NSW_CreateWindowEx} $hwindow1 $hwndparent ${ExStyle} ${Style} "WND 1 (please drop some file(s) / Dir(s) to here)" 1018

  ;set the child window's pos to the center of parent window
  ${NSW_CenterWindow} $hwindow1 $hwndparent  ;将窗口$hwindow1居中于$hwndparent
  ;set the distransparent percentage
  ${NSW_SetTransparent} $hwindow1 80  ;设置窗口的不透明度
  ;drop multi files/dirs
	${NSW_onDropFiles} $hwindow1 onDropMultiFiles ;添加窗口的拽入文件事件
  ;call back function of window 1
	${NSW_OnBack} OnBack1   ;窗口的回调函数, 在点击X系统按钮关闭窗口时执行

	${NSW_CreateButton} 100 -30 50 18u 'WND 2'
	Pop $R0
	${NSW_OnClick} $R0 nsWindowsPage2

	${NSW_CreateButton} 0 0 100% 12u Test
	Pop $hBUTTON1
	${NSW_OnClick} $hBUTTON1 OnClick1

	${NSW_CreateButton} 50 -30 50 18u 'Close'
	Pop $R0
	${NSW_OnClick} $R0 OnBack1

	${NSW_CreateText} 0 35 100% 12u "hello (please drop one dir to here)"
	Pop $hEDIT1
	${NSW_OnChange} $hEDIT1 OnChange1  ;更改内容时执行
	;DropFiles ;single dir only
	${NSW_onDropFiles} $hEDIT1 onDropSingleDir  ;添加控件的拽入文件事件

	${NSW_CreateCheckbox} 0 -40 100% 8u Test
	Pop $hCHECKBOX1
	${NSW_OnClick} $hCHECKBOX1 OnCheckbox

	${NSW_CreateMemo} 0 40u 75% 40u "* Type `hello there` above. Type `hello there` above. Type `hello there` above. Type `hello there` above.$\r$\n* Click the button.$\r$\n* Check the checkbox.$\r$\n* Hit the Back button.$\r$\n* Hit the Back button.$\r$\n* Hit the Back button.$\r$\n* Hit the Back button.$\r$\n* Hit the Back button."
	Pop $hMEMO

	${NSW_Show} ;show window
Create_End:
  ShowWindow $hwindow1 ${SW_SHOW}
FunctionEnd

Function OnClick1

	Pop $0 # HWND

	MessageBox MB_OK NSW_MaximizeWindow
  ${NSW_SetTransparent} $hwindow1 100
${NSW_MaximizeWindow} $hwindow1    ;最大化窗口
	MessageBox MB_OK NSW_MinimizeWindow
${NSW_MinimizeWindow} $hwindow1   ;最小化窗口
	MessageBox MB_OK NSW_RestoreWindow
;  SendMessage $hwindow1 ${SW_MAXIMIZE} 0 0
  ${NSW_SetTransparent} $hwindow1 80
${NSW_RestoreWindow} $hwindow1    ;还原窗口大小
;	MessageBox MB_OK clicky
FunctionEnd

Function OnChange1

	Pop $0 # HWND

	${NSW_GetText} $hEDIT1 $0   ;获取edit的文字内容

	${If} $0 == "hello there"  ;当输入 "hello there" 时,弹出消息框
		MessageBox MB_OK "right back at ya"
	${EndIf}

FunctionEnd

Function OnBack1
  EnableWindow $hwindow1 0    ;禁用窗口1
	MessageBox MB_YESNO "are you sure? $$hwindow1:$hwindow1" IDYES +3
  EnableWindow $hwindow1 1    ;启用窗口1
	Abort                       ;终止此函数
  ${NSW_DestroyWindow} $hwindow1  ;销毁窗口1, 当然你也可以换成让窗口1隐藏
  BringToFront                    ;将主窗口激活
  ${NSW_RestoreWindow} $hwndparent  ;恢复主窗口大小
  EnableWindow $hwndparent 1        ;启用主窗口

FunctionEnd

;拽入多个文件的事件处理
Function onDropMultiFiles ;drop multi file/dir (s)
	Pop $iDropFiles ;numbers of file ;所拽入文件的个数
  StrCpy $sDropFiles ""   ;初始化文件路径变量
  ${For} $R0 1 $iDropFiles  ;循环, 将所有拽入的文件的完整路径名称从堆栈中弹出
    Pop $R1  ;弹出
    StrCpy $sDropFiles "$sDropFiles$R1$\r$\n" ;将内容复制给 $sDropFiles
  ${Next}
  ;your code here:
	;MessageBox MB_OK "onDropFiles $$sDropFiles:$sDropFiles"
	${NSW_SetText} $hMEMO "file numbers :$iDropFiles$\r$\n$sDropFiles" ;设置Memo内容为所有拽入文件的路径

FunctionEnd

; 拽入单个文件的处理函数
;其余同上, 如果只要单个文件, 将剩余的堆栈内容全部弹出后不使用即可
Function onDropSingleDir ;drop single dir
	Pop $iDropFiles ;numbers of dirs    ;文件个数
	Pop $sDropFiles ;full path of this (the first one) dir ;第一个文件
  ${For} $R0 2 $iDropFiles    ;循环
    Pop $R1  ;pop up the rest strings from static memory (if you droped more than one) ;弹出, 但不使用
  ${Next}
  ;your code:
	;MessageBox MB_OK "onDropFiles $$sDropFiles:$sDropFiles"
  ${GetFileAttributes} "$sDropFiles" "DIRECTORY" $R0   ;获取并判断文件属性, 这里是比较 "DIRECTORY" ,是则返回1到$R0 中,否则为0
  StrCmp $R0 1 0 +2   ;判断是否
	  ${NSW_SetText} $hEDIT1 "$sDropFiles"  ;设置控件文字

FunctionEnd


