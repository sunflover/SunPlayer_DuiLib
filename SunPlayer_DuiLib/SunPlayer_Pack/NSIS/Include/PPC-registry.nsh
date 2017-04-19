!define PPC-registry::CeRapiInit `!insertmacro PPC-registry::CeRapiInit`

!macro PPC-registry::CeRapiInit _ERR
	PPC-registry::_CeRapiInit /NOUNLOAD
	Pop ${_ERR}
!macroend


!define PPC-registry::CeRapiInitEx `!insertmacro PPC-registry::CeRapiInitEx`

!macro PPC-registry::CeRapiInitEx _ERR
	PPC-registry::_CeRapiInitEx /NOUNLOAD
	Pop ${_ERR}
!macroend


!define PPC-registry::CeRapiUninit `!insertmacro PPC-registry::CeRapiUninit`

!macro PPC-registry::CeRapiUninit
	PPC-registry::_CeRapiUninit /NOUNLOAD
!macroend


!define PPC-registry::Open `!insertmacro PPC-registry::Open`

!macro PPC-registry::Open _PATH _OPTIONS _ERR
	PPC-registry::_Open /NOUNLOAD `${_PATH}` `${_OPTIONS}`
	Pop ${_ERR}
!macroend


!define PPC-registry::Find `!insertmacro PPC-registry::Find`

!macro PPC-registry::Find _PATH _VALUE_OR_KEY _STRING _TYPE
	PPC-registry::_Find /NOUNLOAD
	Pop ${_PATH}
	Pop ${_VALUE_OR_KEY}
	Pop ${_STRING}
	Pop ${_TYPE}
!macroend


!define PPC-registry::Close `!insertmacro PPC-registry::Close`

!macro PPC-registry::Close
	PPC-registry::_Close /NOUNLOAD
!macroend


!define PPC-registry::KeyExists `!insertmacro PPC-registry::KeyExists`

!macro PPC-registry::KeyExists _PATH _ERR
	PPC-registry::_KeyExists /NOUNLOAD `${_PATH}`
	Pop ${_ERR}
!macroend


!define PPC-registry::Read `!insertmacro PPC-registry::Read`

!macro PPC-registry::Read _PATH _VALUE _STRING _TYPE
	PPC-registry::_Read /NOUNLOAD `${_PATH}` `${_VALUE}`
	Pop ${_STRING}
	Pop ${_TYPE}
!macroend


!define PPC-registry::Write `!insertmacro PPC-registry::Write`

!macro PPC-registry::Write _PATH _VALUE _STRING _TYPE _ERR
	PPC-registry::_Write /NOUNLOAD `${_PATH}` `${_VALUE}` `${_STRING}` `${_TYPE}`
	Pop ${_ERR}
!macroend


!define PPC-registry::ReadExtra `!insertmacro PPC-registry::ReadExtra`

!macro PPC-registry::ReadExtra _PATH _VALUE _NUMBER _STRING _TYPE
	PPC-registry::_ReadExtra /NOUNLOAD `${_PATH}` `${_VALUE}` `${_NUMBER}`
	Pop ${_STRING}
	Pop ${_TYPE}
!macroend


!define PPC-registry::WriteExtra `!insertmacro PPC-registry::WriteExtra`

!macro PPC-registry::WriteExtra _PATH _VALUE _STRING _ERR
	PPC-registry::_WriteExtra /NOUNLOAD `${_PATH}` `${_VALUE}` `${_STRING}`
	Pop ${_ERR}
!macroend


!define PPC-registry::CreateKey `!insertmacro PPC-registry::CreateKey`

!macro PPC-registry::CreateKey _PATH _ERR
	PPC-registry::_CreateKey /NOUNLOAD `${_PATH}`
	Pop ${_ERR}
!macroend


!define PPC-registry::DeleteValue `!insertmacro PPC-registry::DeleteValue`

!macro PPC-registry::DeleteValue _PATH _VALUE _ERR
	PPC-registry::_DeleteValue /NOUNLOAD `${_PATH}` `${_VALUE}`
	Pop ${_ERR}
!macroend


!define PPC-registry::DeleteKey `!insertmacro PPC-registry::DeleteKey`

!macro PPC-registry::DeleteKey _PATH _ERR
	PPC-registry::_DeleteKey /NOUNLOAD `${_PATH}`
	Pop ${_ERR}
!macroend


!define PPC-registry::DeleteKeyEmpty `!insertmacro PPC-registry::DeleteKeyEmpty`

!macro PPC-registry::DeleteKeyEmpty _PATH _ERR
	PPC-registry::_DeleteKeyEmpty /NOUNLOAD `${_PATH}`
	Pop ${_ERR}
!macroend


!define PPC-registry::CopyValue `!insertmacro PPC-registry::CopyValue`

!macro PPC-registry::CopyValue _PATH_SOURCE _VALUE_SOURCE _PATH_TARGET _VALUE_TARGET _ERR
	PPC-registry::_CopyValue /NOUNLOAD `${_PATH_SOURCE}` `${_VALUE_SOURCE}` `${_PATH_TARGET}` `${_VALUE_TARGET}`
	Pop ${_ERR}
!macroend


!define PPC-registry::MoveValue `!insertmacro PPC-registry::MoveValue`

!macro PPC-registry::MoveValue _PATH_SOURCE _VALUE_SOURCE _PATH_TARGET _VALUE_TARGET _ERR
	PPC-registry::_MoveValue /NOUNLOAD `${_PATH_SOURCE}` `${_VALUE_SOURCE}` `${_PATH_TARGET}` `${_VALUE_TARGET}`
	Pop ${_ERR}
!macroend


!define PPC-registry::CopyKey `!insertmacro PPC-registry::CopyKey`

!macro PPC-registry::CopyKey _PATH_SOURCE _PATH_TARGET _ERR
	PPC-registry::_CopyKey /NOUNLOAD `${_PATH_SOURCE}` `${_PATH_TARGET}`
	Pop ${_ERR}
!macroend


!define PPC-registry::MoveKey `!insertmacro PPC-registry::MoveKey`

!macro PPC-registry::MoveKey _PATH_SOURCE _PATH_TARGET _ERR
	PPC-registry::_MoveKey /NOUNLOAD `${_PATH_SOURCE}` `${_PATH_TARGET}`
	Pop ${_ERR}
!macroend


!define PPC-registry::SaveKey `!insertmacro PPC-registry::SaveKey`

!macro PPC-registry::SaveKey _PATH _FILE _OPTIONS _ERR
	PPC-registry::_SaveKey /NOUNLOAD `${_PATH}` `${_FILE}` `${_OPTIONS}`
	Pop ${_ERR}
!macroend


!define PPC-registry::StrToHex `!insertmacro PPC-registry::StrToHex`

!macro PPC-registry::StrToHex _STRING _HEX_STRING
	PPC-registry::_StrToHex /NOUNLOAD `${_STRING}`
	Pop ${_HEX_STRING}
!macroend


!define PPC-registry::HexToStr `!insertmacro PPC-registry::HexToStr`

!macro PPC-registry::HexToStr _HEX_STRING _STRING
	PPC-registry::_HexToStr /NOUNLOAD `${_HEX_STRING}`
	Pop ${_STRING}
!macroend


!define PPC-registry::Unload `!insertmacro PPC-registry::Unload`

!macro PPC-registry::Unload
	PPC-registry::_Unload
!macroend
