Metadl - metalink downloading plugin for NSIS
Copyright (c) 2007 Hampus Wessman (hw@vox.nu)
-------------------------------------------------

USING NSIS PLUGINS
------------------

Before you can use the plugin NSIS must be able to find the dll file. One 
way to accomplish this is to put it in the plugin directory of NSIS. This 
will make it possible for all installers built on you computer to use 
metadl. Another way (that I like better) is to put it in a directory 
specific for your current installer and then add a line of code to your NSIS 
script that tells NSIS to look in this directory. You can for example create 
a subdirectory called "plugins" and add this line to your NSIS script:

!addplugindir "plugins"

USAGE
-----

metadl:download [options] [url] local-file

The return value is pushed to the stack:

  "cancel" if cancelled
  "success" if success
  otherwise, an error string describing the error

If you don't want the progress window to appear, use metadl::download_quiet 
(which isn't recommended, because you can't cancel the download then).

OPTIONS
-------

/RETRYTIME=5 (the number of seconds between retries; default=5)
/MAXTRIES=0  (max tries; 0=infinite, 1=no retries, ...; default=0)
/HASHTRIES=0 (max tries when checksums fail, works as max tries; default=0)

/MD5 the-hash  (use this hash to validate the download; no md5 as default)
/SHA1 the-hash (use this hash to validate the download; no sha1 as default)
both md5 and sha1 can be used at the same time!

/CHECK (only checks hashes, won't download anything; disabled by default)

/MIRRORS=2 url1 url2 (add these mirrors. You still need an "ordinary" url, so 
leave one mirror for that!)

/PROXY proxy.whatever.com
/PROXY proxy.whatever.com:8080

It is also possible to translate the plugin (undocumented; not compatible with 
NSISdl!) and set all the other options from NSISdl (which aren't used anyway).

LOCAL FILES & HASH CHECKING
---------------------------

If you don't enter an URL, the plugin won't try to download the file. This is 
useful if you want to use a local metalink, which will get parsed and used for 
downloading. Hashes are still being checked (if present) and an error will be 
returned if they don't match (instead of trying to download the file). If you 
don't want the files found in a metalink to be downloaded, you can add the 
option /CHECK (see above). Metalinks will still be parsed and all files 
described in them will be checked, but an error will be returned instead of 
trying to download any of them. "File check failed" will be returned when the 
hash checks fail or a file doesn't exist.

HOW IT BEHAVES
--------------

The plugin first looks for the local-file. If it exists it checks the hashes 
and if none fails it is done! Otherwise the old file is deleted (if there was 
one) and it looks for a file named local-file.partial. If there is one it 
continues at the end of the file, otherwise it creates one. Then the 
downloading begins. Mirrors are selected at random to begin with, but errors 
and in which order they was last tested is remember. After a while it picks 
the "best" server to try. I won't get into details about this, but it works 
quite well.
If errors occur then it updates the info about the mirrors (in memory) and 
checks if any more retries should be done (depends on 'max tries'). This is 
the total number of tries (not per mirror). When the file is downloaded the 
checksums are checked. If the file doesn't validate it is deleted and the 
process starts over again (depending on 'hash tries'). If the file is correct, 
then it is renamed to 'local-file'.

If the downloaded file ends with ".metalink" it is parsed and, if it is a 
metalink file, all the files described in the metalink will be downloaded as 
described above, to the same directory as the metalink. If any of these files 
also are metalinks, they won't get parsed though!

If not "cancel" or "success" is returned, an error message will always be 
returned instead, that explains what went wrong!

COMPILING THE PLUGIN
--------------------

I will describe how to cross compile the plugin in Ubuntu here. Compiling it
in windows is more complex. Just follow these simple steps:

1. Make sure you have the mingw32 package installed, otherwise run
   "sudo apt-get install mingw32"
2. Run "make prerequisites" to download expat and libcurl.
3. Then run "make" to compile the plugin.

This will compile both metadl and its dependencies. You'll find the binary
(ie metadl.dll) in the subdir "bin".

If you're using another platform than Ubuntu, then you will probably need to
make some adjustments to the building process. The makefile included here is
only made to work with Ubuntu. That's not great, but on the other hand it
should be quite easy to make the necessary changes...
