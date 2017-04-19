#=============================================================================#
#                                                                             #
#    "XiMoL NSIS contrib"                                                     #
#    Copyright (C) 2005 Florent Tournois                                      #
#                                                                             #
# This program is free software; you can redistribute it and/or               #
# modify it under the terms of the GNU General Public License                 #
# as published by the Free Software Foundation; either version 2              #
# of the License, or (at your option) any later version.                      #
#                                                                             #
# This program is distributed in the hope that it will be useful,             #
# but WITHOUT ANY WARRANTY; without even the implied warranty of              #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               #
# GNU General Public License for more details.                                #
#                                                                             #
# You should have received a copy of the GNU General Public License           #
# along with this program; if not, write to the Free Software                 #
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,                  #
# MA  02110-1301, USA.                                                        #
#                                                                             #
#=============================================================================#
!verbose push
!verbose 3

!ifndef XIMOL_NSH_
!define XIMOL_NSH_

; !define XIMOL_DEBUG

!ifdef XIMOL_DEBUG
	!define XIMOL_CALL XiMoLd
!else
	!define XIMOL_CALL XiMoL
!endif

#=============================================================================#
# internal variable for the error message
# if you are a user, we recommand to use the macro XiMoL_GetErrorMessage
#=============================================================================#
Var XiMoL_ErrorMessage
Var XiMoL_LastCall

#=============================================================================#
# Reset the XiMoL goto label for error handling
#=============================================================================#
!macro XiMoL_ResetErrorGotoLabel
	!verbose push
	!verbose 3

	!ifdef XIMOL_ERROR_GOTO_LABEL
		!undef XIMOL_ERROR_GOTO_LABEL
	!endif

	!verbose pop
!macroend

#=============================================================================#
# Set the XiMoL goto label for error handling
# If there is an error, then the execution will go to the label
#=============================================================================#
!macro XiMoL_SetErrorGotoLabel LABEL
	!verbose push
	!verbose 3

	!insertmacro XiMoL_ResetErrorGotoLabel
	!define XIMOL_ERROR_GOTO_LABEL "${LABEL}"

	!verbose pop
!macroend

#=============================================================================#
# Set the Last XiMoL call.
# Internal macro
#=============================================================================#
!macro XiMoL_SetLastCall TXT
	!verbose push
	!verbose 3

	StrCpy $XiMoL_LastCall "${TXT}"

	!verbose pop
!macroend

#=============================================================================#
# Get the Last XiMoL call.
#=============================================================================#
!macro XiMoL_GetLastCall VAR
	!verbose push
	!verbose 3

	StrCpy ${VAR} "$XiMoL_LastCall"

	!verbose pop
!macroend

#=============================================================================#
# Internal macro to manage error.
# If you are a XiMoL user do not use this macro.
# If an error is detect,
#    then the $XiMoL_ErrorMessage is update
#       and if XIMOL_ERROR_GOTO_LABEL is define
#                  the execution go to the label
#=============================================================================#
!macro XiMoL_CheckError RESULT
	!verbose push
	!verbose 3

	;MessageBox MB_OK "Begin check error input '${RESULT}'"
	StrCpy $XiMoL_ErrorMessage "${RESULT}" 5
	StrCmp "$XiMoL_ErrorMessage" "error" 0 +3
		StrCpy $XiMoL_ErrorMessage "${RESULT}" ; "" 7
		!ifdef XIMOL_ERROR_GOTO_LABEL
			Goto ${XIMOL_ERROR_GOTO_LABEL}
		!else
			Goto +2
		!endif

	StrCpy $XiMoL_ErrorMessage ""


	;MessageBox MB_OK "End of check error err_msg='$XiMoL_ErrorMessage'"

	!verbose pop
!macroend

#=============================================================================#
# Get the current error message from the module
#=============================================================================#
!macro XiMoL_GetErrorMessage VAR
	!verbose push
	!verbose 3

	StrCpy ${VAR} "$XiMoL_ErrorMessage"

	!verbose pop
!macroend

#=============================================================================#
# Read an xml File and get an handler to the data
#=============================================================================#
!macro XiMoL_ReadXmlFile HANDLER FILENAME
	!verbose push
	!verbose 3

	!insertmacro XiMoL_SetLastCall "XiMoL_ReadXmlFile '${HANDLER}' '${FILENAME}'"
	${XIMOL_CALL}::ReadXmlFile /NOUNLOAD "${FILENAME}"
	Pop ${HANDLER}
	!insertmacro XiMoL_CheckError "${HANDLER}"

	!verbose pop
!macroend

#=============================================================================#
# get the tag
#=============================================================================#
!macro XiMoL_GetTag HANDLER TAG
	!verbose push
	!verbose 3

	!insertmacro XiMoL_SetLastCall "XiMoL_GetTag '${HANDLER}' '${TAG}'"
	${XIMOL_CALL}::GetTag /NOUNLOAD "${HANDLER}"
	Pop ${TAG}
	!insertmacro XiMoL_CheckError "${TAG}"

	!verbose pop
!macroend

#=============================================================================#
# get the content
#=============================================================================#
!macro XiMoL_GetContent HANDLER CONTENT
	!verbose push
	!verbose 3

	!insertmacro XiMoL_SetLastCall "XiMoL_GetContent '${HANDLER}' '${CONTENT}'"
	${XIMOL_CALL}::GetContent /NOUNLOAD "${HANDLER}"
	Pop ${CONTENT}
	!insertmacro XiMoL_CheckError "${CONTENT}"

	!verbose pop
!macroend

#=============================================================================#
# get an handler from an element
#=============================================================================#
!macro XiMoL_GetElementFromPath HANDLER PATH NEW_HANDLER
	!verbose push
	!verbose 3

	!insertmacro XiMoL_SetLastCall "XiMoL_GetElementFromPath '${HANDLER}' '${PATH}' '${NEW_HANDLER}'"
	${XIMOL_CALL}::GetElementFromPath /NOUNLOAD "${HANDLER}" "${PATH}"
	Pop ${NEW_HANDLER}
	!insertmacro XiMoL_CheckError "${NEW_HANDLER}"

	!verbose pop
!macroend

#=============================================================================#
# get an handler from an element
#=============================================================================#
!macro XiMoL_IfPathExists HANDLER PATH GOTO_IF_PATH_EXISTS GOTO_IF_NOT
	!verbose push
	!verbose 3

	!insertmacro XiMoL_SetLastCall "XiMoL_IfPathExist '${HANDLER}' '${PATH}' '${GOTO_IF_PATH_EXISTS}' 'GOTO_IF_NOT'"
	${XIMOL_CALL}::GetElementFromPath /NOUNLOAD "${HANDLER}" "${PATH}"
	Pop $XiMoL_ErrorMessage
	StrCpy $XiMoL_ErrorMessage "$XiMoL_ErrorMessage" 5
	StrCmp "$XiMoL_ErrorMessage" "error" 0 +3
		StrCpy $XiMoL_ErrorMessage ""
		Goto ${GOTO_IF_NOT}

	StrCpy $XiMoL_ErrorMessage ""
	Goto ${GOTO_IF_PATH_EXISTS}

	!verbose pop
!macroend

#=============================================================================#
# get the number of attributes
#=============================================================================#
!macro XiMoL_GetNumberOfAttributes HANDLER NB
	!verbose push
	!verbose 3

	!insertmacro XiMoL_SetLastCall "XiMoL_GetNumberOfAttributes '${HANDLER}' '${NB}'"
	${XIMOL_CALL}::GetNumberOfAttributes /NOUNLOAD "${HANDLER}"
	Pop ${NB}
	!insertmacro XiMoL_CheckError "${NB}"

	!verbose pop
!macroend

#=============================================================================#
# get the attribute name
#=============================================================================#
!macro XiMoL_GetAttributeName HANDLER NB NAME
	!verbose push
	!verbose 3

	!insertmacro XiMoL_SetLastCall "XiMoL_GetAttributeName '${HANDLER}' '${NB}' '${NAME}'"
	${XIMOL_CALL}::GetAttributeName /NOUNLOAD "${HANDLER}" "${NB}"
	Pop ${NAME}
	!insertmacro XiMoL_CheckError "${NAME}"

	!verbose pop
!macroend

#=============================================================================#
# get the value of an attribute
#=============================================================================#
!macro XiMoL_GetAttributeValue HANDLER ATTRIBUTE_NAME VALUE
	!verbose push
	!verbose 3

	!insertmacro XiMoL_SetLastCall "XiMoL_GetAttributeValue '${HANDLER}' '${ATTRIBUTE_NAME}' '${VALUE}'"
	${XIMOL_CALL}::GetAttributeValue /NOUNLOAD "${HANDLER}" "${ATTRIBUTE_NAME}"
	Pop ${VALUE}
	!insertmacro XiMoL_CheckError "${VALUE}"

	!verbose pop
!macroend

#=============================================================================#
# get the next element
#=============================================================================#
!macro XiMoL_GetNextElement HANDLER GOTO_IF_SUCCES
	!verbose push
	!verbose 3

	!insertmacro XiMoL_SetLastCall "XiMoL_GetNextElement '${HANDLER}' '${GOTO_IF_SUCCES}'"
	${XIMOL_CALL}::GetNextElement /NOUNLOAD "${HANDLER}"
	Pop $XiMoL_ErrorMessage
	Push $XiMoL_ErrorMessage
	!insertmacro XiMoL_CheckError "$XiMoL_ErrorMessage"
	Pop $XiMoL_ErrorMessage
	StrCmp $XiMoL_ErrorMessage "succes" 0 +3
		StrCpy $XiMoL_ErrorMessage ""
		Goto ${GOTO_IF_SUCCES}


	StrCpy $XiMoL_ErrorMessage ""
	!verbose pop
!macroend

#=============================================================================#
# get the number of element
#=============================================================================#
!macro XiMoL_GetNumberOfElements HANDLER NB
	!verbose push
	!verbose 3

	!insertmacro XiMoL_SetLastCall "XiMoL_GetNumberOfElements '${HANDLER}' '${NB}'"
	${XIMOL_CALL}::GetNumberOfElements /NOUNLOAD "${HANDLER}"
	Pop ${NB}
	!insertmacro XiMoL_CheckError "${NB}"

	!verbose pop
!macroend

#=============================================================================#
# get the element name
#=============================================================================#
!macro XiMoL_GetElementName HANDLER NB NAME
	!verbose push
	!verbose 3

	!insertmacro XiMoL_SetLastCall "XiMoL_GetElementName '${HANDLER}' '${NB}' '${NAME}'"
	${XIMOL_CALL}::GetElementName /NOUNLOAD "${HANDLER}" "${NB}"
	Pop ${NAME}
	!insertmacro XiMoL_CheckError "${NAME}"

	!verbose pop
!macroend

#=============================================================================#
# get an handler from an element
#=============================================================================#
!macro XiMoL_GetElement HANDLER NB NEW_HANDLER
	!verbose push
	!verbose 3

	!insertmacro XiMoL_SetLastCall "XiMoL_GetElementName '${HANDLER}' '${NB}' '${NEW_HANDLER}'"
	${XIMOL_CALL}::GetElement /NOUNLOAD "${HANDLER}" "${NB}"
	Pop ${NEW_HANDLER}
	!insertmacro XiMoL_CheckError "${NEW_HANDLER}"

	!verbose pop
!macroend

!endif ; ifndef XIMOL_NSH_
!verbose pop
