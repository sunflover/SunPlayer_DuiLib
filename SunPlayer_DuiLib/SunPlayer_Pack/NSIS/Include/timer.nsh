/*

timer.nsh

*/

!ifndef __TIMER_H__
!define __TIMER_H__
!verbose push
!verbose 3

!macro _TMR_CreateTimer FUNCTION INTERVAL
    Push $0

    GetFunctionAddress $0 "${FUNCTION}"
    timer::t0 $0 "${INTERVAL}"

    Pop $0
!macroend

!define TMR_CreateTimer `!insertmacro _TMR_CreateTimer`

!macro _TMR_KillTimer FUNCTION
    Push $0

    GetFunctionAddress $0 "${FUNCTION}"
    timer::t1 $0

    Pop $0
!macroend

!define TMR_KillTimer `!insertmacro _TMR_KillTimer`

!verbose pop
!endif
