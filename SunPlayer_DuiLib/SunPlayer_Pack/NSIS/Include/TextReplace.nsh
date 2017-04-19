!define textreplace::FindInFile `!insertmacro textreplace::FindInFile`

!macro textreplace::FindInFile _INPUTFILE _FINDIT _OPTIONS _COUNT
	textreplace::_FindInFile /NOUNLOAD `${_INPUTFILE}` `${_FINDIT}` `${_OPTIONS}`
	Pop ${_COUNT}
!macroend


!define textreplace::ReplaceInFile `!insertmacro textreplace::ReplaceInFile`

!macro textreplace::ReplaceInFile _INPUTFILE _OUTPUTFILE _REPLACEIT _REPLACEWITH _OPTIONS _COUNT
	textreplace::_ReplaceInFile /NOUNLOAD `${_INPUTFILE}` `${_OUTPUTFILE}` `${_REPLACEIT}` `${_REPLACEWITH}` `${_OPTIONS}`
	Pop ${_COUNT}
!macroend


!define textreplace::FillReadBuffer `!insertmacro textreplace::FillReadBuffer`

!macro textreplace::FillReadBuffer _FILE _POINTER
	textreplace::_FillReadBuffer /NOUNLOAD `${_FILE}`
	Pop ${_POINTER}
!macroend


!define textreplace::FreeReadBuffer `!insertmacro textreplace::FreeReadBuffer`

!macro textreplace::FreeReadBuffer _POINTER
	textreplace::_FreeReadBuffer /NOUNLOAD `${_POINTER}`
!macroend


!define textreplace::Unload `!insertmacro textreplace::Unload`

!macro textreplace::Unload
	textreplace::_Unload
!macroend
