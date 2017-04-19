untgz plugin for NSIS v2
untgz - unzip like replacement plugin, except for gzipped tarballs
KJD <jeremyd@fdos.org>

  This plugin implements functionality similar to the untgz
  sample program distributed with zlib.  It will uncompress
  gzipped (zlib compatible) tar files (*.tgz/*.tar.gz/tarballs) and 
  extract one or more files as indicated by the called command.
  Compile time option to also support lzma (*.tlz/*.tar.lzma)
  and bzip2 (*.tbz/*.tar.bz2) compressed tar files.

  See below for usage information.  Basic portable tarfiles
  are supported, though no particular checking is done, only
  regular files and directories are processed, so extensions
  in the tar file may confuse it, and at present the full
  tar spec is not handled.  Please verify the tarfiles you
  will use work with it before deploying; the pluginTester
  program will allow one to do this easily without the need
  to write and compile a NSIS script.  Only supports filenames
  up to 100 characters (standard tar short names).


  This software based on NSIS exDLL (example plugin) and compression
  libraries including zlib, lzma, and bzip2 libraries.
  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors (or copyright holders) be
  held liable for any damages arising from the use of this software.
  Read LICENSE.TXT for details.


/****************************************************************************/

/*
  USAGE:
  untgz::extract [-j] [-d basedir] [-k|-u] [-z<type>] [-x] [-f] tarball.tgz
    extracts files from tarball.tgz
      if [option] is specified then:
         -j       ignore paths in tarball (junkpaths)
         -d       will extract relative to basedir
         -k is    will not overwrite existing files (keep)
         -u is    will only overwrite older files (update)
         -z is    determines compression used, see below
  untgz::extractV [-j] [-d basedir] [-k|-u] [-z<type>] [-x] [-f] tarball.tgz [-i {iList}] [-x {xList}] --
    extracts files from tarball.tgz
      if [option] is specified then:
         -j       ignore paths in tarball (junkpaths)
         -d       will extract relative to basedir
         -k is    will not overwrite existing files (keep)
         -u is    will only overwrite older files (update)
         -z is    determines compression used, see below
      if -i is specified will only extract files whose filename matches
      if -x is specified will NOT extract files whose filename matches
      the -- is required and marks the end of the file lists
  untgz::extractFile [-d basedir] [-z<type>] tarball.tgz file
    extracts just the file specified
      path information is ignored, implictly -j is specified (may also be explicit)

  For compatibility with tar command, the following option specifiers may be
  used (must appear prior to filename argument), however, they are simply ignored.
      -x indicates action to perform is extraction (extract)
      -f archive-name indicates name of tarball (filename), note
         even when used, the filename must be last argument

  If neither -k or -u is used then all existing files will be replaced
  by corresponding file contained within archive.  

  The -z<type> option may be specified to explicitly indicate how
  tar file is compressed.
  -z      indicates gzip (.tgz/.tar.gz) compression, uses zlib,
  -zgz    alias for -z
  -znone  indicates uncompressed tar file (.tar)
  -zlzma  indicates lzma (.tlz/.tar.lzma) compression
  -zbz2   indicates bzip2 (.tbz/.tar.bz2) compression
  -zZ     indicates compress (.tZ/.tar.Z) compression UNSUPPORTED
  -zauto  determines type based on content & extension
          this is the default if -z<type> option is omitted
          NOTE: prior to version 1.0.15 -z was the default
  

  NOTES:
    Without -j there is a security issue as no checking is done to paths,
    allowing untrusted tarballs to overwrite arbitrary files (e.g. /bin/*).
    Also no checking is done to directory or file names.  In untar.c there
    is a hook so custom versions can modify/strip filepaths prior to opening.
    The -d option is currently implemented by a chdir to indicatd directory
    prior to extraction; future versions may instead prepend to extracted path.
*/


TODO:
- determine most compatible use of prefix (when and if to use, and how much)
  to support file names longer than 100 characters. [DOES ANYBODY CARE?]
- add support for gnu/star extension for Sparse files. [DOES ANYBODY CARE?]


NOTES:  (see CHANGES.TXT for complete CHANGELOG)
- presently tested with NSIS v2
- does not require a c runtime library (important if say you compile with MS VC 7 and don't
  want to require its runtime present during install [or Windows 95 and compiled with MS VC 5 or 6])
- to create a .tar.lzma (or .tlz) file, create a standard tarball (uncompressed) and then
  compress using lzma.exe within LZMA SDK (http://www.7-zip.org/sdk.html)
- Starting with version 1.0.15 when -z<type> option is ommitted, compressed type is determined
  automatically based on file contents and file extension.

KJD
20071110
