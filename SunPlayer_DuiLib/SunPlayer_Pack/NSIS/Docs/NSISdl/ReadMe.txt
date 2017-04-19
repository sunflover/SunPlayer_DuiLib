NSISdl 1.3 - 用于 NSIS 的 HTTP 下载插件
---------------------------------------------

Copyright (C) 2001-2002 Yaroslav Faybishenko & Justin Frankel

本插件可用于 NSIS 通过 HTTP 下载文件。
要连接到网络，使用 Dialer 插件。

用法
----

NSISdl::download http://www.domain.com/file localfile.exe

你也可以使用参数 /TIMEOUT 设置超时毫秒数：

NSISdl::download /TIMEOUT=30000 http://www.domain.com/file localfile.exe

返回值压入堆栈：

  "cancel" 如果取消
  "success" 如果成功
  否则，为描述错误信息的字符串。

如果你不想显示进度条窗口，使用 NSISdl::download_quiet。

用法示例：

NSISdl::download http://www.domain.com/file localfile.exe
Pop $R0 ; 获取返回值
  StrCmp $R0 "success" +3
    MessageBox MB_OK "下载失败：$R0"
    Quit

参见 Examples 文件夹的 waplugin.nsi 查看另一个示例。

代理
----

NSISdl 仅支持基本代理设置，它不支持需要鉴权的代理、自动配置脚本等。
NSISdl 从位于注册表键 HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings
下的 Internet Explorer 注册表中读取代理设置，它读取并解析代理启用和代理服务器。

如果你不希望 NSISdl 使用 Internet Explorer 代理设置，使用 /NOIEPROXY 标志。
/NOIEPROXY 应该位于 /TRANSLATE 和 /TIMEOUT 之后。例如：

如果你要自己指定代理，使用 /PROXY 标志。

NSISdl::download /NOIEPROXY http://www.domain.com/file localfile.exe
NSISdl::download /TIMEOUT=30000 /NOIEPROXY http://www.domain.com/file localfile.exe
NSISdl::download /PROXY proxy.whatever.com http://www.domain.com/file localfile.exe
NSISdl::download /PROXY proxy.whatever.com:8080 http://www.domain.com/file localfile.exe

翻译
----

要翻译 NSISdl，在调用行增加下列值：

/TRANSLATE2 downloading connecting second minute hour seconds minutes hours progress
(译：/TRANSLATE '正在下载' '正在连接' '秒' '分' '时' '秒(复)' '分(复)' '时(复)' '进度')

默认值为：
 
  downloading - "Downloading %s"
  connecting - "Connecting ..."
  second - " (1 second remaining)"
  minute - " (1 minute remaining)"
  hour - " (1 hour remaining)"
  seconds - " (%u seconds remaining)"
  minutes - " (%u minutes remaining)"
  hours - " (%u hours remaining)"
  progress - "%skB (%d%%) of %skB @ %u.%01ukB/s"

为保持兼容，旧式 /TRANSLATE 方式仍可使用。

/TRANSLATE downloading connecting second minute hour plural progress remianing
(译：/TRANSLATE '正在下载' '正在连接' '秒' '分' '时' '复数形式' '进度' '剩余')

默认值为：

  downloading - "Downloading %s"
  connecting - "Connecting ..."
  second - "second"
  minute - "minute"
  hour - "hour"
  plural - "s"
  progress - "%dkB (%d%%) of %ukB @ %d.%01dkB/s"
  remaining -  " (%d %s%s remaining)"

/TRANSLATE 和 /TRANSLATE2 必须位于 /TIMEOUT 之前。