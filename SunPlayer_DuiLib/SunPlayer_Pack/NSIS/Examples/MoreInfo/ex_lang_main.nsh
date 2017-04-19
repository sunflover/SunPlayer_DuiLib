# Macros used to simplify inclusion/selection of the necessary language files
# in multilanguage installers and customized forms installers
# Thanks to the NSIS forum and http://popfile.sourceforge.net/ for a lot of the good ideas,
# I had these myself in the first place, but conformation made the work easier.

!ifndef SET_DEFAULT_VERBOSE
  !verbose 3
!endif

# Used in the 'ex_lang_{LANGUAGEHERE}.nsh' files to define the text strings for the installer
!macro EXTENDED_LANG_STRING NAME VALUE
  LangString ${NAME} ${LANG_${EXTENDED_LANG}} "${VALUE}"
!macroend

# Used in the 'ex_lang_{LANGUAGEHERE}.nsh' files to define the text strings for the un-installer
!macro EXTENDED_LANG_STRING_UN NAME VALUE
  LangString "un.${NAME}" ${LANG_${EXTENDED_LANG}} "${VALUE}"
!macroend

# Macro used to load the files required for each language:
# Step1: The MUI_LANGUAGE macro loads the standard MUI text strings for a particular language
# Step2: The 'ex_lang_{LANGUAGEHERE}.nsh' contains the text strings used for pages, custom pages etc.

!macro MUI_LANGUAGE_EXTENDED LANG
  !insertmacro MUI_LANGUAGE "${LANG}"
  !include "languages\ex_lang_${LANG}.nsh"
!macroend

# Used in 'ex_lang_{LANGUAGEHERE}.nsh' files to define the text strings for fields in a custom page INI file

!macro EXTENDED_LANG_IO_TEXT PATH FIELD TEXT
  WriteINIStr "$PLUGINSDIR\${PATH}" "Field ${FIELD}" "Text" "${TEXT}"
!macroend

# Used in 'ex_lang_{LANGUAGEHERE}.nsh' files to define entries in [Settings] section of a custom page INI file

!macro EXTENDED_LANG_IO_SETTING PATH FIELD TEXT
  WriteINIStr "$PLUGINSDIR\${PATH}" "Settings" "${FIELD}" "${TEXT}"
!macroend

# Symbols used to avoid confusion over where the line breaks occur.
# (normally these symbols will be defined before this file is 'included')
#
# ${IO_NL} is used for InstallOptions-style 'New Line' sequences.
# ${MB_NL} is used for MessageBox-style 'New Line' sequences.

!ifndef IO_NL
  !define IO_NL     "\r\n"
!endif

!ifndef MB_NL
  !define MB_NL     "$\r$\n"
!endif

# Languages inclusive the text one added self
!insertmacro MUI_LANGUAGE_EXTENDED "English" # first language is the default language

# Used in multi-language scripts to define the languages to be supported
!include ex_lang_add.nsh

# End of script