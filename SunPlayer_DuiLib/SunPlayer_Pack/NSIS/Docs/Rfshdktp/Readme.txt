RfshDktp plug-in

Description :
The refresh desktop plugin does just what it says. A few people said they were able to do it using a SendMessage but that never seemed to work for what I needed it for. From time to time Windows seemed to have a bug when creating a desktop shortcut. It would cause an extra shortcut to show up on the desktop that wasn't valid. Hitting F5 or right-clicking and choosing Refresh always made it go away so I made this DLL to handle that. 

Usage :

rfshdktp::refreshDesktop




Or you can used this instead:

System::Call 'shell32::SHChangeNotify(i, i, i, i) v (0x08000000, 0, 0, 0)'
