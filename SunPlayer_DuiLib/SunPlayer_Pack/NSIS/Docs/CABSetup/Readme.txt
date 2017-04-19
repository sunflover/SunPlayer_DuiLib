CABSetup - suite to assist with multi-volume setups in NSIS.

Version 1.3.1.0

Written by Duncan McKellar (Mr Inches), January-December 2006, June 2008

The suite operates under the assumption (which I believe is correct), that the
bulk of an NSIS installer that would require multiple source media is a large
number or amount of source files e.g. large data files, rather than a large
amount of NSIS code. Since NSIS installers are very compact, and the plugin
only consumes about 16K (8K compressed) itself, this should prove workable for
most installers.

These large files can be packaged into cabinet sets that span multiple source
media and the accessory code to perform any other actions can be contained
in a relatively small NSIS package placed on the first disk.

If a larger installer is required, it can be packaged into a dataset set with
a small installer to extract it from the source media, pass control to it,
delete the temporary (large) installer as the last step of the small installer
and let InstStub delete the small installer when it completes.

History
=======
1.0.0.0 28 February 2006
        Initial Release.
1.1.0.0 07 June 2006
        Removed MSVC runtime dependencies.

        Fixed bug/design issue that emptied NSIS stack when plugin functions
        called. Parameter lists must now end in the '|' character.

        Report function now prints text to the Detail text field and log.

        Both ExitStub/InstStub and CABSetup.dll use libctiny.lib to replace
        the CRT. The library does not need to be distributed with installers
        created with CABSetup.
1.2.0.0 26 June 2006 (not released)
        Added a progress bar to be displayed during the extraction process.
        Currently this only works for the entire dataset i.e. with the /ALL
        switch, since it uses the summary report file.

        Added /REPORTFILE switch to both functions to support the generation
        and use of this summary report.
1.2.3.0 03 October 2006
        Added new function, DataSetSize, to retrieve the size of a dataset
        from the associated report file.

        Changed BuildSetupFile parameters to unify filenames for the report,
        directive, and information files. Datasets are now identified by a
        dataset name and a path to hold the dataset cabinets; the above files
        are named after the dataset name and held in the dataset path.
        
        These are specified through the /DATASET and /DATASETPATH parameters.
        
        Added the option for Compress switch to have a value of "None" to
        disable compression.
        
        Updated all scripts to use the new forms of the functions and to include
        the mulitple datasets and progress bars.
1.3.0.0 12 December 2006
        Added ability to cancel the extraction of a dataset.

        Added function to show the extraction rate during the extraction of
        a dataset.
        
        Added function to resume the extraction of a dataset that has been
        cancelled/stopped.
        
        Extract will now attempt to create the target path if it does not
        exist.

1.3.1.0 2 June 2008
        Fixed bug that caused installers using Extract to crash on Vista.

Components
===========

The CABSetup suite consists of a number of components that operate together to
support multi-volume NSIS installers.

CABSetup.dll    - NSIS plugin for creating multi-volume cabinet sets and
                  extracting the contents of multi-volume cabinet sets.
                  Place in your "NSIS\Plugins" directory.

InstStub.exe    - CABSetup Installer Stub for multi-volume setups.
                  Runs the second stage setup (real NSIS package), deletes it
                  when it completes, and then deletes itself.

stubsetup.nsi   - NSIS script to launch InstStub.exe and the real NSIS
                  package.

_setup.nsi      - Example NSIS script of a real NSIS package that uses the
                  CABSetup plugin and is run by stubsetup.nsi

makesetup.nsi   - Example NSIS script for creating a setup cabinet file set.

Usage
-------
The CABSetup plug-in exposes three functions:

    BuildSetupFiles - for creating multi-volume/spanning datasets.
    Extract         - for installing the contents of a dataset.
    DataSetSize     - for determining the uncompressed size of a dataset.

BuildSetupFiles
---------------
BuildSetupFiles - constructs a Diamond Directive File (.DDF) for use with the
                  MAKECAB.EXE utility provided with Windows.

Windows XP and 2003 have MAKECAB installed by default, users of other Windows
versions may have to get it from either the SUPPORT.CAB file on the Windows CD
or from the Cabinet SDK from Microsoft.

If you have to install MAKECAB, ensure that it is available via your PATH
before using this function.

CABSetup should work with any version of MAKECAB.EXE.

Usage from NSIS is

    BuildSetupFiles /NOUNLOAD /CREATE "/DISKSIZE=xxxx" "/DISK1SIZE=xxxx" \
                                      "/DISKNAME=xxxx" "/CABNAME=xxxx" \
                                      "/DISKDIR=xxxx"  "/COMPRESS =xxxx" \
                                      "/DATASET=xxxx" \
                                      "/DATASETPATH=path" |
    BuildSetupFiles /NOUNLOAD "/ADD=C:\PROJECT\SOURCE\*.EXE" /S |
    BuildSetupFiles /NOUNLOAD /CLOSE |
    BuildSetupFiles /NOUNLOAD /MAKEFILES "/TARGET=path" |
    BuildSetupFiles /DESTROY |

NOTE:   It is very important that the plugin is not unloaded between calls to
        each function until the /DESTROY function is called.

        This is because the plug-in retains information in a function-global
        (local static) variable and this variable is re-initialised if the
        library is unloaded and reloaded.

    The /NOUNLOAD switch must not be present in the final call otherwise
    the NSIS will not be able to delete	the plugin and remove the $PLUGINS
    directory.

    The order that the parameters for an option appear in is not important, but
    the format of each option and the order of the options is.

The options are as follows (in the expected order of execution):

/CREATE -   starts the creation of a dataset.
            Creates the directive file and sets the parameters for the
            construction of the dataset.

            Many of the following parameters mirror directives that MAKECAB
            uses. For further information, consult the MAKECAB documentation.

    Parameters are as follows:

    /DISKSIZE   -   sets the size of each cabinet within the set in bytes.

                    Can be any number that is a multiple of 512, or one of the
                    following values:

                    CDROM  = 650MB
                    1.44M  = size of a 3 1/2" high density double-sided floppy
                    1.2M   = size of a 5 1/4 HD floppy
                    720K   = size of a 3 1/2" low density double-sided floppy
                    360K   = size of a 3 1/2" low density single-sided floppy

                    Default value is "CDROM".

    /DISK1SIZE  -   sets the size of the first cabinet within the set in bytes.
                    Allowed values are the same as for /DISKSIZE.

                    Setting this parameter will allow you to make room on the
                    first disk for the NSIS installer package.

                    This option is not set by default.

    /DISKNAME   -   sets the template for disk names created by the cabinet set.

                    If an asterisk is present in this field it is replaced
                    with the current disk number.

                    Default value is "SETUP#*".

    /CABNAME    -   set the template for the filenames for cabinets created by
                    the cabinet set.

                    If an asterisk is present in this field it is replaced with
                    the current cabinet number.

                    Default value is "DATA*.CAB".

    /DISKDIR    -   sets the template for the directories that the content of
                    each disk is held in.

                    Each disk contain will contain one cabinet file.

                    If an asterisk is present in this field it is replaced with
                    the current disk number.

                    Default value is "Disk*".

    /COMPRESS   -   specifies the compression algorithm to use for the
                    cabinets.

                    Valid values are "MSZIP", "LZX" and "None".

                    Note that LZX provides better compression, but MSZIP is
                    compatible with Windows NT/9x. Use MSZIP if you think your
                    installer may be used on Windows NT/9x.
                    
                    A value of "None" disables compression but files are still
                    stored in cabinets. This could be useful if the source files
                    are already compressed using another method.
                    
                    Default value is "LZX".

    /DATASET    -   specifies the name of the dataset.
                    This name is used for the filenames for the directive file
                    (.DDF), the report file (.RPT), and the information file
                    (.INF).
                    
                    Default value is "SETUP".
                    
    /DATASETPATH -  specifies the path that the dataset files are created
                    under.
                    
                    If the /TARGET parameter is not specified for the MAKEFILES
                    option, the cabinet set files and directories are created
                    under this directory.

                    Default value is ".\" (the current directory).

    /REPORTFILE -   specifies the path and filename of the summary report file
                    to create. The summary report file contains the dataset
                    size (both uncompressed and compressed).

/ADD    -   Adds files to a dataset.

            The value of this parameter is a fully qualified path to the files
            to add the dataset.

            The filename element can also be a file specification including
            wildcards '*' and '?'.

    Parameters are as follows:

    /S  -           specifies that the contents of all subdirectories of the
                    specified path that match the filespecc should also be
                    added to the dataset.

/CLOSE  -   Closes the directive file and prevents further entries to it.

            Ensure this call is made before using the MAKEFILES call.

/MAKEFILES  -   creates the dataset files from the directive file.

    Parameters are as follows:

    /TARGET -      specifies the path to place the dataset files in.

                   Subdirectories matching the DISKDIR template names will be
                   created under this path.

                   If this parameter is not specified, CABSetup will place the
                   dataset files under the path specified by the DATASETPATH
                   parameter of the CREATE switch.

/DESTROY    -   deletes CABSetup's internal structures for the creation of a
                dataset.

                As noted above, recommend that this call to CABSetup not
                include the /NOUNLOAD switch so that NSIS can delete $PLUGINS
                directory when the calling script completes.

If there is only one source directory, all of the options can be specified in
a single call to the BuildSetupFiles function providing that the options are
specified in the following order within the call and that any parameters
immediately follow the option they relate to:

        /CREATE
        /ADD
        /CLOSE
        /MAKEFILES
        /DESTROY

If an error occurs with this form, there may not be a clear indication where
the problem occurred - use with caution.

See the makesetup.nsi script for a (commented out) example of this usage of
BuildSetupFiles.

The ability to put all options in one call may not be preserved in a future
release of CABSetup.

Return value
------------
BuildSetupFile returns its status on the stack.
Possible return values include:
    0       - Success
    -1      - Out of memory (and can't return another error code)
    xxxx    - The value of GetLastError returned by one of the Windows
              functions or the return code from MAKECAB.EXE.
              Common values include 2 = File not found, 3 = path not found,
              and 5 = access denied and 1 = MAKECAB found a problem in the
              directive file.

If MAKECAB does not return 0, something went wrong, try running the command
given in the DetailLog manually and check for error messages.

Extract
-------
Usage from NSIS is

    Extract "/SOURCE=[path to setup files]\CABName" \
            "/Target=InstallDirectory" [/ALL] ["/FILE=filename"] \
            "/REPORTFILE=_path_and_filename"
            "/SHOWRATE" "/RESUME" |

    The order that the parameters appear in is not important, but the format
    of each option is.

    Extracts files or file from a dataset.

The options are as follows:

/SOURCE     -   specifies the fully qualified path and filename of the first
                cabinet to extract files from.

/TARGET     -   specifies the fully qualified path to extract the cabinet sets
                contents to. Do not include a filename.

/ALL        -   indicates that CABSetup should traverse all of the cabinets in
                a cabinet set when extracting all files.
                Currently does not work in conjunction with /FILE option.

/FILE       -   indicates a specific file within the cabinet to extract.

/REPORTFILE -   specifies the summary report file to use to determine the
                progress made in the extraction process.
                
/SHOWRATE   -   specifies that the rate at which data is being extracted
                and estimated completion time should be shown in the
                DetailText. Requires the /REPORTFILE option to be specified.
                
/RESUME     -   specifies that CABSetup should resume the extraction of a
                previous dataset. This is done by skipping the extraction of
                any files to be extracted that already exist in the target
                directory.

Extract will display a graphical prompt if it needs a different source media to
be provided to complete the extraction process.

Possible locations for the source media is read from the following registry
value (which Windows uses itself for locating drivers etc.):

    "HKLM\Software\Microsoft\Windows\CurrentVersion\Setup\Installation Sources"

Currently the only options are to extract all files in the setup file set or a
specific file.

If extracting a single file, you must specify the correct starting source
cabinet otherwise it won't locate the file. CABSetup will scan all subsequent
cabinets to extract the file if neccessary to completely extract the file. Use
the information file ("setup.inf" by default) to locate the cabinet a file is
located in. The "[file list]" section provides the mapping of disk and cabinets
to files.

Extract will attempt to create the target path if it does not exist.

If using the RESUME option, Extract cannot continue a dataset that has already
completed extraction over a cabinet boundary. For example, if the dataset
consists of two cabinets, and the extraction is cancelled after the contents
of the first cabinet have been completely extracted, using the RESUME option
will not resume the extraction of the dataset. Recommend that if you expect to
use the RESUME option, that the dataset be contained within a single cabinet.

Return value
------------
Extract returns its status on the stack.
Possible return values include:
    0       - Success
    -1      - Out of memory (and can't return another error code)
    995     - User cancelled a request for new source media or the entire
              Extract operation.
    xxxx    - The value of GetLastError returned by one of the Windows
              functions. Common values include 2 = File not found, 3 = path
              not found, and 5 = access denied.

DataSetSize
-----------
Usage from NSIS is

    DataSetSize /REPORTFILE=path_and_filename |

The options are as follows:

/REPORTFILE -   specifies the summary report file to use to determine the
                uncompressed size of the dataset.
                
                This is the .RPT file created by BuildSetupFiles.

Returns the uncompressed size of the dataset in bytes.

Return value
------------
DataSetSize returns its status and the dataset size on the stack.

Possible return values include:
    0       - Success
    -1      - Out of memory (and can't return another error code)
    xxxx    - The value of GetLastError returned by one of the Windows
              functions. Common values include 2 = File not found, 3 = path
              not found, and 5 = access denied.
              
If the status is 0 (Success), the dataset size is on the top of the stack.

InstStub.exe
------------
Usage is

    InstStub ChildProgram.exe

InstStub runs ChildProgram.exe as a separate process and waits for it to
complete.

Once the child proccess completes, InstStub deletes ChildProgram.exe
and then deletes itself.

********************************************************************************
WARNING:    Exercise extreme caution using this program, it will delete any
            program launched by it, including standard Windows programs without
            confirmation or warning (which it can launch since it searches the
            path if necessary to find the child program.)

			YOU HAVE BEEN WARNED.
********************************************************************************

This allows the multi-volume installer to copy the setup program off the first
removeable media and avoids problems where the installer need to access the
install executable from media that may no longer be available, but the
installer's author doesn't want to leave files behind on the target computer.

Stubsetup.nsi
-------------
NSIS script to create the 'SETUP.EXE' that uses InstStub.exe to create a NSIS
installer that can be used with a multi-volume installation.

The script creates an output file called 'SETUP.EXE' that includes the
InstStub.exe program and the 'real' installer, in a file called '_setup.exe'
(similar to the InstallShield process).

It then runs InstStub.exe from the temporary directory instructing it to run
the real installer and passes the path to the original SETUP.EXE's to it on the
command line.

This allows the real installer to determine the correct path for
any data files without having to determine which drive they should be on.

For example, if SETUP.EXE was run from a CD drive, then the real installer can
locate any neccessary cabinets on the same path.

The real NSIS installer must be in a file called '_setup.exe' and then compile
StubSetup.nsi with your real installer in the same directory as the script.

The resulting executable can then be copied to the first removable media
(floppy disk or CD image source path).

_setup.nsi
----------
Example NSIS script for the 'real' installer.

The example script provided includes a variation of comperio's GetParameters
code to allow the installer to locate the original SETUP.EXE's path by reading
it from the command line.

The example script also includes example code showing how to update the
section size to include the uncompressed dataset size.

makesetup.nsi
-------------
Example NSIS script to create the source cabinets for use with the CABSetup
plugin. Shows the usage and general sequence of all options of BuildSetupFiles.

Example Build Process (assuming that installer is complete)
-----------------------------------------------------------
1)  Build and test the NSIS installer package. Ensure that it produces
    "_setup.exe" as its output file.

2)  Place all of the files to be packaged into a single location. Include
    subdirectories if required, CabSetup will recreate the same directory
    structure (under the source path) during the Extract process.

3)  Tailor makesetup.nsi to include the required files from the source location
    in the cabinet set.
    Remember to allow enough room for the NSIS installer on disk 1 - you may
    need to repeat this step after creating the "setup.exe" file in step 6.
    Do not include the setup.exe in the package source files.

4)  Compile makesetup.nsi and run the resulting makesetup.exe. This will
    create the cabinet set containing the data files.

5)  Place the "_setup.exe" file created in step 1 in the same directory as
    stubsetup.nsi.

6)  Compile the stubsetup.nsi file. This should create a "setup.exe" file
    containing the InstStub.exe and your installer from step 1.

7)  Copy the contents of the first installation disk to the target installation
    media and copy the "setup.exe" file to the same disk.

8)  Copy the remaining cabinets to the appropriate target installation media.

9)  Ensure that the installation media have volume labels that match the labels
    generated by CABSetup e.g. SETUP#1. Check the [disk list] section of the
    setup.inf file in the directory with the cabinet files in it for the
    disk-number-to-label mapping.

10) Create the setup media i.e copy the cabinet files to floppy disks or
    burn the source media CDs/DVDs.

Compatibility Issues
--------------------
1)  InstStub.exe requires the PSAPI.DLL extension available on the PATH under
    Windows NT.

    Windows 2000, XP and 2003 have this extension available as part of standard
    install. This file can be copied from a Windows 2000/XP/2003 install to a
    Windows NT install without adverse effects. (I have not included a copy
    since it is Microsoft's code).

    InstStub.exe will also run under Windows 9x without any extensions.

2)  The CABSetup plugin requires Windows 95 or later for support of the
    SetupAPI functions it relies on.

3)  The SetupAPI library on Windows NT (SP6) and earlier does not support the
    LZX compression method - use MSZIP instead.

    Windows 2000 and later support the LZX compression method.

4)  The total size of files in a single cabinet set is 4GB (32 bit limit);
    MAKECAB crashes if it is given more than 4GB to compress.

    If the installer needs to hold more than 4GB of data, make multiple data
    sets with each set containing 4GB of data.

5)  The use of UNC roots for source or target paths is not currently supported.

    If you need to access networked resources, map a drive letter to the
    resource and use that to reference the files.

    (This may be resolved in a future release of CABSetup.)

6)  If InstStub.exe fails, the InstStub.exe and _setup.exe files are not
    removed from the target systems temporary directory; the parent installer
    should remove these files if it detects an error.
