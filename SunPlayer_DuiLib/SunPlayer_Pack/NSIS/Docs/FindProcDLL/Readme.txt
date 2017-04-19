FindProcDLL ©2003 by iceman_k (Sunil Kamath), based upon the FIND_PROC_BY_NAME function written by Ravi Kochhar (http://www.physiology.wisc.edu/ravi/)


1. Introduction

  This plugin provides the ability to check if any process running just with the name of its .exe file.

    FindProc "process_name.exe"

  The return code is stored in the $R0 variable. 

The return codes are as follows:

   0   = Process was not found
   1   = Process was found
   605 = Unable to search for process
   606 = Unable to identify system type
   607 = Unsupported OS
   632 = Process name is invalid


2. Usage:

  Just copy the 'FindProcDLL.dll' in your NSIS plugins directory, and call the function with one of the two suggested syntax in the NSIS documentation:

    FindProcDLL::FindProc "process_name.exe"

OR

     ; Pre 2.0 syntax
    SetOutPath $TEMP
    GetTempFileName $8
    File /oname=$8 FindProcDLL.dll
    Push "process_name.exe"
    CallInstDLL FindProc

  $R0 will then hold the return value.

3. Copyright:

  The original source file for the FIND_PROC_BY_NAME function is included in this distribution. The file name is: exam38.cpp, and it MUST BE in this zip file. Other than that, you may use or modify this source code as you wish in any of your projects. However, you MUST include this file as well as the exam38.cpp file if you are distributing the original or modified source to anyone or anywhere.

4. Thanks:
Ravi for the FIND_PROC_BY_NAME function.
DITMan for his KillProcDLL Manual NSIS Plugin which inspired this plugin.
