文件: StringPlug.dll
大小: 382976 字节
文件版本: 1.0.1.0
修改时间: 2015年2月17日, 19:14:17
MD5: 48D5ED2A8C50287F707E06E8C6BE63B4
SHA1: 98A37CFA5FC840DB23372F3C7D76FB0BDE267EE5
CRC32: 606CA77F

鉴于NSIS处理字符功能有太多局限，特开发外部DLL库用于NSIS字符文本&文本文件的处理。

日期：2015-2-28
by 见与不见 QQ:532523788
------------------------
简单软件工作室
http://www.jjdd925.com
友情链接：[轻狂志]
http://www.flighty.cn/
------------------------


注: 第三方DLL不是NSIS插件，但能够和插件一样甚至更强大一些，固定调用方式如下，把段内代码Copy到nsis脚本的该段中，没有该区段就全部Copy过去。

Function .onInit
    InitPluginsDir
    File /oname=$PLUGINSDIR\StringPlug.dll "StringPlug.dll"
    #程序运行时自动将DLL加载到内存
    System::Call 'kernel32::LoadLibraryA(m "$PLUGINSDIR\StringPlug.dll")'
FunctionEnd
===========================================================================
例子1: 
文本_替换 对应函数  [Text_ReplaceText] 详细信息请参考帮助；
Text_ReplaceText()
  参数<1> 原文本 [文本型]
  参数<2> 替换次数 [整数型]  允许接收空参数数据。注明：可空；
  参数<3> 是否区分大小写 [整数型] 允许接收空参数数据。注明：可空；
  参数<4> 欲被替换的文本 [文本型]
  参数<5> 用作替换的文本 [文本型]

实例 (把“1234567890”中的字符“1”替换为“AA”，返回的结果:"AA234567890")
System::Call 'Stringplug::Text_ReplaceText(m,i,i,m,m)("1234567890",,,"1","AA")m.R0 '

##############################################################################


