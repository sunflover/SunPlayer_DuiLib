EnumCDs - NSIS plug-in by KiCHiK
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This plug-in will return every available CD-ROM drive on the user's machine one by one.

This plug-in requires NSIS 2.

Put EnumCDs.dll in the Plugins directory under the directory where you installed NSIS.

To use it call EnumCDs::next with the /NOUNLOAD flag, and keep popping the
results, the CD-ROM drive letters, one by one until the plug-in pushes "done".
Then call EnumCDs::next once more without the /NOUNLOAD flag, pop the
second "done" and you're done.

For example:

again:
	EnumCDs::next /NOUNLOAD
	Pop $0
	StrCmp $0 "error" done
	DetailPrint $0
StrCmp $0 "done" done again
done:
	EnumCDs::next
	Pop $0