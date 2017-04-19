<NSIS图片水纹特效脚本>
脚本编写：zhfi
特别感谢：Restools，X-Star

提示:水纹底图必须是翻转的图片，显示的时候会翻转图片来显示。


Restools的水纹特效插件 - 移植到NSIS中 20080709更新 

restools
http://restools.hanzify.org
时间仓促，所以可能会有点谬误，如有错误可以提出
waterctrl.dll 为一个用于 Inno Setup 的 16.5 KB 的水纹特效插件。
需要注意，插件使用 MFC, 系统需要有 mfc42.dll，不过一般系统自带。

v2 版本  新增设置水纹插件的父句柄

Function enablewater(ParentWnd: HWND; Left, Top: integer; Bmp: HBITMAP;
     WaterRadius, WaterHeight: integer): BOOL; external 'enablewater@files:waterctrl.dll stdcall';
//ParentWnd     放置特效窗口的父窗口句柄。
//Left          左位置
//Top           上位置
//Bmp           位图句柄。
//WaterRadius   水纹半径，会令到水纹看起来范围更广。
//WaterHeight   水纹高度，会令到水纹看起来更深。
//注意，水纹插件自动根据图片来设定高度和宽度，
//另外水纹底图必须是翻转的图片，显示的时候会翻转图片来显示。

