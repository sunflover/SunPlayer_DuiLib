EmbedHTML NSIS plug-in

Author:  Stuart 'Afrow UK' Welch
Company: Afrow Soft Ltd
Date:    19th October 2014
Version: 1.0.0.1

Embeds an HTML document anywhere in the installer window.

See Examples\EmbedHTML\*

------------------------------------------------------------------------
Dependencies
------------------------------------------------------------------------

An Internet Explorer IWebBrowser2 control is used to display the HTML
document. By default, the newest installed version of IE will be used
to display the document.

This plug-in is written in C++ and has been statically linked against
its dependent Microsoft Visual C Runtime v110. Therefore you do not need
to distribute MSVCR110.dll in your installer to use this plug-in.

------------------------------------------------------------------------
Possible Crash
------------------------------------------------------------------------

Do not load a web page that uses the setTimeout() JavaScript function.
At time of writing there is an IE bug which causes the installer to
crash if setTimeout() calls a function after the IWebBrowser2 control
has been closed/disposed. An example is the Google homepage.

For more information, see:
http://answers.microsoft.com/en-us/ie/forum/ie11-windows_7/ieframedll-application-crashes-caused-by-kb2977629/de92c06f-8962-46e7-b38e-3d49dc21e6ea

------------------------------------------------------------------------
Functions
------------------------------------------------------------------------

EmbedHTML::Load [/replace] [/nomaxem] hwnd path_or_url

Loads the HTML (path_or_url) document over the window with the specified
handle (hwnd).

Optionally specify /replace if you wish the HTML document window to
replace the specified window (thus destroying it).

Optionally specify /nomaxem to disable maximum browser emulation. The
default operating system IE version will be used to display the HTML
instead (typically IE7).

The plug-in handles document unloading and cleanup automatically either
when Next or Back is clicked or when the installer window is closed.

The error flag is set if the document could not be loaded.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

EmbedHTML::GetIEVersion
Pop $Var

A utility function to get the installed Internet Explorer version. This
is fetched from the Windows registry.

------------------------------------------------------------------------
Change Log
------------------------------------------------------------------------

1.0.0.1 - 19th October 2014
* Now suppresses JavaScript errors.
* Now uses default IE settings rather than user-configured settings.

1.0.0.0 - 18th October 2014
* First version.

------------------------------------------------------------------------
License
------------------------------------------------------------------------

This plug-in is provided 'as-is', without any express or implied
warranty. In no event will the author be held liable for any damages
arising from the use of this plug-in.

Permission is granted to anyone to use this plug-in for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this plug-in must not be misrepresented; you must not
   claim that you wrote the original plug-in.
   If you use this plug-in in a product, an acknowledgment in the
   product documentation would be appreciated but is not required.
2. Altered versions must be plainly marked as such, and must not be
   misrepresented as being the original plug-in.
3. This notice may not be removed or altered from any distribution.