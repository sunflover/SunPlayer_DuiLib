;-----------------------------------------------------------------------------------
; Simple example of NSISList Plugin
;-----------------------------------------------------------------------------------

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
