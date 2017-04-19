/*nsODBC Test
By Ansifa*/
!AddPluginDir "..\..\Plugins"
OutFile "nsODBC Test.EXE"
Section
	;增加系统DSN，名称foo_DB，数据库文件$EXEDIR\foo.mdb
nsODBC::AddSysDSN "Microsoft Access Driver (*.mdb)" "DSN=foo_DB" "DBQ=$EXEDIR\foo.mdb"

	;删除名称为foo_DB的系统DSN
;nsODBC::RemoveSysDSN "Microsoft Access Driver (*.mdb)" "DSN=foo_DB"

;	命令行： [DriverName] Parameters pairs follows: [DSN=XXX] [UID=0x777] ...
;	其他使用方法参见下面网址：
;	http://support.microsoft.com/kb/126606/EN-US/
SectionEnd
