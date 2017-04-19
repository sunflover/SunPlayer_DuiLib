<NSIS图片火焰特效脚本>
脚本编写：zhfi
特别感谢：Restools，X-Star

提示:火焰底图必须是翻转的图片，显示的时候会翻转图片来显示。

Restools的火焰特效插件 - 移植到NSIS中 20080709更新

restools
http://restools.hanzify.org
时间仓促，所以可能会有点谬误，如有错误可以提出
firectrl.dll 为一个用于 Inno Setup 的 17.5 KB 的火焰特效插件。
需要注意，插件使用 MFC, 系统需要有 mfc42.dll，不过一般系统自带。

Function enablefire(ParentWnd: HWND; Left, Top: integer; Bmp: HBITMAP;
     FireAlpha: integer): BOOL; external 'enablefire@files:firectrl.dll stdcall';
//ParentWnd     放置特效窗口的父窗口句柄。
//Left          特效窗口x位置
//Top           特效窗口y位置
//Bmp           位图句柄。
//FireAlpha     火焰 Alpha 值 0~100，值越大，火焰更浓。
//注意，火焰插件自动根据图片来设定高度和宽度，
//另外火焰底图必须是翻转的图片，显示的时候会翻转图片来显示。



