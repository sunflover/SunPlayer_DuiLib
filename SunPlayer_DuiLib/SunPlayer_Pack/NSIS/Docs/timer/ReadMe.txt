${TMR_CreateTimer} OnTimer 200

${TMR_KillTimer} OnTimer

其中OnTimer是NSIS函数名称，200是timer的时间间隔，单位是毫秒
即每隔200ms会调用一次OnTimer函数

记得加头文件哦
!include "timer.nsh"


作者：pigger
时间：2014-12-31