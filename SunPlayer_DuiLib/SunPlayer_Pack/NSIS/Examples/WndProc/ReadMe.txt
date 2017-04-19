WndProc
--------
可以用来响应Window消息，在回调函数中作一些处理
和WndSubclass插件类似，可用于Subclass Window

用法
--------
WndProc::onCallback [/r=x] 窗体句柄 回调函数地址

/r=x 参数为可选项，x表示要使用的变量，意义如下:
0 - 20 分别表示$0 - $R9
32 表示第1个用Var声明的变量，33是第2个，如此类推...

如指定/r=x参数，则会使用由x开始的连续四个变量作为消息处理函数的四个参数
例如指定/r=0, 则在回调函数中：
$0 = hwnd,       // handle to window
$1 = uMsg,      // message identifier
$2 = wParam,   // first message parameter
$3 = lParam   // second message parameter

如没指定/r=x参数，则只使用最先用Var声明的三个变量分别作为uMsg,wParam,lParam

使用 GetFunctionAddress 获取期望的回调函数地址。

使用 SetErrorLevel 和 Abort 来给消息处理函数设置返回值, 用法见Example里的例子。
	

版权所有
-------------------------------
Copyright (c) 2011 -2012 gfm688