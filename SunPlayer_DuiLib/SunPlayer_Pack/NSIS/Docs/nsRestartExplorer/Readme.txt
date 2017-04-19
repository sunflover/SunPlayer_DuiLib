NSIS Plugin to Start, Quit and gracefully Restart Explorer

Copyright (c) 2008 Gianluigi Tiesi <sherpya@netfarm.it>

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU Library General Public
License as published by the Free Software Foundation; either
version 2 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Library General Public License for more details.
You should have received a copy of the GNU Library General Public
License along with this software; if not, write to the
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

It can be called within a NSIS setup or standalone using rundll32
This plugin is useful to replace Shell Extensions without doing a reboot,
you can also use it from rundll32 when explorer does strange things
like when it does not auto-hide the taskbar.

Usage:

[NSIS]:
- put the plugin in NSIS Plugin directory
- in your setup source add:
  nsRestartExplorer::nsRestartExplorer action timeout [kill]

[RunDll32]:
- put the plugin in a place where rundll32 can find it
- call rundll32 nsRestartExplorer,nsRE action timeout [kill]

[arguments]:
action:
- start    -> start explorer
- quit     -> quit explorer
- restart  -> restart explorer

timeout:
- infinite -> wait until the process is started/stopped
- ignore   -> do not wait at all
- #        -> milliseconds to wait

kill (optional):
- if specified and quit timeouts attempt to kill explorer

[notes]
- Please look at the example nsRestart.nsi
- arguments are not case sensitive, i.e. you can use start or START
- I've tested it on Win9x, WinXP SP2 and WinXP SP2 64bit,
  it should work with all versions of Windows, no infos about Vista
- MinGW executable is smaller since it uses system msvcrt so it's
  suitable for small installations
