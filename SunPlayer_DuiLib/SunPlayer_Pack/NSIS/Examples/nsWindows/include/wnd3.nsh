;handle to window 3
var hwindow3

Function nsWindowsPage3
  IsWindow $hwindow3 Create_End
	${NSW_CreateWindow} $hwindow3 "WND 3" 1018  ;创建窗口
  ;set window pos
;  ${NSW_SetWindowPos} $hwindow3 0 0  ;调整窗口位置
  ;set window size
  ${NSW_SetWindowSize} $hwindow3 200 100  ;调整出口大小
  ;set the child window's pos to the center of parent window
  ${NSW_CenterWindow} $hwindow3 $hwndparent  ;将窗口$hwindow3居中于$hwndparent

  ;call back function of window 3
	${NSW_OnBack} OnBack3  ;窗口的回调函数, 在点击X系统按钮关闭窗口时执行

	${NSW_CreateButton} 50 -30 50 18u 'WND 1'
	 Pop $R0
	${NSW_OnClick} $R0 nsWindowsPage1

	${NSW_CreateButton} 100 -30 50 18u 'WND 2'
	 Pop $R0
	${NSW_OnClick} $R0 nsWindowsPage2

;Show Window 3
	${NSW_Show}
Create_End:
;Show Window 3
  ShowWindow $hwindow3 ${SW_SHOW}
FunctionEnd

Function OnBack3
;Close Window 3
  ${NSW_DestroyWindow} $hwindow3
FunctionEnd


