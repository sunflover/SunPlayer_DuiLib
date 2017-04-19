**********************************************************************
***               Stack functions NSIS plugin v1.6                 ***
**********************************************************************

2006 Shengalts Aleksander aka Instructor (Shengalts@mail.ru)


Features:
- Manupulate NSIS stack
- Create and manipulate private stacks
- Debug NSIS and private stacks


###### Functions for working with NSIS stack ######

**** ns_push_front ****

Adds an element to the top of the NSIS stack (same as Push "string")

${stack::ns_push_front} "string"


**** ns_pop_front ****

Removes the element from the top of the NSIS stack and
puts it in the variable (same as Pop $0)

${stack::ns_pop_front} $var1 $var2

$var1    Output
$var2    0 on success
         1 on empty stack


**** ns_push_back ****

Adds an element to the beginning of the NSIS stack.

${stack::ns_push_back} "string"


**** ns_read ****

Finds the NSIS element by index and puts it in the variable.

${stack::ns_read} "index" $var1 $var2

"index"  Number of the element (only positive)
$var1    Output
$var2    0 on success
         1 on empty stack


**** ns_write ****

Finds the NSIS element by index and rewrite it.

${stack::ns_write} "string" index $var

"string" Text to write
"index"  Number of the element (only positive)
$var     0 on success
         1 on empty stack


**** ns_size ****

Gets the number of elements in the NSIS stack.

${stack::ns_size} $var

$var   The number of elements


**** ns_clear ****

Clears all NSIS stack

${stack::ns_clear}



###### Functions for working with private stack (NSIS stack independent) ######

**** dll_create ****

Create private stack.

${stack::dll_create} $var

$var     Handle of the stack, zero if failed


**** dll_insert ****

Finds the private element by index and
inserts new element in it index.

${stack::dll_insert} "handle" "string" "index" $var

"handle" Stack handle
"string" Text to insert
"index"  Number of the element if positive search
         from top if negative from beginning
$var     0 on success
         1 on empty stack


**** dll_delete ****

Finds the private element by index, puts it in
the variable and removes it.

${stack::dll_delete} "handle" "index" $var1 $var2

"handle" Stack handle
"index"  Number of the element if positive search
         from top if negative from beginning
$var1    Output
$var2    0 on success
         1 on empty stack


**** dll_read ****

Finds the private element by index and puts it in the variable.

${stack::dll_read} "handle" "index" $var1 $var2

"handle" Stack handle
"index"  Number of the element if positive search
         from top if negative from beginning
$var1    Output
$var2    0 on success
         1 on empty stack


**** dll_write ****

Finds the private element by index and rewrite it.

${stack::dll_write} "handle" "string" "index" $var

"handle" Stack handle
"string" Text to write
"index"  Number of the element if positive search
         from top if negative from beginning
$var     0 on success
         1 on empty stack


**** dll_move ****

Finds the private element by index and move it to the new index.

${stack::dll_move} "handle" "index" "index2" $var

"handle" Stack handle
"index"  Number of the element if positive search
         from top if negative from beginning (source)
"index2" Number of the element if positive search
         from top if negative from beginning (destination)
$var     0 on success
         1 on empty stack
         2 source and destination indexes pointed to the same element


**** dll_exchange ****

Finds the private elements by indexes and exchanges them.

${stack::dll_exchange} "handle" "index" "index2" $var

"handle" Stack handle
"index"  Number of the element if positive search
         from top if negative from beginning
"index2" Number of the element if positive search
         from top if negative from beginning
$var     0 on success
         1 on empty stack
         2 indexes pointed to the same element


**** dll_delete_range ****

Finds the private elements between indexes and removes.

${stack::dll_delete_range} "handle" "index" "index2" $var

"handle" Stack handle
"index"  Number of the element if positive search
         from top if negative from beginning (range limit)
"index2" Number of the element if positive search
         from top if negative from beginning (range limit)
$var     0 on success
         1 on empty stack


**** dll_move_range ****

Finds the private elements by indexes and move them to the new index.

${stack::dll_move_range} "handle" "index" "index2" "index3" $var

"handle" Stack handle
"index"  Number of the element if positive search
         from top if negative from beginning (range limit)
"index2" Number of the element if positive search
         from top if negative from beginning (range limit)
"index3" Number of the element if positive search
         from top if negative from beginning (destination)
$var     0 on success
         1 on empty stack
         2 destination index pointed to the element in the range


**** dll_reverse_range ****

Reverse range of private elements.

${stack::dll_reverse_range} "handle" "index" "index2" $var

"handle" Stack handle
"index"  Number of the element if positive search
         from top if negative from beginning (range limit)
"index2" Number of the element if positive search
         from top if negative from beginning (range limit)
$var     0 on success
         1 on empty stack
         2 indexes pointed to the same element


**** dll_push_sort ****

Pushs the private element and sorts alphabetically in ascending or descending.

${stack::dll_push_sort} "handle" "string" "order"

"handle" Stack handle
"string" Text to be pushed and sorted
"order" -1 sorts in descending
         1 sorts in ascending


**** dll_push_sort_int ****

Pushs the private element and sorts numerically in ascending or descending.

${stack::dll_push_sort_int} "handle" "string" "order"

"handle" Stack handle
"string" Text to be pushed and sorted
"order" -1 sorts in descending
         1 sorts in ascending


**** dll_sort_all ****

Sorts private stack alphabetically in ascending or descending.

${stack::dll_sort_all} "handle" "order"

"handle" Stack handle
"order" -1 sorts in descending
         1 sorts in ascending


**** dll_sort_all_int ****

Sorts private stack numerically in ascending or descending.

${stack::dll_sort_all_int} "handle" "order"

"handle" Stack handle
"order" -1 sorts in descending
         1 sorts in ascending


**** dll_size ****

Gets the number of elements in the private stack.

${stack::dll_size} "handle" $var

"handle" Stack handle
$var     The number of elements


**** dll_clear ****

Clears all private stack

${stack::dll_clear} "handle"

"handle" Stack handle


**** dll_destroy ****

Destroy private stack.

${stack::dll_destroy} "handle"

"handle" Stack handle


###### Other functions ######

**** Debug ****

Debug dialog

${stack::Debug} "handle"

"handle" Private stack handle. If private stack debug
         don't needed, set it to zero


**** Unload ****

Unload plugin

${stack::Unload}
