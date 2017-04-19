;-----------------------------------------------------------------------------------
;  NSISList Plugin - a simple List plugin for NSIS
;  Written by LoRd_MuldeR <mulder2@gmx.de>
;-----------------------------------------------------------------------------------

!ifndef _NSISList.Include
!define _NSISList.Include

;-----------------------------------------------------------------------------------
; Definition of NSISList instructions
;-----------------------------------------------------------------------------------

!define List.Add "!insertmacro _NSISList.Add"
!define List.All "!insertmacro _NSISList.All"
!define List.AllRev "!insertmacro _NSISList.AllRev"
!define List.Append "!insertmacro _NSISList.Append"
!define List.Clear "!insertmacro _NSISList.Clear"
!define List.Concat "!insertmacro _NSISList.Concat"
!define List.Copy "!insertmacro _NSISList.Copy"
!define List.Count "!insertmacro _NSISList.Count"
!define List.Create "!insertmacro _NSISList.Create"
!define List.Debug "!insertmacro _NSISList.Debug"
!define List.Delete "!insertmacro _NSISList.Delete"
!define List.Destroy "!insertmacro _NSISList.Destroy"
!define List.Dim "!insertmacro _NSISList.Dim"
!define List.Exch "!insertmacro _NSISList.Exch"
!define List.First "!insertmacro _NSISList.First"
!define List.Get "!insertmacro _NSISList.Get"
!define List.Index "!insertmacro _NSISList.Index"
!define List.Insert "!insertmacro _NSISList.Insert"
!define List.Last "!insertmacro _NSISList.Last"
!define List.Load "!insertmacro _NSISList.Load"
!define List.Move "!insertmacro _NSISList.Move"
!define List.Pop "!insertmacro _NSISList.Pop"
!define List.Reverse "!insertmacro _NSISList.Reverse"
!define List.Save "!insertmacro _NSISList.Save"
!define List.Set "!insertmacro _NSISList.Set"
!define List.Sort "!insertmacro _NSISList.Sort"
!define List.Unload "!insertmacro _NSISList.Unload"

;-----------------------------------------------------------------------------------
; Definition of Map instructions
;-----------------------------------------------------------------------------------

!define Map.Clear "!insertmacro _NSISList.Map.Clear"
!define Map.Create "!insertmacro _NSISList.Map.Create"
!define Map.Destroy "!insertmacro _NSISList.Map.Destroy"
!define Map.Get "!insertmacro _NSISList.Map.Get"
!define Map.Set "!insertmacro _NSISList.Map.Set"
!define Map.Unset "!insertmacro _NSISList.Map.Unset"

;-----------------------------------------------------------------------------------
; Macros to call NSISList instructions
;-----------------------------------------------------------------------------------

!macro _NSISList.Add name value
  NSISList::Add /NOUNLOAD '${name}' '${value}'
!macroend

!macro _NSISList.All name
  NSISList::All /NOUNLOAD '${name}'
!macroend

!macro _NSISList.AllRev name
  NSISList::AllRev /NOUNLOAD '${name}'
!macroend

!macro _NSISList.Append name strings
  NSISList::Append /NOUNLOAD '${name}' '${strings}'
!macroend

!macro _NSISList.Clear name
  NSISList::Clear /NOUNLOAD '${name}'
!macroend

!macro _NSISList.Concat name_to name_from
  NSISList::Concat /NOUNLOAD '${name_to}' '${name_from}'
!macroend

!macro _NSISList.Copy name index count
  NSISList::Copy /NOUNLOAD '${name}' '${index}' '${count}'
!macroend

!macro _NSISList.Count var_out name
  NSISList::Count /NOUNLOAD '${name}'
  Pop ${var_out}
!macroend

!macro _NSISList.Create name
  NSISList::Create /NOUNLOAD '${name}'
!macroend

!macro _NSISList.Debug
  NSISList::Debug /NOUNLOAD
!macroend

!macro _NSISList.Delete name index
  NSISList::Delete /NOUNLOAD '${name}' '${index}'
!macroend

!macro _NSISList.Destroy name
  NSISList::Destroy /NOUNLOAD '${name}'
!macroend

!macro _NSISList.Dim name size
  NSISList::Dim /NOUNLOAD '${name}' '${size}'
!macroend

!macro _NSISList.Exch name index1 index2
  NSISList::Exch /NOUNLOAD '${name}' '${index1}' '${index2}'
!macroend

!macro _NSISList.First var_out name
  NSISList::First /NOUNLOAD '${name}'
  Pop ${var_out}
!macroend

!macro _NSISList.Get var_out name index
  NSISList::Get /NOUNLOAD '${name}' '${index}'
  Pop ${var_out}
!macroend

!macro _NSISList.Index var_out name value
  NSISList::Index /NOUNLOAD '${name}' '${value}'
  Pop ${var_out}
!macroend

!macro _NSISList.Insert name index value
  NSISList::Insert /NOUNLOAD '${name}' '${index}' '${value}'
!macroend

!macro _NSISList.Last var_out name
  NSISList::Last /NOUNLOAD '${name}'
  Pop ${var_out}
!macroend

!macro _NSISList.Load var_out name filename
  NSISList::Load /NOUNLOAD '${name}' '${filename}'
  Pop ${var_out}
!macroend

!macro _NSISList.Move name index_from index_to
  NSISList::Move /NOUNLOAD '${name}' '${index_from}' '${index_to}'
!macroend

!macro _NSISList.Pop var_out name
  NSISList::Pop /NOUNLOAD '${name}'
  Pop ${var_out}
!macroend

!macro _NSISList.Reverse name
  NSISList::Reverse /NOUNLOAD '${name}'
!macroend

!macro _NSISList.Save var_out name filename
  NSISList::Save /NOUNLOAD '${name}' '${filename}'
  Pop ${var_out}
!macroend

!macro _NSISList.Set name index value
  NSISList::Set /NOUNLOAD '${name}' '${index}' '${value}'
!macroend

!macro _NSISList.Sort name
  NSISList::Sort /NOUNLOAD '${name}'
!macroend

!macro _NSISList.Unload
  NSISList::Unload
!macroend

;-----------------------------------------------------------------------------------
; Macros to implement Map support
;-----------------------------------------------------------------------------------

!macro _NSISList.Map.Clear name
  NSISList::Clear /NOUNLOAD '_Map.Keys::${name}'
  NSISList::Clear /NOUNLOAD '_Map.Data::${name}'
!macroend

!macro _NSISList.Map.Create name
  NSISList::Create /NOUNLOAD '_Map.Keys::${name}'
  NSISList::Create /NOUNLOAD '_Map.Data::${name}'
!macroend

!macro _NSISList.Map.Destroy name
  NSISList::Destroy /NOUNLOAD '_Map.Keys::${name}'
  NSISList::Destroy /NOUNLOAD '_Map.Data::${name}'
!macroend

!macro _NSISList.Map.Get var_out name key
  !ifndef _NSISList.TempVar
    !define _NSISList.TempVar
    Var /GLOBAL _NSISList.Temp
  !endif
  StrCpy ${var_out} "__NULL"
  NSISList::Index /NOUNLOAD '_Map.Keys::${name}' '${key}'
  Pop $_NSISList.Temp
  StrCmp $_NSISList.Temp "__ERROR" +4
  StrCmp $_NSISList.Temp -1 +3
  NSISList::Get /NOUNLOAD '_Map.Data::${name}' $_NSISList.Temp
  Pop ${var_out}
!macroend

!macro _NSISList.Map.Set name key value
  !ifndef _NSISList.TempVar
    !define _NSISList.TempVar
    Var /GLOBAL _NSISList.Temp
  !endif
  NSISList::Index /NOUNLOAD '_Map.Keys::${name}' '${key}'
  Pop $_NSISList.Temp
  StrCmp $_NSISList.Temp "__ERROR" +6
  StrCmp $_NSISList.Temp -1 0 +4
  NSISList::Add /NOUNLOAD '_Map.Keys::${name}' '${key}'
  NSISList::Add /NOUNLOAD '_Map.Data::${name}' '${value}'
  Goto +2
  NSISList::Set /NOUNLOAD '_Map.Data::${name}' $_NSISList.Temp '${value}'
!macroend

!macro _NSISList.Map.Unset name key
  !ifndef _NSISList.TempVar
    !define _NSISList.TempVar
    Var /GLOBAL _NSISList.Temp
  !endif
  NSISList::Index /NOUNLOAD '_Map.Keys::${name}' '${key}'
  Pop $_NSISList.Temp
  StrCmp $_NSISList.Temp "__ERROR" +4
  StrCmp $_NSISList.Temp -1 +3
  NSISList::Delete /NOUNLOAD '_Map.Keys::${name}' $_NSISList.Temp
  NSISList::Delete /NOUNLOAD '_Map.Data::${name}' $_NSISList.Temp
!macroend

;-----------------------------------------------------------------------------------
; End of file
;-----------------------------------------------------------------------------------

!endif
