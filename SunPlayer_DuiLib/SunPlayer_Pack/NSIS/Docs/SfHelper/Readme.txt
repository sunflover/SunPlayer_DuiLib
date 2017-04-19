NSIS plugin to parse mirror URLs from sourceforge, used to aid in writing a web installer.


Two entry points: 'checkFile' and 'getMirrors', both calls take a filename to parse.

When downloading a file from sourceforge you may occasionally obtain an html error page rather than the intended file.

sfhelper::checkFile <downloaded file>

returns "OK" if html header was not found.
returns "error" if it was.

sfhelper::getMirrors <downloaded file> 

returns a string consisting of all the mirror hosts found in the html delimited by |

see the included nsi file for sample use.

Dave Murphy
davem@devkitpro.org
