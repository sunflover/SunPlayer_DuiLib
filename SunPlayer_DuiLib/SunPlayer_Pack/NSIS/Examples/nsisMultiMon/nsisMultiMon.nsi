/*nsisMultiMon Test
nsisMultiMon：多显示器管理插件
By Ansifa*/

OutFile "nsisMultiMon Test.EXE"
ShowInstDetails show
Section
nsisMultiMon::GetAllMonitorCount
DetailPrint '你有$R0个显示器'

nsisMultiMon::GetActiveMonitorCount
DetailPrint '活动的显示器有$R0个'

nsisMultiMon::GetVirtualDesktopRect
DetailPrint '桌面范围为：原点：($R0,$R1)，长宽：($R2,$R3)'

nsisMultiMon::GetMonitorRect 0 ; [ID:int]
DetailPrint '显示器0（第一个）范围为：原点：($R0,$R1)，长宽：($R2,$R3)'

nsisMultiMon::GetWorkArea
DetailPrint '工作区范围（减去任务栏和其他状态栏）为：原点：($R0,$R1)，长宽：($R2,$R3)'

nsisMultiMon::IsPointOnMonitor 0 800 600 ; [ID:int] [X:int] [Y:int]
DetailPrint '点：(800，600)是否在显示器0上面：$R0'

nsisMultiMon::IsPointOnMonitor 0 2000 2000 ; [ID:int] [X:int] [Y:int]
DetailPrint '点：(2000，2000)是否在显示器0上面：$R0'

DetailPrint "将安装程序窗口移到显示器n上面，以工作区/显示器为中心显示窗体"
nsisMultiMon::CenterInstallerOnMonitor 0 0 ; [显示器序号n] [工作区为中心值0；显示器1]

SectionEnd
