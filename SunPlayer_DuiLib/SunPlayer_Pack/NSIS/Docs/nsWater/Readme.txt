nsWater
-------
NSIS水纹特效插件


用法
-------
插件命令:
nsWater::Set 窗口句柄 位图句柄

窗口句柄 一般为控件句柄(静态控件必须有SS_NOTIFY样式)
水纹底图必须是翻转的图片，显示的时候会翻转图片来显示。

插件自定义消息：
!define WM_SETBLOB 0x0470
; WM_SETBLOB为自定义消息，用于设置鼠标引起的水波大小
; wParam   水纹半径，会令到水纹看起来范围更广。
; lParam   水纹高度，会令到水纹看起来更深。

实例代码：Examples\nsWater.nsi


版权信息
--------------
核心代码来自网上的SpecialFX
http://www.vckbase.com/code/viewcode.asp?id=1612

插件编写：gfm688

注：代码经修改已无需MFC支持，体积更小(8.0 KB)