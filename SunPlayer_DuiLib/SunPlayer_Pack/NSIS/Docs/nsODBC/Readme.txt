nsODBC is NSIS ODBC Configuration Manager. Works over odbcinst32.dll. Based on SQLInstall Win API. 


* Methods :
nsODBC::AddDSNnsODBC   ;[DriverName] Parameters pairs follows: [DSN=XXX] [UID=0x777] ...
nsODBC::AddSysDSNnsODBC;[DriverName] Parameters pairs follows: [DSN=XXX] [UID=0x777] ...
nsODBC::ConfDSNnsODBC  ;[DriverName] Parameters pairs follows: [DSN=XXX] [UID=0x777] ...
nsODBC::ConfSysDSN   ;[DriverName] Parameters pairs follows: [DSN=XXX] [UID=0x777] ...
nsODBC::RemoveDSNnsODBC;[DriverName] Parameters pairs follows: [DSN=XXX] [UID=0x777] ...
nsODBC::RemoveSysDSN ;[DriverName] Parameters pairs follows: [DSN=XXX] [UID=0x777] ...
nsODBC::RemoveDefDSN ;[DriverName] Parameters pairs follows: [DSN=XXX] [UID=0x777] ...

* Example Scripts:

	; Create MS Access DSN & Data Base
nsODBC::AddSysDSN "Microsoft Access Driver (*.mdb)" "DSN=SERVER_${PRJ_NAME}_DB" "DBQ=$INSTDIR\${PRJ_NAME}.mdb"

	; Remove DSN
nsODBC::RemoveSysDSN "Microsoft Access Driver (*.mdb)" "DSN=SERVER_${PRJ_NAME}_DB"


It is also possible to create, compact, and repair Microsoft Access mdb files with this plugin. A link below explains the syntax for compacting and repairing the database. Notice: Be sure to put the path to the database file in escaped quotes as the command will fail if there are spaces in the file name otherwise.

	; Create a JetSQL (mdb) file.
nsODBC::AddDSN "Microsoft Access Driver (*.mdb)" "CREATE_DB=$\"$INSTDIR\foo.mdb$\" General"

* References :
;	http://support.microsoft.com/kb/126606/EN-US/