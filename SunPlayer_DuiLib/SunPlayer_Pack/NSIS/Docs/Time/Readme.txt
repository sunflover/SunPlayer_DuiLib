*****************************************************************
***                 Time NSIS plugin v1.6                     ***
*****************************************************************

2006 Shengalts Aleksander aka Instructor (Shengalts@mail.ru)


Features:
- Mathematical operations with times
- Get local time
- Set local time
- Get file/directory creation, last write, last access times
- Set file/directory creation, last write, last access times
- UTC supported

Notes:
- Win95/Win98/WinMe: Time set for directory is not supported


**** Mathematical operations with times ****

${time::MathTime} "[expression]" $var

"[expression]"  -  Time representation:
                   date(31.12.2006 23:59:59)    -date as it is
                   second(31.12.2006 23:59:59)  -convert date to seconds
                   minute(31.12.2006 23:59:59)  -convert date to minutes
                   hour(31.12.2006 23:59:59)    -convert date to hours
                   day(31.12.2006 23:59:59)     -convert date to days
                   month(31.12.2006 23:59:59)   -convert date to months
                   year(31.12.2006 23:59:59)    -convert date to years

                   Operators:
                   +, -, *, /, %, =

                   Operator = placed at the and of the expression
                   ... =         -save result as it is
                   ... = date    -convert result to the normal date string
                   ... = second  -convert result to the seconds
                   ... = minute  -convert result to the minutes
                   ... = hour    -convert result to the hours
                   ... = day     -convert result to the days
                   ... = month   -convert result to the months
                   ... = year    -convert result to the years


                   Example (calculate day of the week):
                   ${time::MathTime} "day(29.12.2005 0:0:0) + 5 % 7 =" $R0
                   #$R0=4 (Thursday)

                   Example (calculate date after 60 days):
                   ${time::MathTime} "date(29.12.2005 0:0:0) + date(60.0.0 0:0:0) = date" $R0
                   #$R0=27.02.2006 00:00:00

                   Example (calculate how many days between dates):
                   ${time::MathTime} "second(29.12.2005 0:0:0) - second(15.09.1996 0:0:0) = day" $R0
                   #$R0=3392

$var    result
        "" - error

Notes:
- You can operate only with equal units: date() with date(), second() with second() ...
- You can't operate number with date: "date(29.12.2005 0:0:0) + 5 ="
- You can't convert negative time unit to date: "month(01.01.0 0:0:0) - 10 = date"
- Mathematical operations are consecutive
- Minimal normal date is "1.1.0 0:0:0"


**** Get local time ****

${time::GetLocalTime} $var

$var    local time


**** Get local time (UTC) ****

${time::GetLocalTimeUTC} $var

Parameters same as ${time::GetLocalTime}


**** Set local time ****

${time::SetLocalTime} "[LocalTime]" $var

"[LocalTime]"  - (e.g. "31.12.2006 23:59:59")

$var     0 - success
        -1 - error


**** Set local time (UTC) ****

${time::SetLocalTimeUTC} "[LocalTime]" $var

Parameters same as ${time::SetLocalTime}


**** Get file times ****

${time::GetFileTime} "[file]" $var1 $var2 $var3

"[file]"  - File or directory

$var1    creation time
$var2    last write time
$var3    last access time


**** Get file times (UTC) ****

${time::GetFileTimeUTC} "[file]" $var1 $var2 $var3

Parameters same as ${time::GetFileTime}


**** Set file times ****

${time::SetFileTime} "[file]" "[CreationTime]" "[LastWriteTime]" "[LastAccessTime]" $var

"[file]"  - File or directory

"[CreationTime]"    - (e.g. "31.12.2006 23:59:59")
                      if empty don't change time
"[LastWriteTime]"   - (e.g. "31.12.2006 23:59:59")
                      if empty don't change time
"[LastAccessTime]"  - (e.g. "31.12.2006 23:59:59")
                      if empty don't change time

$var     0 - success
        -1 - error


**** Set file times (UTC) ****

${time::SetFileTimeUTC} "[file]" "[CreationTime]" "[LastWriteTime]" "[LastAccessTime]" $var

Parameters same as ${time::SetFileTime}


**** Get times from time string ****

${time::TimeString} "[Time]" $var1 $var2 $var3 $var4 $var5 $var6

"[Time]"    - (e.g. "31.12.2006 23:59:59")

$var1    31   - day
$var2    12   - month
$var3    2006 - year
$var4    23   - hour
$var5    59   - minute
$var6    59   - second


**** Unload plugin ****

${time::Unload}
