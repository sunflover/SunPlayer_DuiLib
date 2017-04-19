###########################################################################
#
# ex_lang_add.nsh
#
# This 'include' file lists the non-English languages currently supported by
# this installer.
#
# Make sure that !insertmacro MUI_LANGUAGE_EXTENDED "English" has been used to define "English"
# before including this file (which is why "English" does not appear in the list below).
# Currently a subset of the languages supported by NSIS MUI 2.0 (using the NSIS names)
;
###########################################################################
# Adding support for a particular language (it must be supported by NSIS):
#
# The number of languages which can be supported depends upon the availability of:
#
#     (1) an up-to-date main NSIS language file ({NSIS}\Contrib\Language files\*.nlf)
# and
#     (2) an up-to-date NSIS MUI Language file ({NSIS}\Contrib\Modern UI\Language files\*.nsh)
#
# To add support for a language which is already supported by the NSIS MUI package, two files
# are required:
#
#   ex_lang_mui_<NSIS Language NAME>.nsh  - holds customised versions of the standard MUI text strings
#                                   (eg removing the 'reboot' reference from the 'Welcome' page)
#
#   ex_lang_<NSIS Language NAME>.nsh  - holds strings used on the custom pages and elsewhere
#
# Once these files have been prepared and placed in the 'windows\extendedlang' directory with the
# other *_mui.nsh and *_ex.nsh files, add a new '!insertmacro EXTENDED_LANG_LOAD' line to load these
# two new files and, if there is a suitable script UI language file for the new language,
# add a suitable '!insertmacro UI_LANG_CONFIG' line in the section which handles the optional
# 'Languages' component to allow the installer to select the appropriate UI language.
###########################################################################
#
# Removing support for a particular language:
#
# To remove any of the additional languages, only TWO lines need to be commented-out:
#
# (a) comment-out the relevant '!insertmacro MUI_LANGUAGE_EXTENDEDD' line in the list of languages
#     in the 'Language Support for the installer and uninstaller' block of code
#
# NOT IMPLEMENTED YET
# (b) comment-out the relevant '!insertmacro UI_LANG_CONFIG' line in the list of languages
#     in the code which handles the 'UI Languages' component
#
# For example, to remove support for the 'Dutch' language, comment-out the line
#
#     !insertmacro MUI_LANGUAGE_EXTENDED "Dutch"
#
# in the list of languages supported by the installer, and comment-out the line
#
#     !insertmacro UI_LANG_CONFIG "DUTCH" "Nederlands"
#
# in the code which handles the 'UI Languages' component (Section "Languages").
#
###########################################################################

!insertmacro MUI_LANGUAGE_EXTENDED "Dutch"

; Languages below not included in this demo, feel free to create them based
; om the "ex_lang_English.nsh" file, it's simple!

;!insertmacro MUI_LANGUAGE_EXTENDED "French"
;!insertmacro MUI_LANGUAGE_EXTENDED "Spanish"
;!insertmacro MUI_LANGUAGE_EXTENDED "Turkish"

###########################################################################
# End of 'ex_lang_add.nsh'
###########################################################################
