; example.nsi
; Demonstrates (and mini test of) usage of untgz NSIS plugin
; KJD <jeremyd@computer.org>

; The name of the installer
Name "untgz Example"

; The file to write
OutFile "untgz_example.exe"

; Let user see messages in detail window
ShowInstDetails show

; The default installation directory
InstallDir $TEMP\Example

; The text to prompt the user to enter a directory
DirText "This will install the untgz example on your computer.  Please select a directory"

; The text to prompt the user to enter a directory
ComponentText "This will install untgz examples on your computer. Select which test to run."

; let user choose examples to run
InstType "All Examples"
InstType "extract all files"
InstType "extract all files alternate"
InstType "extract specific files"
InstType "extract a single file"
InstType "extract a corrupt or missing file"
InstType "extract a zero byte file"
InstType "extract all files from uncompressed tarball"
InstType "Test readonly/inuse files extraction"
InstType "Test update files extraction"
InstType "extract all files from lzma compressed tarball"
InstType "extract all files from bzip2 compressed tarball"
InstType "extract all files from tarball (auto determine type)"

; Required, the sample tarball used for testing
Section ""
  SectionIn 1 2 3 4 5 6 7 8 9 10 11 12 13 RO
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  ; Put file there
  File example.tgz
  File examplecorrupt.tgz
  File exampleempty.tgz
  File examplenewer.tgz
  File dups.tar.gz
  ; the alternate compressed files
  File example.tar
  File example.tlz
  File example.tar.lzma
  File example.tbz
SectionEnd

Section "Test extract"
  SectionIn 1 2
  ; untgz::extract [-j] [-d basedir] tarball.tgz
  untgz::extract -j -d "$INSTDIR/junkedpaths" "$INSTDIR/example.tgz"
  DetailPrint "untgz returned ($R0)"
  untgz::extract -d "$INSTDIR/withpaths" "$INSTDIR/example.tgz"
  DetailPrint "untgz returned ($R0)"
SectionEnd

Section "Test extractV, same as extract"
  SectionIn 1 3
  ; untgz::extractV [-j] [-d basedir] tarball.tgz [-i {iList}] [-x {xList}] --
  untgz::extractV -j -d "$INSTDIR/junkedpathsAlt" "$INSTDIR/example.tgz" --
  DetailPrint "untgz returned ($R0)"
  untgz::extractV -d "$INSTDIR/withpathsAlt" "$INSTDIR/example.tgz" --
  DetailPrint "untgz returned ($R0)"
SectionEnd

Section "Test extractV"
  SectionIn 1 4
  ; untgz::extractV [-j] [-d basedir] tarball.tgz [-i {iList}] [-x {xList}] --
  untgz::extractV -j -d "$INSTDIR/junkedpathsI" "$INSTDIR/example.tgz" -i "another doc.txt" --
  DetailPrint "untgz returned ($R0)"
  untgz::extractV -j -d "$INSTDIR/junkedpathsX" "$INSTDIR/example.tgz" -x "another doc.txt" --
  DetailPrint "untgz returned ($R0)"

  untgz::extractV -d "$INSTDIR/withpathsIa" "$INSTDIR/example.tgz" -i "another doc.txt" --
  DetailPrint "untgz returned ($R0)"
  untgz::extractV -d "$INSTDIR/withpathsXa" "$INSTDIR/example.tgz" -x "sample doc.txt" --
  DetailPrint "untgz returned ($R0)"
  untgz::extractV -d "$INSTDIR/withpathsXb" "$INSTDIR/example.tgz" -i "sample doc.txt" --
  DetailPrint "untgz returned ($R0)"
  untgz::extractV -d "$INSTDIR/withpathsIb" "$INSTDIR/example.tgz" -x "another doc.txt" --
  DetailPrint "untgz returned ($R0)"

  untgz::extractV -d "$INSTDIR/withpathsXs" "$INSTDIR/example.tgz" -x "subdir" --
  DetailPrint "untgz returned ($R0)"
  untgz::extractV -d "$INSTDIR/withpathsX curious" "$INSTDIR/example.tgz" -x "subdir/*" --
  DetailPrint "untgz returned ($R0)"
SectionEnd

Section "Test extractFile"
  SectionIn 1 5
  ; untgz::extractFile [-d basedir] tarball.tgz file
  untgz::extractFile -d "$INSTDIR/singlefile" "$INSTDIR/example.tgz" "another doc.txt"
  DetailPrint "untgz returned ($R0)"

  untgz::extractFile -d "$INSTDIR/readonly" "$INSTDIR/example.tgz" "my doc.txt"
  DetailPrint "untgz returned ($R0)"
SectionEnd

Section "Test extract corrupt File"
  SectionIn 1 6
  ; attempt to extract from a corrupt [manually truncated] tarball
  untgz::extractFile -d "$INSTDIR/corrupt" "$INSTDIR/examplecorrupt.tgz" "fake doc.txt"
  DetailPrint "untgz returned ($R0)"

  ; attempt to extract from a nonexistant tarball
  untgz::extractFile -d "$INSTDIR/corrupt" "$INSTDIR/exampleNotExist.tgz" "my doc.txt"
  DetailPrint "untgz returned ($R0)"

  ; attempt a proper extraction, should succeed.
  untgz::extractFile -d "$INSTDIR/corruptSuccess" "$INSTDIR/example.tgz" "another doc.txt"
  DetailPrint "untgz returned ($R0)"

  ; attempt to extract a file from archive that does not exist
  untgz::extractFile -d "$INSTDIR/singlefile2" "$INSTDIR/example.tgz" "Notexist.txT"
  DetailPrint "untgz returned ($R0)"
  untgz::extractFile -d "$INSTDIR/singlefile2" "$INSTDIR/example.tgz" "my doc.txt"
  DetailPrint "untgz returned ($R0)"
SectionEnd

Section "Test extract 0 byte file"
  SectionIn 1 7
  untgz::extract -d "$INSTDIR/zerofile" "$INSTDIR/exampleempty.tgz"
  DetailPrint "untgz returned ($R0)"
SectionEnd

Section "Test uncompressed tarball"
  SectionIn 1 8
  untgz::extract -d "$INSTDIR/plainTAR" "$INSTDIR/example.tar"
  DetailPrint "untgz returned ($R0)"
  untgz::extract -d "$INSTDIR/plainTAR2" -znone "$INSTDIR/example.tar"
  DetailPrint "untgz returned ($R0)"
SectionEnd

Section "Test readonly/inuse files extraction"
  SectionIn 1 9
  DetailPrint ""
  DetailPrint "Test readonly/inuse files extraction"

  ; Be sure paths to FileOpen and SetFileAttributes ONLY use \

  DetailPrint "this should succeed"
  untgz::extractFile -d "$INSTDIR/readonly" "$INSTDIR/example.tgz" "another doc.txt"
  DetailPrint "untgz returned ($R0)"
  DetailPrint "this should succeed as well overwriting the file"
  untgz::extractFile -d "$INSTDIR/readonly" "$INSTDIR/example.tgz" "another doc.txt"
  DetailPrint "untgz returned ($R0)"

  DetailPrint "force this file open so next call should fail"
  ClearErrors
  FileOpen $0 "$INSTDIR\readonly\another doc.txt" a
  IfErrors 0 +2
    MessageBox MB_OK "Failed to open file"
  DetailPrint "this should produce an error since file trying to extract is open"
  untgz::extractFile -d "$INSTDIR/readonly" "$INSTDIR/example.tgz" "another doc.txt"
  DetailPrint "untgz returned ($R0)"
  DetailPrint "now retry should succeed once file closed"
  FileClose $0
  untgz::extractFile -d "$INSTDIR/readonly" "$INSTDIR/example.tgz" "another doc.txt"
  DetailPrint "untgz returned ($R0)"

  DetailPrint "set file to readonly"
  ClearErrors
  SetFileAttributes "$INSTDIR\readonly\another doc.txt" FILE_ATTRIBUTE_READONLY
  IfErrors 0 +2
    MessageBox MB_OK "Failed to set file to readonly"
  DetailPrint "this should fail"
  untgz::extractFile -d "$INSTDIR/readonly" "$INSTDIR/example.tgz" "another doc.txt"
  DetailPrint "untgz returned ($R0)"
  DetailPrint "restore attributes, retry should succeed"
  SetFileAttributes "$INSTDIR\readonly\another doc.txt" FILE_ATTRIBUTE_NORMAL
  untgz::extractFile -d "$INSTDIR/readonly" "$INSTDIR/example.tgz" "another doc.txt"
  DetailPrint "untgz returned ($R0)"
SectionEnd

Section "Test update files extraction"
  SectionIn 1 10
  DetailPrint ""
  DetailPrint "Test update files extraction"
  ; this should succeed
  untgz::extractFile -d "$INSTDIR/update" "$INSTDIR/example.tgz" "another doc.txt"
  DetailPrint "untgz returned ($R0)"
  ; this should skip the file just extracted
  untgz::extractFile -k -d "$INSTDIR/update" "$INSTDIR/example.tgz" "another doc.txt"
  DetailPrint "untgz returned ($R0)"
  ; so should this one, since update should not happen (same time)
  untgz::extractFile -u -d "$INSTDIR/update" "$INSTDIR/example.tgz" "another doc.txt"
  DetailPrint "untgz returned ($R0)"
  ; this should extract some files and skip ones skipped above
  untgz::extract -j -u -d "$INSTDIR/update" "$INSTDIR/example.tgz"
  DetailPrint "untgz returned ($R0)"

  DetailPrint "set file to readonly"
  untgz::extractFile -d "$INSTDIR/upd" "$INSTDIR/example.tgz" "another doc.txt"
  DetailPrint "untgz returned ($R0)"
  ClearErrors
  SetFileAttributes "$INSTDIR\upd\another doc.txt" FILE_ATTRIBUTE_READONLY
  IfErrors 0 +2
    MessageBox MB_OK "Failed to set file to readonly"
  DetailPrint "this should fail"
  untgz::extractFile -u -d "$INSTDIR/upd" "$INSTDIR/examplenewer.tgz" "another doc.txt"
  DetailPrint "untgz returned ($R0)"
  SetFileAttributes "$INSTDIR\upd\another doc.txt" FILE_ATTRIBUTE_NORMAL
  DetailPrint "this should update the file"
  untgz::extractFile -u -d "$INSTDIR/upd" "$INSTDIR/examplenewer.tgz" "another doc.txt"
  DetailPrint "untgz returned ($R0)"
SectionEnd

Section "Test lzma compressed tarball"
  SectionIn 1 11 
  DetailPrint ""
  DetailPrint "Test lzma compressed tarball"
  untgz::extract -d "$INSTDIR/tlz_file" -zlzma "$INSTDIR/example.tlz"
  DetailPrint "untgz returned ($R0)"
  untgz::extract -d "$INSTDIR/tar_lzma_file" -zlzma "$INSTDIR/example.tar.lzma"
  DetailPrint "untgz returned ($R0)"
SectionEnd

Section "Test bzip2 compressed tarball"
  SectionIn 1 12
  DetailPrint ""
  DetailPrint "Test bzip2 compressed tarball"
  ; same example files as others
  untgz::extract -d "$INSTDIR/tbz_file" -zbz2 "$INSTDIR/example.tbz"
  DetailPrint "untgz returned ($R0)"
  ; this one should fail
  DetailPrint "Test bzip2 extraction on invalid tarball"
  untgz::extract -d "$INSTDIR/tbz_fail" -zbz2 "$INSTDIR/example.tgz"
  DetailPrint "untgz returned ($R0)"
SectionEnd

Section "Test extraction tarball, no type indicated"
  SectionIn 1 13
  DetailPrint ""
  DetailPrint "Test plain (uncompressed) tarball"
  untgz::extract -d "$INSTDIR/tar_file" "$INSTDIR/example.tar"
  DetailPrint "untgz returned ($R0)"
  DetailPrint "Test gzipped compressed tarball"
  untgz::extract -d "$INSTDIR/tgz_file" "$INSTDIR/example.tgz"
  DetailPrint "untgz returned ($R0)"
  DetailPrint "Test lzma compressed tarball"
  untgz::extract -d "$INSTDIR/tlz_file" "$INSTDIR/example.tlz"
  DetailPrint "untgz returned ($R0)"
  DetailPrint "Test bzip2 compressed tarball"
  ; same example files as others
  untgz::extract -d "$INSTDIR/tbz_file" "$INSTDIR/example.tbz"
  DetailPrint "untgz returned ($R0)"
SectionEnd

; eof
