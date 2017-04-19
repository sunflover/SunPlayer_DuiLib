!define stack::ns_push_front `!insertmacro stack::ns_push_front`

!macro stack::ns_push_front _STRING
	stack::_ns_push_front /NOUNLOAD `${_STRING}`
!macroend


!define stack::ns_pop_front `!insertmacro stack::ns_pop_front`

!macro stack::ns_pop_front _STRING _ERR
	stack::_ns_pop_front /NOUNLOAD
	Pop ${_STRING}
	Pop ${_ERR}
!macroend


!define stack::ns_push_back `!insertmacro stack::ns_push_back`

!macro stack::ns_push_back _STRING
	stack::_ns_push_back /NOUNLOAD `${_STRING}`
!macroend


!define stack::ns_read `!insertmacro stack::ns_read`

!macro stack::ns_read _INDEX _STRING _ERR
	stack::_ns_read /NOUNLOAD `${_INDEX}`
	Pop ${_STRING}
	Pop ${_ERR}
!macroend


!define stack::ns_write `!insertmacro stack::ns_write`

!macro stack::ns_write _STRING _INDEX _ERR
	stack::_ns_write /NOUNLOAD `${_STRING}` `${_INDEX}`
	Pop ${_ERR}
!macroend


!define stack::ns_size `!insertmacro stack::ns_size`

!macro stack::ns_size _ERR
	stack::_ns_size /NOUNLOAD
	Pop ${_ERR}
!macroend


!define stack::ns_clear `!insertmacro stack::ns_clear`

!macro stack::ns_clear
	stack::_ns_clear /NOUNLOAD
!macroend


!define stack::dll_create `!insertmacro stack::dll_create`

!macro stack::dll_create _HANDLE
	stack::_dll_create /NOUNLOAD
	Pop ${_HANDLE}
!macroend


!define stack::dll_insert `!insertmacro stack::dll_insert`

!macro stack::dll_insert _HANDLE _STRING _INDEX _ERR
	stack::_dll_insert /NOUNLOAD `${_HANDLE}` `${_STRING}` `${_INDEX}`
	Pop ${_ERR}
!macroend


!define stack::dll_delete `!insertmacro stack::dll_delete`

!macro stack::dll_delete _HANDLE _INDEX _STRING _ERR
	stack::_dll_delete /NOUNLOAD `${_HANDLE}` `${_INDEX}`
	Pop ${_STRING}
	Pop ${_ERR}
!macroend


!define stack::dll_read `!insertmacro stack::dll_read`

!macro stack::dll_read _HANDLE _INDEX _STRING _ERR
	stack::_dll_read /NOUNLOAD `${_HANDLE}` `${_INDEX}`
	Pop ${_STRING}
	Pop ${_ERR}
!macroend


!define stack::dll_write `!insertmacro stack::dll_write`

!macro stack::dll_write _HANDLE _STRING _INDEX _ERR
	stack::_dll_write /NOUNLOAD `${_HANDLE}` `${_STRING}` `${_INDEX}`
	Pop ${_ERR}
!macroend


!define stack::dll_move `!insertmacro stack::dll_move`

!macro stack::dll_move _HANDLE _INDEX _INDEX2 _ERR
	stack::_dll_move /NOUNLOAD `${_HANDLE}` `${_INDEX}` `${_INDEX2}`
	Pop ${_ERR}
!macroend


!define stack::dll_exchange `!insertmacro stack::dll_exchange`

!macro stack::dll_exchange _HANDLE _INDEX _INDEX2 _ERR
	stack::_dll_exchange /NOUNLOAD `${_HANDLE}` `${_INDEX}` `${_INDEX2}`
	Pop ${_ERR}
!macroend


!define stack::dll_delete_range `!insertmacro stack::dll_delete_range`

!macro stack::dll_delete_range _HANDLE _INDEX _INDEX2 _ERR
	stack::_dll_delete_range /NOUNLOAD `${_HANDLE}` `${_INDEX}` `${_INDEX2}`
	Pop ${_ERR}
!macroend


!define stack::dll_move_range `!insertmacro stack::dll_move_range`

!macro stack::dll_move_range _HANDLE _INDEX _INDEX2 _INDEX3 _ERR
	stack::_dll_move_range /NOUNLOAD `${_HANDLE}` `${_INDEX}` `${_INDEX2}` `${_INDEX3}`
	Pop ${_ERR}
!macroend


!define stack::dll_reverse_range `!insertmacro stack::dll_reverse_range`

!macro stack::dll_reverse_range _HANDLE _INDEX _INDEX2 _ERR
	stack::_dll_reverse_range /NOUNLOAD `${_HANDLE}` `${_INDEX}` `${_INDEX2}`
	Pop ${_ERR}
!macroend


!define stack::dll_push_sort `!insertmacro stack::dll_push_sort`

!macro stack::dll_push_sort _HANDLE _STRING _ORDER
	stack::_dll_push_sort /NOUNLOAD `${_HANDLE}` `${_STRING}` `${_ORDER}`
!macroend


!define stack::dll_push_sort_int `!insertmacro stack::dll_push_sort_int`

!macro stack::dll_push_sort_int _HANDLE _STRING _ORDER
	stack::_dll_push_sort_int /NOUNLOAD `${_HANDLE}` `${_STRING}` `${_ORDER}`
!macroend


!define stack::dll_sort_all `!insertmacro stack::dll_sort_all`

!macro stack::dll_sort_all _HANDLE _ORDER
	stack::_dll_sort_all /NOUNLOAD `${_HANDLE}` `${_ORDER}`
!macroend


!define stack::dll_sort_all_int `!insertmacro stack::dll_sort_all_int`

!macro stack::dll_sort_all_int _HANDLE _ORDER
	stack::_dll_sort_all_int /NOUNLOAD `${_HANDLE}` `${_ORDER}`
!macroend


!define stack::dll_size `!insertmacro stack::dll_size`

!macro stack::dll_size _HANDLE _ERR
	stack::_dll_size /NOUNLOAD `${_HANDLE}`
	Pop ${_ERR}
!macroend


!define stack::dll_clear `!insertmacro stack::dll_clear`

!macro stack::dll_clear _HANDLE
	stack::_dll_clear /NOUNLOAD `${_HANDLE}`
!macroend


!define stack::dll_destroy `!insertmacro stack::dll_destroy`

!macro stack::dll_destroy _HANDLE
	stack::_dll_destroy /NOUNLOAD `${_HANDLE}`
!macroend


!define stack::Debug `!insertmacro stack::Debug`

!macro stack::Debug _HANDLE
	stack::_Debug /NOUNLOAD `${_HANDLE}`
!macroend


!define stack::Unload `!insertmacro stack::Unload`

!macro stack::Unload
	stack::_Unload
!macroend
