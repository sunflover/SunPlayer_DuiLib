/*NSISLog Test
By Ansifa*/

OutFile "NSISLog Test.EXE"
Section
nsislog::log "$exedir\logfile.txt" "text to log"
SectionEnd
