!ifndef TOOLTIP_INCLUDED
!define TOOLTIP_INCLUDED
!verbose push
!verbose 3

!ifdef define
    !undef define
!endif

!macro ${__FILE__}_DEFINE CONSTANT VALUE
    !ifdef `${CONSTANT}`
        !undef `${CONSTANT}`
    !endif
    !define `${CONSTANT}` `${VALUE}`
!macroend

!define define '!insertmacro ${__FILE__}_DEFINE'

${define} TTS_ALWAYSTIP           0x01
${define} TTS_NOPREFIX            0x02
#if (_WIN32_IE >= 0x0500)
${define} TTS_NOANIMATE           0x10
${define} TTS_NOFADE              0x20
${define} TTS_BALLOON             0x40
${define} TTS_CLOSE               0x80
#endif

${define} TTF_IDISHWND            0x0001
${define} TTF_CENTERTIP           0x0002
${define} TTF_RTLREADING          0x0004
${define} TTF_SUBCLASS            0x0010
#if (_WIN32_IE >= 0x0300)
${define} TTF_TRACK               0x0020
${define} TTF_ABSOLUTE            0x0080
${define} TTF_TRANSPARENT         0x0100
#if (_WIN32_IE >= 0x0501)
${define} TTF_PARSELINKS          0x1000
#endif // _WIN32_IE >= 0x0501
${define} TTF_DI_SETITEM          0x8000       ; valid only on the TTN_NEEDTEXT callback
#endif      // _WIN32_IE >= 0x0300

${define} TTDT_AUTOMATIC          0
${define} TTDT_RESHOW             1
${define} TTDT_AUTOPOP            2
${define} TTDT_INITIAL            3

; ToolTip Icons possible wParam values for TTM_SETTITLE message
${define} TTI_NONE                0
${define} TTI_INFO                1
${define} TTI_WARNING             2
${define} TTI_ERROR               3
; values larger thant TTI_ERROR are assumed to be an HICON value

; Tool Tip Messages
${define} TTM_ACTIVATE            0x0401
${define} TTM_SETDELAYTIME        0x0403
${define} TTM_ADDTOOLA            0x0404
${define} TTM_ADDTOOLW            0x0432
${define} TTM_DELTOOLA            0x0405
${define} TTM_DELTOOLW            0x0433
${define} TTM_NEWTOOLRECTA        0x0406
${define} TTM_NEWTOOLRECTW        0x0434
${define} TTM_RELAYEVENT          0x0407

${define} TTM_GETTOOLINFOA        0x0408
${define} TTM_GETTOOLINFOW        0x0435

${define} TTM_SETTOOLINFOA        0x0409
${define} TTM_SETTOOLINFOW        0x0436

${define} TTM_HITTESTA            0x040A
${define} TTM_HITTESTW            0x0437
${define} TTM_GETTEXTA            0x040B
${define} TTM_GETTEXTW            0x0438
${define} TTM_UPDATETIPTEXTA      0x040C
${define} TTM_UPDATETIPTEXTW      0x0439
${define} TTM_GETTOOLCOUNT        0x040D
${define} TTM_ENUMTOOLSA          0x040E
${define} TTM_ENUMTOOLSW          0x043A
${define} TTM_GETCURRENTTOOLA     0x040F
${define} TTM_GETCURRENTTOOLW     0x043B
${define} TTM_WINDOWFROMPOINT     0x0410
#if (_WIN32_IE >= 0x0300)
${define} TTM_TRACKACTIVATE       0x0411  ; wParam = TRUE/FALSE start end  lparam = LPTOOLINFO
${define} TTM_TRACKPOSITION       0x0412  ; lParam = dwPos
${define} TTM_SETTIPBKCOLOR       0x0413
${define} TTM_SETTIPTEXTCOLOR     0x0414
${define} TTM_GETDELAYTIME        0x0415
${define} TTM_GETTIPBKCOLOR       0x0416
${define} TTM_GETTIPTEXTCOLOR     0x0417
${define} TTM_SETMAXTIPWIDTH      0x0418
${define} TTM_GETMAXTIPWIDTH      0x0419
${define} TTM_SETMARGIN           0x041A  ; lParam = lprc
${define} TTM_GETMARGIN           0x041B  ; lParam = lprc
${define} TTM_POP                 0x041C
#endif
#if (_WIN32_IE >= 0x0400)
${define} TTM_UPDATE              0x041D
#endif
#if (_WIN32_IE >= 0x0500)
${define} TTM_GETBUBBLESIZE       0x041E
${define} TTM_ADJUSTRECT          0x041F
${define} TTM_SETTITLEA           0x0420  ; wParam = TTI_*, lParam = char* szTitle
${define} TTM_SETTITLEW           0x0421  ; wParam = TTI_*, lParam = wchar* szTitle
#endif

#if (_WIN32_WINNT >= 0x0501)
${define} TTM_POPUP               0x0422
${define} TTM_GETTITLE            0x0423 ; wParam = 0, lParam = TTGETTITLE*

!ifdef __UNICODE__
${define} TTM_ADDTOOL             ${TTM_ADDTOOLW}
${define} TTM_DELTOOL             ${TTM_DELTOOLW}
${define} TTM_NEWTOOLRECT         ${TTM_NEWTOOLRECTW}
${define} TTM_GETTOOLINFO         ${TTM_GETTOOLINFOW}
${define} TTM_SETTOOLINFO         ${TTM_SETTOOLINFOW}
${define} TTM_HITTEST             ${TTM_HITTESTW}
${define} TTM_GETTEXT             ${TTM_GETTEXTW}
${define} TTM_UPDATETIPTEXT       ${TTM_UPDATETIPTEXTW}
${define} TTM_ENUMTOOLS           ${TTM_ENUMTOOLSW}
${define} TTM_GETCURRENTTOOL      ${TTM_GETCURRENTTOOLW}
#if (_WIN32_IE >= 0x0500)
${define} TTM_SETTITLE            ${TTM_SETTITLEW}
#endif
${define} sysCreateToolTip		  `System::Call "User32::CreateWindowExW(is,ws,w,is,is,is,is,is,is,i,i0,i)i.s" 8 "tooltips_class32"`
${define} stTOOLINFO              "(i,i,i,i,i,i,i,i,i,w,i)i"
!else
${define} TTM_ADDTOOL             ${TTM_ADDTOOLA}
${define} TTM_DELTOOL             ${TTM_DELTOOLA}
${define} TTM_NEWTOOLRECT         ${TTM_NEWTOOLRECTA}
${define} TTM_GETTOOLINFO         ${TTM_GETTOOLINFOA}
${define} TTM_SETTOOLINFO         ${TTM_SETTOOLINFOA}
${define} TTM_HITTEST             ${TTM_HITTESTA}
${define} TTM_GETTEXT             ${TTM_GETTEXTA}
${define} TTM_UPDATETIPTEXT       ${TTM_UPDATETIPTEXTA}
${define} TTM_ENUMTOOLS           ${TTM_ENUMTOOLSA}
${define} TTM_GETCURRENTTOOL      ${TTM_GETCURRENTTOOLA}
#if (_WIN32_IE >= 0x0500)
${define} TTM_SETTITLE            ${TTM_SETTITLEA}
#endif
${define} sysCreateToolTip		  `System::Call "User32::CreateWindowExA(is,ts,t,is,is,is,is,is,is,i,i,i)i.s" 8 "tooltips_class32"`
${define} stTOOLINFO              "(i,i,i,i,i,i,i,i,i,t,i)i"
!endif

${define} WS_POPUP                0x80000000
${define} CW_USEDEFAULT       	  0x80000000

!macro CreateToolTipEx TTStyle hWndParent hwndTT
	${sysCreateToolTip} ${TTStyle} ${CW_USEDEFAULT} ${CW_USEDEFAULT} ${CW_USEDEFAULT} ${CW_USEDEFAULT} ${hWndParent}
	Pop ${hwndTT}
!macroend
${define} CreateToolTipEx `!insertmacro CreateToolTipEx`
${define} CreateToolTip `${CreateToolTipEx} ${WS_POPUP}|${TTS_NOPREFIX}|${TTS_ALWAYSTIP}`
${define} CreateBalloonToolTip `${CreateToolTipEx} ${WS_POPUP}|${TTS_NOPREFIX}|${TTS_BALLOON}`

!macro SetCtlToolTips hwndCtl hwndTT TipsText
	Push "${TipsText}"
	Push ${hwndCtl}
	Push ${hwndTT}
	Exch $0
	Exch
	Exch $1
	Push $2
	Exch 3
	System::Call /NOUNLOAD "*(i, i, i, i) i.r2"
	System::Call /NOUNLOAD "User32::GetClientRect(i r1, i r2)"
	System::Call /NOUNLOAD "*$2(i.s, i.s, i.s, i.s)"
	System::Free /NOUNLOAD $2
	System::Call '*${stTOOLINFO}(44,${TTF_SUBCLASS},r1,,s,s,s,s,,s,).r2'
	SendMessage $0 ${TTM_ADDTOOL} 0 $2
	System::Free $2
	Pop $1
	Pop $0
	Pop $2
!macroend
${define} SetCtlToolTips `!insertmacro SetCtlToolTips`

!verbose pop
!endif



