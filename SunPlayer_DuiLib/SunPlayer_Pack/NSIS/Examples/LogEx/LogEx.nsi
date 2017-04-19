Name "LogEx Example"
OutFile "LogEx.exe"
ShowInstDetails show

Page InstFiles

Section

   LogEx::Init /NOUNLOAD "$exedir\log.txt"
   LogEx::Write /NOUNLOAD "Write this line to the log file only"
   LogEx::Write /NOUNLOAD true "Write this line to the log file and the status list box"
   LogEx::Write /NOUNLOAD true true "Write this line to the log file, the status list box and the statusbar"

   ExecDos::exec 'cmd /C dir' "" "$exedir\output.log"

   LogEx::Write /NOUNLOAD 'Write complete "dir" output to the log file with ">" as prefix'
   LogEx::AddFile /NOUNLOAD "   >" "$exedir\output.log"
   LogEx::Write /NOUNLOAD 'Write "dir" output from line3 to the log file'
   LogEx::AddFile /NOUNLOAD 3 "" "$exedir\output.log"
   LogEx::Write /NOUNLOAD 'Write "dir" output from line3 to line6 to the log file'
   LogEx::AddFile /NOUNLOAD 3 6 "" "$exedir\output.log"
   LogEx::Close

SectionEnd
