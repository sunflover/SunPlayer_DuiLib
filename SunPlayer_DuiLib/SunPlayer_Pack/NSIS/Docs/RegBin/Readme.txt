RegBin.dll - NSIS extension DLL
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Writes an arbitrarily large binary value (which can be set at runtime) to the Windows Registry.
This overcomes two shortcomings of the standard WriteRegBin command:
a) Binary values have to specified at compile-time.
b) Maximum size of the value is 511 bytes.

See Example.nsi for a usage example.

Usage
~~~~~

1) Call writeRegBin to write the data in one step. Max value size is 511 bytes.
           -or-
2) Call init to initialize the registry information and the buffer.
3) Call append to add to the buffer.
4) Optional - repeat steps 3 to append as many times as desired.
5) Call write to write the data to the registry.

Notes
~~~~~

* init and append functions MUST be called with /NOUNLOAD so that the buffer does not get lost. 

* This plugin requires NSIS 2.0b3 and above.

* All functions return "success" and "error" on success and error, respectively (duh!).


Available functions
~~~~~~~~~~~~~~

1. init root_key subkey valuename valuedata

   root_key must be one of:
    
   * HKCR or HKEY_CLASSES_ROOT
   * HKLM or HKEY_LOCAL_MACHINE
   * HKCU or HKEY_CURRENT_USER
   * HKU or HKEY_USERS
   * HKCC or HKEY_CURRENT_CONFIG
   * HKDD or HKEY_DYN_DATA
   * HKPD or HKEY_PERFORMANCE_DATA
    
   valuedata is in hexadecimal (e.g. DEADBEEF01223211151). 
    
2. append valuedata    
    
   See init for valuedata description. 
    
3. write valuedata
    
   valuedata is in hexadecimal (e.g. DEADBEEF01223211151). 

4. writeRegBin root_key subkey valuename valuedata

   See init for parameters description.


Credits
~~~~~~~

Coded by Sunil Kamath, aka iceman_k/icemank
