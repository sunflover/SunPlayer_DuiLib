#####################################################
# NSISArray.nsh by Afrow UK
# Array script header for NSISArray plugin by Afrow UK
# For usage, see Docs\NSISArray\Readme.html
#
# Script header v1.5
# Only for use with the same plugin version.
#
# Last modified: 7th June 2007
#
#

!ifndef NSISArray
!define NSISArray

!macro Array Name Indexes BufferLen

 !ifndef Array_ScriptHeaderInited

  !ifdef ArrayCallInstDLL
   !define ArrayPluginDLL `${ArrayCallInstDLL}`
  !else ifndef ArrayPluginDLL
   !define ArrayPluginDLL `NSISArray`
  !endif

  !ifndef ArrayValVar
   Var ArrayVal
   !define ArrayValVar $ArrayVal
  !endif

  !ifndef ArrayErrVar
   Var ArrayErr
   !define ArrayErrVar $ArrayErr
  !endif

 !define Array_ScriptHeaderInited
 !endif

 !ifndef `Array_${Name}_Declared`

 !ifdef Array_Obj
  !undef Array_Obj
 !endif
 !define Array_Obj `->`

 !ifdef ArrayObj
  !undef ArrayObj
 !endif
 !define ArrayObj `!insertmacro ArrayObj`

 !ifdef Array_Name
  !undef Array_Name
 !endif
 !define Array_Name "${Name}"

 !ifdef Array_Indexes
  !undef Array_Indexes
 !endif
 !define Array_Indexes "${Indexes}"

 !ifdef Array_BufferLen
  !undef Array_BufferLen
 !endif
 !define Array_BufferLen "${BufferLen}"

 !define `Array_${Name}_Declared`
 !else
  !error "NSISArray: You cannot declare more than one array with the same name."
 !endif
!macroend
!define Array `!insertmacro Array`

!macro ArrayObj Obj
 !ifdef Array_Obj
  !undef Array_Obj
 !endif
 !define Array_Obj `${Obj}`
!macroend

!macro Array_ObjErr Null
 !error "NSISArray: You can only set the array object style once."
!macroend

!macro ArrayFunc Func

 !define `Func_${Func}`
 !ifdef Func_Inited \
      | Func_Print \
      | Func_Write \
      | Func_WriteList \
      | Func_WriteListC \
      | Func_Put \
      | Func_Read \
      | Func_ReadToStack \
      | Func_Cut \
      | Func_Push \
      | Func_Pop \
      | Func_Shift \
      | Func_Unshift \
      | Func_Reverse \
      | Func_Sort \
      | Func_Clear \
      | Func_Splice \
      | Func_Swap \
      | Func_Copy \
      | Func_Join \
      | Func_Concat \
      | Func_Subtract \
      | Func_Exists \
      | Func_ExistsI \
      | Func_Search \
      | Func_SearchI \
      | Func_SizeOf \
      | Func_ReadFirst \
      | Func_ReadNext \
      | Func_ReadClose \
      | Func_Debug \
      | Func_SetSize \
      | Func_ReDim \
      | Func_FreeUnusedMem \
      | Func_SetAutoReDim

  !ifndef Array_Name
   !error "NSISArray: Please declare an array before declaring functions."
  !else

   !ifndef `Array_FuncDefined_${Array_Name}${Func}`
    !define `Array_FuncDefined_${Array_Name}${Func}`
   !else
    !error "NSISArray: You cannot declare a function more than once."
   !endif

   !ifdef ArrayObj
    !undef ArrayObj
   !endif
   !define ArrayObj `!insertmacro Array_ObjErr`

   !ifndef "${Array_Name}${Array_Obj}Init"
    !define "${Array_Name}${Array_Obj}Init" `!insertmacro Array_Init "${Array_Name}" "${Array_Indexes}" "${Array_BufferLen}"`
   !endif
   !ifndef "${Array_Name}${Array_Obj}Delete"
    !define "${Array_Name}${Array_Obj}Delete" `!insertmacro Array_Delete "${Array_Name}"`
   !endif

   !ifdef ArrayCallInstDLL
    !ifdef Func_WriteList
     !define "${Array_Name}${Array_Obj}WriteListBegin" `!insertmacro Array_WriteListBegin `
     !define "${Array_Name}${Array_Obj}WriteListItem"  `!insertmacro Array_WriteListItem`
     !define "${Array_Name}${Array_Obj}WriteListEnd"   `!insertmacro Array_WriteListEnd "${Array_Name}"`
    !else \
     ifdef Func_Splice
     !define "${Array_Name}${Array_Obj}SpliceBegin" `!insertmacro Array_SpliceBegin `
     !define "${Array_Name}${Array_Obj}SpliceItem"  `!insertmacro Array_SpliceItem`
     !define "${Array_Name}${Array_Obj}SpliceEnd"   `!insertmacro Array_SpliceEnd "${Array_Name}"`
    !else
     !define "${Array_Name}${Array_Obj}${Func}" `!insertmacro Array_${Func} "${Array_Name}"`
    !endif
   !else
    !define "${Array_Name}${Array_Obj}${Func}" `!insertmacro Array_${Func} "${Array_Name}"`
   !endif

  !endif

 !else \
  ifdef Func_Init \
      | Func_Delete
  !error "NSISArray: You do not need to declare the Init and Delete functions."
 !else
  !error "NSISArray: An invalid function name has been declared."
 !endif
 !undef `Func_${Func}`

!macroend
!define ArrayFunc `!insertmacro ArrayFunc`

!macro Array_ErrorStyle ErrorStyle
 !define `ErrorStyle_${ErrorStyle}`
 !ifdef ErrorStyle_logwin
  !define ErrorStyleNum 5
 !else ifdef ErrorStyle_msgbox
  !define ErrorStyleNum 3
 !else
  !define ErrorStyleNum 1
 !endif
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::ErrorStyle /NOUNLOAD "${ErrorStyleNum}"
 !else
  Push "${ErrorStyleNum}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD ErrorStyle
 !endif
 !undef ErrorStyleNum
 !undef `ErrorStyle_${ErrorStyle}`
!macroend
!define ArrayErrorStyle `!insertmacro Array_ErrorStyle`

!macro Array_PopErrVar
 Pop "${ArrayErrVar}"
 !ifdef ArraySetErrors
  StrCmp "${ArrayErrVar}" 0 +2
  SetErrors
 !endif
!macroend
!define Array_PopErrVar `!insertmacro Array_PopErrVar`

!macro Array_Init Name Indexes BufferLen
 !if ${Indexes} < 1
  !error "NSISArray: The minimum index count is 1."
 !else if ${BufferLen} < 2
  !error "NSISArray: The minimum buffer length is 2."
 !endif
 !ifndef `Array_${Name}_Inited`
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::ErrorStyle /NOUNLOAD ""
  Pop "${ArrayErrVar}"
  StrCmp "${ArrayErrVar}" 3 +3
  StrCmp "${ArrayErrVar}" 5 +2
  ${ArrayPluginDLL}::ErrorStyle /NOUNLOAD "1"
 !else
  Push ""
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD ErrorStyle
  Pop "${ArrayErrVar}"
  StrCmp "${ArrayErrVar}" 3 +4
  StrCmp "${ArrayErrVar}" 5 +3
  Push "1"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD ErrorStyle
 !endif
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::New /NOUNLOAD "${Name}" "${Indexes}" "${BufferLen}"
 !else
  Push "${BufferLen}"
  Push "${Indexes}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD New
 !endif
 ${Array_PopErrVar}
 !define `Array_${Name}_Inited`
 !else
  !error "NSISArray: An array can only be initialised once."
 !endif
!macroend

!macro Array_Delete Name
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Delete /NOUNLOAD "${Name}"
 ${Array_PopErrVar}
  ${ArrayPluginDLL}::ArrayCount /NOUNLOAD
   Pop "${ArrayValVar}"
  StrCmp "${ArrayValVar}" 0 0 +2
  ${ArrayPluginDLL}::Unload
 !else
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Delete
 ${Array_PopErrVar}
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD ArrayCount
   Pop "${ArrayValVar}"
  StrCmp "${ArrayValVar}" 0 0 +2
  CallInstDLL `${ArrayPluginDLL}` Unload
 !endif
!macroend

!macro Array_ReDim Name Size Indexes BufferLen
 !if ${Indexes} < 1
  !error "NSISArray: The minimum index count is 1."
 !else if ${BufferLen} < 2
  !error "NSISArray: The minimum buffer length is 2."
 !endif
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::ReDim /NOUNLOAD "${Name}" "${Indexes}" "${BufferLen}"
 !else
  Push "${BufferLen}"
  Push "${Indexes}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD ReDim
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_FreeUnusedMem Name
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::FreeUnusedMem /NOUNLOAD "${Name}"
 !else
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD FreeUnusedMem
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_SetAutoReDim Name Items Buffer
 !if ${Items} < 8
  !error "NSISArray: You must add at least 8 index reallocation."
 !else if ${Buffer} < 8
  !error "NSISArray: You must add at least 8 bytes for buffer reallocation."
 !endif
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::SetAutoReDim /NOUNLOAD "${Name}" "${Items}" "${StrLen}"
 !else
  Push "${Buffer}"
  Push "${Items}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD SetAutoReDim
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_Inited Name JumpInited JumpNotInited
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::ArrayExists /NOUNLOAD "${Name}"
 !else
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD ArrayExists
 !endif
 ${Array_PopErrVar}
  Pop "${ArrayValVar}"
 StrCmp "${ArrayValVar}" 1 "${JumpInited}" "${JumpNotInited}"
!macroend

!macro Array_Write Name Index Value
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Write /NOUNLOAD "${Name}" "${Index}" "${Value}"
 !else
  Push "${Value}"
  Push "${Index}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Write
 !endif
 ${Array_PopErrVar}
!macroend

!ifndef ArrayCallInstDLL
!macro Array_WriteList Name List
  ${ArrayPluginDLL}::WriteList /NOUNLOAD "${Name}" ${List} "/END"
 ${Array_PopErrVar}
!macroend
!else
!macro Array_WriteListBegin
  Push "/END"
!macroend
!macro Array_WriteListItem Item
  Push `${Item}`
!macroend
!macro Array_WriteListEnd Name
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD WriteList
 ${Array_PopErrVar}
!macroend
!endif

!macro Array_WriteListC Name List Char
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::WriteListC /NOUNLOAD "${Name}" "${List}" "${Char}"
 !else
  Push "${Char}"
  Push "${List}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD WriteListC
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_Put Name Index Value
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Put /NOUNLOAD "${Name}" "${Index}" "${Value}"
 !else
  Push "${Value}"
  Push "${Index}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Put
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_Read Name Var Index
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Read /NOUNLOAD "${Name}" "${Index}"
 !else
  Push "${Index}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Read
 !endif
 ${Array_PopErrVar}
  Pop "${Var}"
!macroend

!macro Array_ReadToStack Name IndexA IndexB
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::ReadToStack /NOUNLOAD "${Name}" "${IndexA}" "${IndexB}"
 !else
  Push "${IndexB}"
  Push "${IndexA}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD ReadToStack
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_Cut Name Var Index
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Cut /NOUNLOAD "${Name}" "${Index}"
 !else
  Push "${Index}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Cut
 !endif
 ${Array_PopErrVar}
  Pop "${Var}"
!macroend

!macro Array_Push Name Value
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Push /NOUNLOAD "${Name}" "${Value}"
 !else
  Push "${Value}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Push
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_Pop Name Var
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Pop /NOUNLOAD "${Name}"
 !else
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Pop
 !endif
 ${Array_PopErrVar}
  Pop "${Var}"
!macroend

!macro Array_Shift Name Value
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Shift /NOUNLOAD "${Name}" "${Value}"
 !else
  Push "${Value}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Shift
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_Unshift Name Var
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Unshift /NOUNLOAD "${Name}"
 !else
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Unshift
 !endif
 ${Array_PopErrVar}
  Pop "${Var}"
!macroend

!macro Array_Reverse Name
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Reverse /NOUNLOAD "${Name}"
 !else
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Reverse
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_Sort NameA NameB
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Sort /NOUNLOAD "${NameA}" "${NameB}"
 !else
  Push "${NameB}"
  Push "${NameA}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Sort
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_Clear Name
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Clear /NOUNLOAD "${Name}"
 !else
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Clear
 !endif
 ${Array_PopErrVar}
!macroend

!ifndef ArrayCallInstDLL
!macro Array_Splice Name IndexA IndexB List
 ${ArrayPluginDLL}::Splice /NOUNLOAD "${Name}" "${IndexA}" "${IndexB}" ${List} "/END"
 ${Array_PopErrVar}
!macroend
!else
!macro Array_SpliceBegin IndexA IndexB
 !define Array_Splice_IndexA `${IndexA}`
 !define Array_Splice_IndexB `${IndexB}`
  Push "/END"
!macroend
!macro Array_SpliceItem Item
  Push `${Item}`
!macroend
!macro Array_SpliceEnd Name
  Push "${Array_Splice_IndexB}"
  Push "${Array_Splice_IndexA}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Splice
 ${Array_PopErrVar}
  !undef Array_Splice_IndexB
  !undef Array_Splice_IndexA
!macroend
!endif

!macro Array_Swap Name IndexA IndexB
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Swap /NOUNLOAD "${Name}" "${IndexA}" "${IndexB}"
 !else
  Push "${IndexB}"
  Push "${IndexA}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Swap
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_Copy Name ToArray
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Copy /NOUNLOAD "${Name}" "${ToArray}"
 !else
  Push "${ToArray}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Copy
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_Join Name ToArray
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Join /NOUNLOAD "${Name}" "${ToArray}"
 !else
  Push "${ToArray}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Join
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_Concat Name Var Chars
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Concat /NOUNLOAD "${Name}" "${Chars}"
 !else
  Push "${Chars}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Concat
 !endif
 ${Array_PopErrVar}
  Pop "${Var}"
!macroend

!macro Array_Exists Name Var Value Index
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Exists /NOUNLOAD "${Name}" "${Value}" "${Index}"
 !else
  Push "${Index}"
  Push "${Value}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Exists
 !endif
 ${Array_PopErrVar}
  Pop "${Var}"
!macroend

!macro Array_ExistsI Name Var Value Index
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::ExistsI /NOUNLOAD "${Name}" "${Value}" "${Index}"
 !else
  Push "${Index}"
  Push "${Value}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD ExistsI
 !endif
 ${Array_PopErrVar}
  Pop "${Var}"
!macroend

!macro Array_Search Name Var Value Index
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Search /NOUNLOAD "${Name}" "${Value}" "${Index}"
 !else
  Push "${Index}"
  Push "${Value}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Search
 !endif
 ${Array_PopErrVar}
  Pop "${Var}"
!macroend

!macro Array_SearchI Name Var Value Index
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::SearchI /NOUNLOAD "${Name}" "${Value}" "${Index}"
 !else
  Push "${Index}"
  Push "${Value}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD SearchI
 !endif
 ${Array_PopErrVar}
  Pop "${Var}"
!macroend

!macro Array_SizeOf Name VarBufferLen VarItems VarIndexes
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::SizeOf /NOUNLOAD "${Name}"
 !else
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD SizeOf
 !endif
 ${Array_PopErrVar}
  Pop "${VarBufferLen}"
  Pop "${VarItems}"
  Pop "${VarIndexes}"
!macroend

!macro Array_Debug Name
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Debug /NOUNLOAD "${Name}"
 !else
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Debug
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_SetSize Name Items
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::SetSize /NOUNLOAD "${Name}" "${Items}"
 !else
  Push "${Items}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD SetSize
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_ReadFirst Name Handle Var
 !define Local ${__LINE__}
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::SizeOf /NOUNLOAD "${Name}"
 !else
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD SizeOf
 !endif
 ${Array_PopErrVar}
  Pop "${Var}"
  Pop "${Var}"
  Pop "${Var}"
  StrCmp "${Var}" 0 0 +4
   StrCpy "${Var}" ""
   SetErrors
   Goto Done_${Local}
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Read /NOUNLOAD "${Name}" "0"
 !else
  Push "0"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Read
 !endif
 ${Array_PopErrVar}
  Pop "${Var}"
  StrCpy "${Handle}" 1
 Done_${Local}:
 !undef Local
!macroend

!macro Array_ReadNext Name Handle Var
 !define Local ${__LINE__}
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::SizeOf /NOUNLOAD "${Name}"
 !else
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD SizeOf
 !endif
 ${Array_PopErrVar}
  Pop "${Var}"
  Pop "${Var}"
  Pop "${Var}"
  StrCmp "${Var}" "${Handle}" 0 +4
   StrCpy "${Var}" ""
   SetErrors
   Goto Done_${Local}
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Read /NOUNLOAD "${Name}" "${Handle}"
 !else
  Push "${Handle}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Read
 !endif
 ${Array_PopErrVar}
  Pop "${Var}"
  IntOp "${Handle}" "${Handle}" + 1
 Done_${Local}:
 !undef Local
!macroend

!macro Array_ReadClose Name Handle
 StrCpy "${Handle}" ""
!macroend

!macro Array_Subtract Name FromArray
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Subtract /NOUNLOAD "${Name}" "${FromArray}"
 !else
  Push "${FromArray}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Subtract
 !endif
 ${Array_PopErrVar}
!macroend

!macro Array_Print Name Index
 !ifndef ArrayCallInstDLL
  ${ArrayPluginDLL}::Read /NOUNLOAD "${Name}" "${Index}"
 !else
  Push "${Index}"
  Push "${Name}"
  CallInstDLL `${ArrayPluginDLL}` /NOUNLOAD Read
 !endif
 ${Array_PopErrVar}
  Pop "${ArrayValVar}"
  DetailPrint "${ArrayValVar}"
!macroend

!endif