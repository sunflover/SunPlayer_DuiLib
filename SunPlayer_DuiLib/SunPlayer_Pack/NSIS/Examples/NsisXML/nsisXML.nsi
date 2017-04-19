; nsisXML - Sample script

!addplugindir ${TARGETDIR}

Name "Sample nsisXML"
OutFile "Sample.exe"
ShowInstDetails show	

Section "Main program"
	nsisXML::create
	nsisXML::createProcessingInstruction "xml" 'version="1.0" encoding="UTF-8" standalone="yes"'
	nsisXML::appendChild
	nsisXML::createElement "main"	; create main document element node
	nsisXML::appendChild
	StrCpy $1 $2			; lets move to this node and create its childs:
	nsisXML::createElement "child"
	nsisXML::setAttribute "attrib" "value"
	nsisXML::setText "content"
	nsisXML::appendChild
	nsisXML::createElement "child"
	nsisXML::setAttribute "attrib" "value2"
	nsisXML::setAttribute "active" "yes"
	nsisXML::setText "content2"
	nsisXML::appendChild
	nsisXML::save "Sample.xml"

	MessageBox MB_OK "Sample.xml was created$\nPress OK to continue sample"

	nsisXML::create /NOUNLOAD
	nsisXML::load /NOUNLOAD "Sample.xml"
	nsisXML::select /NOUNLOAD '/main/child[@attrib="value2"]'
	IntCmp $2 0 notFound
	nsisXML::getAttribute /NOUNLOAD "active"
	DetailPrint "Attribute 'active' is $3"
	nsisXML::getText /NOUNLOAD
	DetailPrint "Tag <child> contains $3"
	nsisXML::parentNode /NOUNLOAD
	nsisXML::removeChild /NOUNLOAD
	nsisXML::save "Sample.xml"
	Goto end
notFound:
	DetailPrint "XPath not resolved"
end:
SectionEnd
