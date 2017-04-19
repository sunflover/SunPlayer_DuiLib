!define time::GetLocalTime `!insertmacro time::GetLocalTime`

!macro time::GetLocalTime _TIME
	time::_GetLocalTime /NOUNLOAD
	Pop ${_TIME}
!macroend


!define time::GetLocalTimeUTC `!insertmacro time::GetLocalTimeUTC`

!macro time::GetLocalTimeUTC _TIME
	time::_GetLocalTimeUTC /NOUNLOAD
	Pop ${_TIME}
!macroend


!define time::SetLocalTime `!insertmacro time::SetLocalTime`

!macro time::SetLocalTime _TIME _ERR
	time::_SetLocalTime /NOUNLOAD `${_TIME}`
	Pop ${_ERR}
!macroend


!define time::SetLocalTimeUTC `!insertmacro time::SetLocalTimeUTC`

!macro time::SetLocalTimeUTC _TIME _ERR
	time::_SetLocalTimeUTC /NOUNLOAD `${_TIME}`
	Pop ${_ERR}
!macroend


!define time::GetFileTime `!insertmacro time::GetFileTime`

!macro time::GetFileTime _FILE _CREATION _WRITE _ACCESS
	time::_GetFileTime /NOUNLOAD `${_FILE}`
	Pop ${_CREATION}
	Pop ${_WRITE}
	Pop ${_ACCESS}
!macroend


!define time::GetFileTimeUTC `!insertmacro time::GetFileTimeUTC`

!macro time::GetFileTimeUTC _FILE _CREATION _WRITE _ACCESS
	time::_GetFileTimeUTC /NOUNLOAD `${_FILE}`
	Pop ${_CREATION}
	Pop ${_WRITE}
	Pop ${_ACCESS}
!macroend


!define time::SetFileTime `!insertmacro time::SetFileTime`

!macro time::SetFileTime _FILE _CREATION _WRITE _ACCESS _ERR
	time::_SetFileTime /NOUNLOAD `${_FILE}` `${_CREATION}` `${_WRITE}` `${_ACCESS}`
	Pop ${_ERR}
!macroend


!define time::SetFileTimeUTC `!insertmacro time::SetFileTimeUTC`

!macro time::SetFileTimeUTC _FILE _CREATION _WRITE _ACCESS _ERR
	time::_SetFileTimeUTC /NOUNLOAD `${_FILE}` `${_CREATION}` `${_WRITE}` `${_ACCESS}`
	Pop ${_ERR}
!macroend


!define time::TimeString `!insertmacro time::TimeString`

!macro time::TimeString _TIME _DAY _MONTH _YEAR _HOUR _MINUTE _SECOND
	time::_TimeString /NOUNLOAD `${_TIME}`
	Pop ${_DAY}
	Pop ${_MONTH}
	Pop ${_YEAR}
	Pop ${_HOUR}
	Pop ${_MINUTE}
	Pop ${_SECOND}
!macroend


!define time::MathTime `!insertmacro time::MathTime`

!macro time::MathTime _EXPRESSION _ERR
	time::_MathTime /NOUNLOAD `${_EXPRESSION}`
	Pop ${_ERR}
!macroend


!define time::Unload `!insertmacro time::Unload`

!macro time::Unload
	time::_Unload
!macroend
