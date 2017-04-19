HddInfo
------
可以获取硬盘序列号等信息。


函数
-----
HddInfo::GetModelNumber		;获取硬盘型号
HddInfo::GetSerialNumber	;获取硬盘序列号
HddInfo::GetRevisionNumber	;获取硬盘修订版本
HddInfo::GetBufferSize		;获取硬盘缓存大小
HddInfo::GetDiskSize		;获取硬盘大小


参数
-----
参数只有一个, 就是硬盘是第几块硬盘, 第一块就是0, 如此类推...


返回值
------------
结果保存在堆栈。


实例
-----
查看实例代码: GetHardDisk.nsi


局限性
------------
本插件仅在WinXP下测试通过, 只支持硬盘不支持U盘


版权信息
--------------
网上抄来的代码改成的NSIS插件