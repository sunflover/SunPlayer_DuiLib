*****************************************************************
***                nsProcess NSIS plugin v1.5                 ***
*****************************************************************

2006 Shengalts Aleksander aka Instructor (Shengalts@mail.ru)

Source function FIND_PROC_BY_NAME based
   upon the Ravi Kochhar (kochhar@physiology.wisc.edu) code
Thanks iceman_k (FindProcDLL plugin) and
   DITMan (KillProcDLL plugin) for direct me


主要功能:
- 通过名称查找进程
- 通过名称结束进程
- 结束指定名称的的所有进程 (不止一个)
- 进程名称不区分大小写
- 支持 Win95/98/ME/NT/2000/XP
- 体积娇小 (4 Kb)

插件函数列表:
**** 查找进程 ****
	nsProcess::_FindProcess /NOUNLOAD "file.exe" 
	Pop $var	;返回值
**** 结束进程 ****
	nsProcess::_KillProcess /NOUNLOAD "file.exe" 
	Pop $var	;返回值
**** 释放插件 ****
	nsProcess::_Unload

插件宏列表:
**** 查找进程 ****
**** Find process ****
${nsProcess::FindProcess} "[file.exe]" $var

"[file.exe]"  - 进程名称 (如 "notepad.exe")

$var     0    成功
         603  进程当前没有运行
         604  无法确定系统类型
         605  不支持的操作系统
         606  无法载入 NTDLL.DLL
         607  无法从 NTDLL.DLL 获得程序地址
         608  NtQuerySystemInformation 失败
         609  无法载入 KERNEL32.DLL
         610  无法从 KERNEL32.DLL 获得程序地址
         611  CreateToolhelp32Snapshot 失败


**** 结束进程 ****
**** Kill process ****
${nsProcess::KillProcess} "[file.exe]" $var

"[file.exe]"  - 进程名称 (如 "notepad.exe")

$var     0    成功
         601  没有结束进程的权限
         602  未能结束部分进程
         603  进程当前没有运行
         604  无法确定系统类型
         605  不支持的操作系统
         606  无法载入 NTDLL.DLL
         607  无法从 NTDLL.DLL 获得程序地址
         608  NtQuerySystemInformation 失败
         609  无法载入 KERNEL32.DLL
         610  无法从 KERNEL32.DLL 获得程序地址
         611  CreateToolhelp32Snapshot 失败


**** 释放插件 ****
**** Unload plugin ****
${nsProcess::Unload}
