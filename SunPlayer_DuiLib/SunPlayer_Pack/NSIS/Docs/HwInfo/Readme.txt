HwInfo

We recently created an NSIS plugin at my work (3DNA, www.3dna.net) to detect various system information. This is excellent for running a hardware check before installing files and comparing the results against the requirements for running you're program. If the results are below you're spec you can display a warning message or take other appropriate action. 

There is a second or two wait as system stats are detected. The Banner plugin is useful here to display some kind of message as the information is gathered. 


Currently the function list for the DLL includes: 

GetCpuSpeed 
If the CPU speed is greater than 1 Ghz, the Ghz and Mhz are also available in separate variables. Given a speed of say 1.4 Ghz, $0 would contain "1.4", "1" would be stored in $1 and "400" would be stored in $2. 
GetCpuNameAndSpeed 
Returns the name and speed of the CPU as something like "AMD Duron, ~1004 Mhz" 
GetSystemMemory 
Amount of system memory in MB. 
GetVideoCardName 
Name of the video card on the installing system. Something like "ATI Radeon 9800" 
GetVideoCardMemory 
Amount of video memory in MB. 
Most of the info is taken from functions out of the DirectX API. The functions return essentially what you see when you run dxdiag. There are special exceptions such as determining the CPU speed. 
