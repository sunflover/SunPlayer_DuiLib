;-----------------------------------------------------------------------------------
; Complete test of NSISList Plugin
;-----------------------------------------------------------------------------------

!include NSISList.nsh
ReserveFile "${NSISDIR}\Plugins\NSISList.dll"

Name "NSISList_Test"
OutFile "NSISList_Test.exe"

ChangeUI all "${NSISDIR}\Contrib\UIs\modern.exe"
ShowInstDetails show

Section
  Push "STACK_TOP"  

  DetailPrint "Initialization"
  ${List.Create} MyTestList
  
  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Add a few items!"

  ${List.Add} MyTestList "Tree"
  ${List.Add} MyTestList "Apple"
  ${List.Add} MyTestList "Book"
  ${List.Add} MyTestList "Winamp"
  ${List.Add} MyTestList "Cat"
  ${List.Add} MyTestList "Dog"
  ${List.Add} MyTestList "Number"
  ${List.Add} MyTestList "House"
  
  ${List.Count} $0 MyTestList 
  DetailPrint "Count: $0"

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------
  
  ${List.First} $0 MyTestList 
  DetailPrint "First: $0"

  ${List.Last} $0 MyTestList
  DetailPrint "Last: $0"

  ${List.Get} $0 MyTestList 2
  DetailPrint "Item #2 is: $0"

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  ${List.All} MyTestList
  Loop1:
  Pop $0
  DetailPrint "All: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop1
  
  ${List.AllRev} MyTestList
  Loop1a:
  Pop $0
  DetailPrint "Reverse: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop1a

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  ${List.Index} $0 MyTestList "Cat"
  DetailPrint "Index of 'Cat' is #$0"

  ${List.Index} $0 MyTestList "Wallpaper"
  DetailPrint "Index of 'Wallpaper' is #$0"

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Sorting now!"
  ${List.Sort} MyTestList
  
  ${List.All} MyTestList
  Loop2:
  Pop $0
  DetailPrint "All: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop2

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Deleting item #5"
  ${List.Delete} MyTestList 5

  ${List.Count} $0 MyTestList
  DetailPrint "Count: $0"

  ${List.All} MyTestList
  Loop3:
  Pop $0
  DetailPrint "All: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop3

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Inserting 'Computer' at #2"
  ${List.Insert} MyTestList 2 "Computer"

  ${List.Count} $0 MyTestList
  DetailPrint "Count: $0"

  DetailPrint "Inserting 'Banana' at #2147483647"
  ${List.Insert} MyTestList 2147483647 "Banana"

  ${List.Count} $0 MyTestList
  DetailPrint "Count: $0"

  ${List.All} MyTestList
  Loop3a:
  Pop $0
  DetailPrint "All: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop3a

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Setting #5 to 'Speaker'"
  ${List.Set} MyTestList 5 "Speaker"

  ${List.Count} $0 MyTestList
  DetailPrint "Count: $0"

  ${List.All} MyTestList
  Loop3b:
  Pop $0
  DetailPrint "All: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop3b

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Exchanging #7 with #3"
  ${List.Exch} MyTestList 7 3

  ${List.All} MyTestList
  Loop3c:
  Pop $0
  DetailPrint "All: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop3c

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Moving #6 to #1"
  ${List.Move} MyTestList 6 1

  ${List.All} MyTestList
  Loop3d:
  Pop $0
  DetailPrint "All: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop3d

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Saving list to '$TEMP\NSISList_Test.txt'"
  ${List.Save} $0 MyTestList "$TEMP\NSISList_Test.txt"
  DetailPrint "Result: $0"

  ClearErrors
  FileOpen $0 "$TEMP\NSISList_Test.txt" a
  IfErrors FileSkip
  DetailPrint "Append a few lines to NSISList_Test.txt"
  FileSeek $0 0 END
  FileWrite $0 "Rabbit$\r$\n"
  FileWrite $0 "Umbrella$\r$\n"
  FileWrite $0 "Joker$\r$\n"
  FileClose $0
  FileSkip:

  DetailPrint "Loading list from 'Q:\Foobar\Foobar.foo'"
  ${List.Load} $0 MyTestList "Q:\Foobar\Foobar.foo"
  DetailPrint "Result: $0"

  DetailPrint "Loading list from '$TEMP\NSISList_Test.txt'"
  ${List.Load} $0 MyTestList "$TEMP\NSISList_Test.txt"
  DetailPrint "Result: $0"

  ${List.All} MyTestList
  Loop3e:
  Pop $0
  DetailPrint "All: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop3e

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Set dimension to 20 items!"
  ${List.Dim} MyTestList 20

  ${List.Count} $0 MyTestList
  DetailPrint "Count: $0"

  ${List.All} MyTestList
  Loop3f:
  Pop $0
  DetailPrint "All: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop3f

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Set dimension to 7 items!"
  ${List.Dim} MyTestList 7

  ${List.Count} $0 MyTestList
  DetailPrint "Count: $0"

  ${List.All} MyTestList
  Loop3g:
  Pop $0
  DetailPrint "All: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop3g

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Time to pop all items off the list!"

  Loop4:
  ${List.Count} $1 MyTestList
  DetailPrint "Count: $1"
  ${List.Pop} $0 MyTestList
  DetailPrint "Pop: $0"  
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__EMPTY" 0 Loop4

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Destruction"
  ${List.Destroy} MyTestList

  DetailPrint "Can I access the list now?"
  ${List.First} $0 MyTestList

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------
  
  DetailPrint "Now testing the (default) list!"

  ${List.Add} "" "Foobar 42"
  ${List.Add} "" "Foobar 43"
  ${List.Add} "" "Foobar 44"
  ${List.Add} "" "Foobar 45"
  ${List.Add} "" "Foobar 46"

  ${List.Count} $0 ""
  DetailPrint "Count: $0"

  ${List.Get} $0 "" 2
  DetailPrint "Item #2 is: $0"

  DetailPrint "Can I destroy the (default) list?"
  ${List.Destroy} ""

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------
  
  DetailPrint "Create first list!"
  ${List.Create} FirstList
  ${List.Add} FirstList "A"
  ${List.Add} FirstList "B"
  ${List.Add} FirstList "C"
  ${List.Add} FirstList "D"
  ${List.Add} FirstList "E"
  ${List.Add} FirstList "F"
  ${List.Add} FirstList "G"
  ${List.Add} FirstList "H"
  ${List.Add} FirstList "I"
  ${List.Add} FirstList "J"
  ${List.Add} FirstList "K"
  ${List.Add} FirstList "L"
  ${List.Add} FirstList "M"
  ${List.Add} FirstList "N"
  ${List.Add} FirstList "O"
  ${List.Add} FirstList "P"
  ${List.Add} FirstList "Q"
  ${List.Add} FirstList "R"

  ${List.Count} $0 FirstList 
  DetailPrint "Count: $0"

  DetailPrint "Create second list!"
  ${List.Create} SecondList
  ${List.Add} SecondList "Z"
  ${List.Add} SecondList "Y"
  ${List.Add} SecondList "X"
  ${List.Add} SecondList "W"
  ${List.Add} SecondList "V"
  ${List.Add} SecondList "U"
  ${List.Add} SecondList "T"
  ${List.Add} SecondList "S"

  ${List.Count} $0 SecondList 
  DetailPrint "Count: $0"

  DetailPrint "Create third list!"
  ${List.Create} ThirdList
  ${List.Add} ThirdList "0"
  ${List.Add} ThirdList "1"
  ${List.Add} ThirdList "2"
  ${List.Add} ThirdList "3"
  ${List.Add} ThirdList "4"
  ${List.Add} ThirdList "5"
  ${List.Add} ThirdList "6"
  ${List.Add} ThirdList "7"
  ${List.Add} ThirdList "8"
  ${List.Add} ThirdList "9"

  ${List.Count} $0 ThirdList 
  DetailPrint "Count: $0"

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  ${List.All} FirstList
  Loop5:
  Pop $0
  DetailPrint "First: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop5

  ${List.All} SecondList
  Loop5a:
  Pop $0
  DetailPrint "Second: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop5a

  ${List.All} ThirdList
  Loop5b:
  Pop $0
  DetailPrint "Third: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop5b

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Reverse order of second list!"
  ${List.Reverse} SecondList

  ${List.All} SecondList
  Loop5c:
  Pop $0
  DetailPrint "Second: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop5c

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Joining all three lists!"
  ${List.Create} SuperList

  ${List.Concat} SuperList FirstList
  ${List.Concat} SuperList SecondList
  ${List.Concat} SuperList ThirdList

  ${List.Count} $0 SuperList
  DetailPrint "Count: $0"

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  ${List.All} SuperList
  Loop5d:
  Pop $0
  DetailPrint "Super: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop5d

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Testing the debugger!"  
  ${List.Debug}

  DetailPrint "Destroy first, second and third list!"  

  ${List.Destroy} FirstList
  ${List.Destroy} SecondList
  ${List.Destroy} ThirdList

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Now copy 5 items from super list starting at #27 to stack!"

  ${List.Copy} SuperList 27 5
  Loop5e:
  Pop $0
  DetailPrint "Copy: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop5e

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  DetailPrint "Clear the super list!"
  ${List.Clear} SuperList

  DetailPrint "Add 'Street' to the super list!"
  ${List.Add} SuperList "Street"

  DetailPrint `Append these: 'Spongebob,"1,2,3","""Cup of Coffee""","Super Mario",Sword'`
  ${List.Append} SuperList 'Spongebob,"1,2,3","""Cup of Coffee""","Super Mario",Sword'

  ${List.Count} $0 SuperList
  DetailPrint "Count: $0"

  ${List.All} SuperList
  Loop6:
  Pop $0
  DetailPrint "Super: $0"
  StrCmp $0 "__ERROR" +2
  StrCmp $0 "__LAST" 0 Loop6

  ${List.Destroy} SuperList

  ;-----------------------------------
  DetailPrint "----------------------"
  ;-----------------------------------

  ${List.Create} Blablubb
  ${List.Create} Baabubuu

  DetailPrint "All tests done, unload plugin now..."
  ${List.Unload}

  Pop $0
  DetailPrint "Please verify: STACK_TOP == $0"
SectionEnd
