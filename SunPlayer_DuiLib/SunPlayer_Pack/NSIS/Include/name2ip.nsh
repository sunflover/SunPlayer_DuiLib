!define name2ip::FindFirstIP `!insertmacro name2ip::FindFirstIP`

!macro name2ip::FindFirstIP _HOSTNAME _IP
	name2ip::FindFirstIP /NOUNLOAD `${_HOSTNAME}`
	Pop ${_IP}
!macroend


!define name2ip::FindNextIP `!insertmacro name2ip::FindNextIP`

!macro name2ip::FindNextIP _IP
	name2ip::FindNextIP /NOUNLOAD
	Pop ${_IP}
!macroend


!define name2ip::FindCloseIP `!insertmacro name2ip::FindCloseIP`

!macro name2ip::FindCloseIP
	name2ip::FindCloseIP
!macroend
