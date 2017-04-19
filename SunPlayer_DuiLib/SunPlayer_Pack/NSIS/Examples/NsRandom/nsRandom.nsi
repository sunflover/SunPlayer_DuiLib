Name "nsRandom Test"

OutFile "nsRandom Test.exe"

ShowInstDetails show

Section "Get Random"
        DetailPrint "nsRandom example by Leon Zandman"
        DetailPrint "------------------------------------"

        DetailPrint "Getting 10 random numbers in range 0 <= random < 100:"
        StrCpy $1 10
        loop1:
          ; Use range 0 <= Random < 100
          Push "100"
          
          ; Get the random number
          nsRandom::GetRandom
          
          Pop $2
          DetailPrint "$2"

          IntOp $1 $1 - 1
          IntCmp $1 0 exit_loop1
        Goto loop1
          
        exit_loop1:
          
        DetailPrint "------------------------------------------"
        
        DetailPrint "Getting 10 random numbers between 0 and 1:"
        StrCpy $1 10
        loop2:
          ; Use range 0 <= Random < 1 (floating numbers!)
          Push "-1"

          ; Get the random number
          nsRandom::GetRandom

          Pop $2
          DetailPrint "$2"

          IntOp $1 $1 - 1
          IntCmp $1 0 exit_loop2
        Goto loop2

        exit_loop2:

SectionEnd
