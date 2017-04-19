; 这个是用nsWindows创建多窗口的演示
; Copyright (C) 2009 zhfi
; http://hi.baidu.com/zhfi1022/

; 添加插件目录
!addplugindir ".\"
; 添加Include目录, 一般是头文件所在
!addincludedir "..\..\include"
!addincludedir ".\include"

; 定义变量
;var for drop
Var iDropFiles ;用于保存拽入文件的个数
Var sDropFiles ;用于保存拽入文件时的文件路径名称

; 添加所需的头文件
!include FileFunc.nsh
!include nsWindows.nsh
; 添加窗口1的代码(放在wnd1.nsh中, 便于管理)
;window1
!include wnd1.nsh
; 添加窗口2的代码
;window2
!include wnd2.nsh
; 添加窗口3的代码
;window3
!include wnd3.nsh
;!include nsDialogs.nsh
;!include LogicLib.nsh
;!include UsefulLib.nsh

; 编译器相关的设置
SetDatablockOptimize on

Name "nsWindows Example"
OutFile "nsWindows Example.exe"

XPStyle on

SpaceTexts none
; 自定义页面
Page custom nsDialogsPage
; 固有页面
page license

LoadLanguageFile "${NSISDIR}\Contrib\Language files\english.nlf"

; 一般情况下, 如果需要在界面初始化之前调用某些插件的话
; 建议在 .onInit 函数中添加初始化插件目录的代码, 避免错误
Function .onInit
  InitPluginsDir

FunctionEnd

; 这个是自定义页面的创建函数
Function nsDialogsPage
	nsDialogs::Create 1018  ;创建nsis自定义页面, 模仿固有页面(对话框)1018(大小,位置等等)
	Pop $0 ;弹出对话框的句柄到 $0 变量中 (nsWindows类似)
/*
  ; 按照先后顺序, 你还可以这样获取控件句柄
  GetDlgItem $R0 $0 1200
  ; $R0 得到的是你所创建的第一个控件(内部定义从1200开始,其它依次递增)的句柄
  ; $0 是当前自定义页面的对话框句柄, 在" nsDialogs::Create "后 Pop 得到
*/
	${NSD_CreateButton} 50 -30 50 14u 'WND 1' ; 创建一个按钮, 具体参看nsDialogs的说明
	Pop $R0  ;弹出按钮的句柄到变量中
	${NSD_OnClick} $R0 nsWindowsPage1 ;添加控件事件函数, 这里的是点击事件, 也就是点击这个按钮时NSIS要执行的函数

  ;其它控件依此类推
	${NSD_CreateButton} 100 -30 50 14u 'WND 2'
	Pop $R0
	${NSD_OnClick} $R0 nsWindowsPage2

	${NSD_CreateButton} 150 -30 50 14u 'WND 3'
	Pop $R0
	${NSD_OnClick} $R0 nsWindowsPage3

	${NSD_CreateButton} 200 -30 50 14u 'Close'
	Pop $R1
	${NSD_OnClick} $R1 OnClose

	nsDialogs::Show ; 创建完成控件以及关联事件之后, 必须使用这个函数将页面显示出来(nsWindows类似)
FunctionEnd

; 事件函数, 点击关闭程序
Function OnClose
  SendMessage $hwndparent ${WM_CLOSE} 0 0
FunctionEnd

Function OnCheckbox

	Pop $0 # HWND

	MessageBox MB_OK "checkbox clicked"

FunctionEnd

Section
SectionEnd
