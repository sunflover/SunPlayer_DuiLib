NSISList Plugin - a simple List plugin for NSIS
Written by LoRd_MuldeR <mulder2@gmx.de>


1. Introduction
---------------

A list (also known as "dynamic array") can contain an arbitrary number of items and it grows dynamically.
Each list is identified by a unique name, so you can handle multiple lists at the same time.
Nevertheless there is a default list identified by "", which can be used if you only need one list at a time.
You can create a new named list using the "Create" instruction. Initially your list will be empty.
Once you have created a list, you can append as many items to as you need by calling the "Add" instruction.
Instead of multiple calls to "Add", you can add several items at once by calling the "Append" instruction.
Alternatively you can insert items at a specified index by calling the "Insert" instruction.
Items at a specified index can be read or overwritten by calling the "Get" or "Set" instructions.
You can also get the first or the last item of your list by calling the "First" or "Last" instructions.
In case you need to obtain ALL items of your list at once, you can call the "All" or "AllRev" instructions.
You can also use the "Copy" instruction to specified number of items, starting at a specified position.
The number of items in your list can be calculated by calling the "Count" instruction.
If you need to find a specified item in your list, you can call "Index" in order to obtain it's current index.
Furthermore you can move an item within your list by calling the "Move" instruction.
Additionally you can exchange two specified items in your list by calling the "Exch" instruction.
Calling the "Sort" instruction will sort all items in your list in alphabetical order.
If you need to remove a specified item from your list, you can call the "Delete" instruction.
You can also call "Pop" in order to obtain the last item of your list and remove that item simultaneously.
The "Clear" instruction will remove ALL items from your list, but the list itself will survive.
You can also append an entire list to another list, by calling the "Concat" instruction.
If you need your list to have a specified size, you can call the "Dim" instruction to chop/expand your list.
Once you are done working with your list, call "Destroy" in order to free all memory used by that list.
Last but not least you can load or save your list from/to a plain text file by calling "Load" or "Save".
The "Debug" instruction is intended for developers, it will display all existing lists and all of their items.

In addition to lists, the NSISList plugin provides support for maps (also knwon as "associative arrays").
Unlike a list, the items stored in a map do NOT have a specified order and are NOT accessed via indices.
Instead a map contains a number of keys and each key can be associated with an item of your choice.
You can create a new named map using the "Map.Create" instruction. Initially your map will be empty.
In order to add a new key to your map and associate it with an item, you can call the "Map.Set" instruction.
The very same instruction can be called to associate an existing key with a new item.
You can abotain the item associated with a given key (existing or not) by calling the "Map.Get" instruction.
It's also possible to remove a key and it's associated item by calling the "Map.Unset" instruction.
Last but not least you can remove all keys/items from your map by calling the "Map.Clear" instruction.
Once you are done working with your map, call "Map.Destroy" in order to free all memory used by that map.
Internally a map is implemented as two related lists: one for the keys, one for the items.


2. General Usage
----------------

If you want to use NSISList, the header file "NSISList.nsh" must be located in your "NSIS\Includes" folder.
Furthermore the plugin file "NSISList.dll" must be located in your "NSIS\Plugins" folder.
Please make sure that your "NSISList.nsh" and "NSISList.dll" files are at the same release version!

In order to enable NSISList in your installer, please put these lines on the top of your script:

  !include NSISList.nsh
  ReserveFile "${NSISDIR}\Plugins\NSISList.dll"

After you are done working with NSISList, call the ${List.Unload} macro in order to undload the plugin !!!
The ".onGUIEnd" callback-function might be a good place to do so...


3. Scripting Reference
----------------------

List.Add
  Usage: ${List.Add} <name> <item> 
  Info: This function will append the string <item> to the list identified by <name>
  Result: None
  Example: ${List.Add} MyList "Foobar"

List.All
  Usage: ${List.All} <name>
  Info: This function will push ALL items in the list identified by <name> onto the NSIS stack, in normal order
  Result: n strings on the stack, last string is followed by "__LAST", errors indidcated by "__ERROR"
  Example: ${List.All} MyList

List.AllRev
  Usage: ${List.AllRev} <name>
  Info: This function will push ALL items in the list identified by <name> onto the NSIS stack, in reverse order
  Result: n strings on the stack, last string is followed by "__LAST", errors are indidcated by "__ERROR"
  Example: ${List.AllRev} MyList

List.Append
  Usage: ${List.Append} <name> <strings>
  Info: This function will append several comma-separated items specified by <strings> to the list identified by <name>
  Result: None
  Example: ${List.Append} MyList "Item1,Item2,Item3,Item4"

List.Clear
  Usage: ${List.Clear} <name>
  Info: This function will erase ALL items in the list identified by <name>
  Result: None
  Example: ${List.Clear} MyList

List.Concat
  Usage: ${List.Concat} <key_to> <key_from>
  Info: This function will append all items in the list identified by <key_from> to the list identified by <key_to>
  Result: None
  Example: ${List.Concat} MyList OtherList

List.Copy
  Usage: ${List.Copy} <name> <index> <count>
  Info: This function will copy <count> items to the NSIS stack, starting at position <index> of the list specified by <name>
  Result: n strings on the stack, last string is followed by "__LAST", errors are indidcated by "__ERROR"
  Example: ${List.Copy} MyList 19 84

List.Count
  Usage: ${List.Count} <var_out> <name>
  Info: This function will calculate the number of items in the list identified by <name>
  Result: The number of items is returned in user var <var_out>, this can be zero, errors are indidcated by "__ERROR"
  Example: ${List.Count} $0 MyList

List.Create
  Usage: ${List.Create} <name>
  Info: This function will create a new named list, which will be identified by <name> for future access
  Result: None
  Example: ${List.Create} MyList

List.Debug
  Usage: ${List.Debug}
  Info: This function will display debug information for developers, all lists and all items will be displayed
  Result: None
  Example: ${List.Debug}

List.Delete
  Usage: ${List.Delete} <name> <index>
  Info: This function will remove the item at <index> from the list identified by <name>
  Result: None
  Example: ${List.Delete} MyList 42

List.Destroy
  Usage: ${List.Destroy} <name>
  Info: This function will destroy the list identified by <name>, all items will be removed, all memory will be released
  Result: None
  Example: ${List.Destroy} MyList

List.Dim
  Usage: ${List.Dim} <name> <size>
  Info: This function will expand or chop the list identified by <name> to a length of exactly <size> items, it will append "_NULL" items if necessary
  Result: None
  Example: ${List.Dim} MyList 100

List.Exch
  Usage: ${List.Exch} <name> <index1> <index2>
  Info: This function will exchange the item at <index1> with the item at <index2> in the list identified by <name>
  Result: None
  Example: ${List.Exch} MyList 19 84

List.First
  Usage: ${List.First} <var_out> <name>
  Info: This function obtains the FIRST item in the list identified by <name>
  Result: The item is returned in user var <var_out>, this can be "__EMPTY" if the list is empty, errors are indidcated by "__ERROR"
  Example: ${List.First} $0 MyList

List.Get
  Usage: ${List.Get} <var_out> <name> <index>
  Info: This function obtains the item at <index> from the list identified by <name>
  Result: The items is returned in user var <var_out>, errors are indidcated by "__ERROR"
  Example: ${List.Get} $0 MyList 42

List.Index
  Usage: ${List.Index} <var_out> <name> <item>
  Info: This function searches for the list identified by <name> for a string that equals <item>
  Result: The index of the first occurence of <item> is returned in user var <var_out>, this can be -1 if there is no such string, errors are indidcated by "__ERROR"
  Example: ${List.Index} $0 MyList "Foobar"

List.Insert
  Usage: ${List.Insert} <name> <index> <item>
  Info: This function will insert the string <item> at the position <index> into the list identified by <name>
  Result: None
  Example: ${List.Insert} MyList 42 "Foobar"

List.Last
  Usage: ${List.Last} <var_out> <name>
  Info: This function obtains the LAST item in the list identified by <name>
  Result: The item is returned in user var <var_out>, this can be "__EMPTY" if the list is empty, errors are indidcated by "__ERROR"
  Example: ${List.Last} $0 MyList

List.Load
  Usage: ${List.Load} <var_out> <name> <filename>
  Info: This function will load the list identified by <name> from a text file identified by <filename>, the old contents of the list will be lost
  Result: The result is returned in user var <var_out>, this can be either "__SUCCESS" or "__ERROR"
  Example: ${List.Load} $0 MyList "C:\List.txt"

List.Move
  Usage: ${List.Move} <name> <index_from> <index_to>
  Info: This function will move the item at <index_from> to the position <index_to> in the list identified by <name>
  Result: None
  Example: ${List.Move} MyList 19 84

List.Pop
  Usage: ${List.Pop} <var_out> <name>
  Info: This function will obtain the LAST item from the list identified by <name> and it will also REMOVE that item from the list
  Result: The result is returned in user var <var_out>, this can be "_EMPTY" if the list is empty, errors are indidcated by "__ERROR"
  Example: ${List.Pop} $0 MyList

List.Reverse
  Usage: ${List.Reverse} <name>
  Info: This function will reverse the order of all items in the list specified by <name>
  Result: None
  Example: ${List.Reverse} MyList

List.Save
  Usage: ${List.Save} <var_out> <name> <filename>
  Info: This function will save all items in the list identified by <name> to a plain text file identified by <filename>
  Result: The result is returned in user var <var_out>, this can be either "__SUCCESS" or "__ERROR"
  Example: ${List.Save} $0 MyList "C:\List.txt"

List.Set
  Usage: ${List.Set} <name> <index> <value>
  Info: This function will change the content of the item at <index> in the list identified by <name> to <value>
  Result: None
  Example: ${List.Set} MyList 42 "Foobar"

List.Sort
  Usage: ${List.Sort} <name>
  Info: This function will sort all items in the list identified by <name> alphabetically
  Result: None
  Example: ${List.Sort} MyList

List.Unload
  Usage: ${List.Unload}
  Info: This function will unload the NSISList plugin, destroy ALL lists including all of their items and release all memory used by NSISList
  Result: None
  Example: ${List.Undload}

Map.Clear
  Usage: ${Map.Clear} <name>
  Info: This function will erase ALL entries in the map identified by <name>
  Result: None
  Example: ${Map.Clear} MyMap

Map.Create
  Usage: ${Map.Create} <name>
  Info: This function will create a new named map, which will be identified by <name> for future access
  Result: None
  Example: ${Map.Create} MyMap

Map.Destroy
  Usage: ${Map.Destroy} <name>
  Info: This function will destroy the map identified by <name>, all entries will be removed, all memory will be released
  Result: None
  Example: ${Map.Destroy} MyMap

Map.Get
  Usage: ${Map.Get} <var_out> <name> <key>
  Info: This function will retrun the value associated with <key> in the map identified by <name>
  Result: The value is returned in user var <var_out>, this can be "__NULL" if no value was associated with <key> yet
  Example: ${Map.Get} $0 MyMap "Some Key"

Map.Set
  Usage: ${Map.Set} <name> <key> <value>
  Info: This function will associate <key> with <value> in the map identified by <name>
  Result: None
  Example: ${Map.Set} MyMap "Some Key" "Foobar"

Map.Unset
  Usage: ${Map.Unset} <name> <key>
  Info: This function will remove the value associated with <key> in the map identified by <name>
  Result: None
  Example: ${Map.Unset} MyMap "Some Key"


4. Examples
-----------

Here is a very simple example if NSISList usage:
  
  ;Required include to use NSISList
  !include NSISList.nsh

  ;Reserve the NSISList plugin
  ReserveFile "${NSISDIR}\Plugins\NSISList.dll"
 
  ;set name and output file
  Name "NSISList Example Installer"
  OutFile "NSISList_Example.exe"
 
  ;Show the log
  ShowInstDetails show
 
  Section
    ; Create a list named "MyList"
    ${List.Create} MyList
 
    ; Add "Jimmy Pop Ali" to the list identified by "MyList", this will become item #0
    ${List.Add} MyList "Jimmy Pop Ali"
 
    ; Add "Lüpüs Thünder" to the list identified by "MyList", this will become item #1
    ${List.Add} MyList "Lüpüs Thünder"
 
    ; Add "Evil Jared Hasselhoff" to the list identified by "MyList", this will become item #2
    ${List.Add} MyList "Evil Jared Hasselhoff"
 
    ; Calculate the number of items in the list identified by "MyList", $0 <- 3
    ${List.Count} $0 MyList
 
    ; Some output for the user
    DetailPrint "Count: $0"

    ; Get the item at index #1 from the list idedntified by "MyList", $0 <- "Lüpüs Thünder"
    ${List.Get} $0 MyList 1
 
    ; Some output for the user
    DetailPrint "Item at #1 is: $0"
 
    ; We are done here, so destroy the list identified by "MyList"
    ${List.Destroy} MyList
 
    ; Put some more important stuff here ;-)
    ; [...]
 
    ; Don't forget to unload the NSISList plugin at the end !!!!!
    ${List.Unload}
  SectionEnd

Please see "Examples\NSISList\NSISList_Test.nsi" for a more detailed example!


5. Version History
------------------

[2008-07-12]
* Initial release of the NSISList plugin

[2008-07-13]
* New: Added "Append" instruction, which allows to add several comma-separated items at once
* New: Added "Concat" instruction, which allows to append one list to anthor list
* New: Added "Copy" instruction, which allows to copy n items starting at a specified index
* New: Added "Dim" instruction, which allows to set the length of the list to a fixed size
* New: Added "Reverse" instruction, which allows reverse the order of all items in a list
* Fix: Catch exceptions globally, so unhandled exceptions can't cause a crash of the installer

[2008-07-16]
* New: Added Map support to NSISList (see Examples\NSISList\NSISList_Map.nsi for info)
* New: Added Lazarus source codes, not working yet
