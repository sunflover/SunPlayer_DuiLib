*****************************************************************
***                  name2ip NSIS plugin v1.0                 ***
*****************************************************************

2006 Shengalts Aleksander aka Instructor (Shengalts@mail.ru)


Description:
Translate host name to IP address.


**** Find first IP ****

${name2ip::FindFirstIP} "[name]" $var

"[name]"  Host name or empty if local PC
$var      IP address


**** Find next IP ****

${name2ip::FindNextIP} $var

$var      IP address


**** Close ****

${name2ip::FindCloseIP}
