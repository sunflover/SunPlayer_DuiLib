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
!include "MUI.nsh"
!include "XiMoL.nsh"
Name "XiMoL Example 1"
OutFile "example1.exe"

!insertmacro MUI_PAGE_INSTFILES

Var XmlHandlerRoot
Var XmlHandler
Var msg

!macro PRINT_TAG_CONTENT HANDLER
    !define LOCAL_NB ${__LINE__}
    StrCpy $msg ""
    !insertmacro XiMoL_GetTag ${HANDLER} $0
    StrCpy $msg "tag=$0$\r$\n"
    !insertmacro XiMoL_GetContent ${HANDLER} $0
    StrCpy $msg "$msg$\tcontent=$0$\r$\n"
    !insertmacro XiMoL_GetNumberOfAttributes ${HANDLER} $0
    StrCpy $msg "$msg$\tnumber of attributes=$0$\r$\n"
    StrCmp "$0" "0" read_att_${LOCAL_NB}_end

    StrCpy $1 0
    read_att_${LOCAL_NB}:
    !insertmacro XiMoL_GetAttributeName ${HANDLER} $1 $2
    !insertmacro XiMoL_GetAttributeValue ${HANDLER} $2 $3
    StrCpy $msg "$msg$\t$2=$3$\r$\n"
    IntOp $1 $1 + 1
    IntCmp $1 $0 "" read_att_${LOCAL_NB}
    read_att_${LOCAL_NB}_end:

    !insertmacro XiMoL_GetNumberOfElements ${HANDLER} $0
    StrCpy $msg "$msg$\tnumber of elements=$0$\r$\n"

    StrCmp "$0" "0" read_el_${LOCAL_NB}_end
    StrCpy $1 0
    read_el_${LOCAL_NB}:
    !insertmacro XiMoL_GetElementName ${HANDLER} $1 $2
    StrCpy $msg "$msg$\telement$1=$2$\r$\n"
    IntOp $1 $1 + 1
    IntCmp $1 $0 "" read_el_${LOCAL_NB}
    read_el_${LOCAL_NB}_end:

    !undef LOCAL_NB
    MessageBox MB_OK "$msg"
!macroend

Section "Dummy Section" SecDummy

	MessageBox MB_OK "Avant"
    !define XIMOL_ERROR_GOTO_LABEL xml_error_handler
    !insertmacro XiMoL_ReadXmlFile $XmlHandlerRoot "test1.xml"
	!insertmacro PRINT_TAG_CONTENT $XmlHandlerRoot
    !insertmacro XiMoL_GetElementFromPath $XmlHandlerRoot "DevKits/Kit/" $XmlHandler
	!insertmacro PRINT_TAG_CONTENT $XmlHandler
    !insertmacro XiMoL_GetElementFromPath $XmlHandlerRoot "DevKits/Kit/Package/" $XmlHandler
    Print_element:
    !insertmacro PRINT_TAG_CONTENT $XmlHandler
    !insertmacro XiMoL_GetNextElement $XmlHandler Print_element

    Goto end
    xml_error_handler:
        !insertmacro XiMoL_GetLastCall $1
        !insertmacro XiMoL_GetErrorMessage $0
        MessageBox MB_OK "XML error: $0$\r$\nLast Call: $1"

    end:
SectionEnd
