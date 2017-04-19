OutFile findservices.exe
Section
  services::GetServiceNameFromDisplayName 'inst'
  Pop $0
  MessageBox MB_OK|MB_ICONINFORMATION '$0 results found'
again:
  IntCmp $0 0 done
  IntOp $0 $0 - 1
  Pop $1
  MessageBox MB_OK|MB_ICONINFORMATION 'Result: $1'
  Goto again
done:
SectionEnd