EVENTLOG PLUGIN
---------------------

Written by Stefano Giusto <sgiusto@mmpoint.it>

The EventLog plugin for NSIS provides a function to write Events to
the windows Event Log.

COMPATIBILITY
-------------

Windows NT,2000,XP


MODIFICATIONS
-------------

-  5 March 2007 - First release



FUNCTIONS
---------

WriteEventLog <server> <log> <type> <category> <message> <text>

	Writes and event to the EventLog
	<server>   Network name of PC to write events to
	           Leave blank to write to local PC
	<log>      Event log to write 
	           Standard windows Event Logs are "System" and "Application"
	           but other can be defined by user. If specific event log
	           is not found "Application" will be used
	<type>     Type of message to write
			   "0" - Information
			   "1" - Error
			   "2" - Warning
	<category> Event category. Can be any value and is specific to the event
			   log currently written.
	<message>  ID of the message to write. This id is specific to the event
	           log currently written.
	<text>     Message text to write to event log (up to 1024 bytes) 




