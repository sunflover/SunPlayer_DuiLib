Name "UserMgr.dll Sample Installation Script"

OutFile "usermgr-sample.exe"

#
# Be careful when using these functions, especially the "Remove" and "Delete"
# commands!!!
#

Function .onInit
        # the plugins dir is automatically deleted when the installer exits
        InitPluginsDir

	UserMgr::CreateAccount "myuser" "mypassword" "A test user created by the UserMgr plugin"
	Pop $0
        MessageBox MB_OK "CreateUser Result : $0"

	UserMgr::AddToGroup  "myuser" "Administrators"
	Pop $0
        MessageBox MB_OK "AddToGroup Result : $0"

	UserMgr::SetRegKeyAccess "myuser" "HKLM" "SYSTEM\CurrentControlSet\Services\EventLog\Application\NTP" "=a"
	Pop $0
        MessageBox MB_OK "GrantAccess Result : $0"

	UserMgr::SetRegKeyAccess "myuser" "HKLM" "SYSTEM\CurrentControlSet\Services\EventLog\Application\NTP" "=r"
	Pop $0
        MessageBox MB_OK "RevokeWriteAccess Result : $0"

	UserMgr::SetRegKeyAccess "myuser" "HKLM" "SYSTEM\CurrentControlSet\Services\EventLog\Application\NTP" ""
	Pop $0
        MessageBox MB_OK "RevokeAccess Result : $0"

	UserMgr::DeleteAccount "myuser"
	Pop $0
        MessageBox MB_OK "DeleteUser Result: $0"

        #######################################################################

	UserMgr::CreateAccountEx "myuserA" "mypassword" "A test user created by the UserMgr plugin" "My User A" "A test user created by the UserMgr plugin" "UF_PASSWD_NOTREQD|UF_DONT_EXPIRE_PASSWD"
	Pop $0
        MessageBox MB_OK "CreateUser Result : $0"

	UserMgr::BuiltAccountEnv "myuserA" "mypassword"
	Pop $0
        MessageBox MB_OK "BuiltAccountEnv Result : $0"

	UserMgr::RegLoadUserHive "myuserA"
	Pop $0
        MessageBox MB_OK "RegLoadUserHive Result : $0"

        WriteRegStr HKEY_USERS "myuserA\Software\My Company\My Software" "String Value" "dead beef"

	UserMgr::RegUnLoadUserHive "myuserA"
	Pop $0
        MessageBox MB_OK "RegUnLoadUserHive Result : $0"

	UserMgr::ChangeUserPassword "myuserA" "mypassword" "mypasswordb"
	Pop $0
        MessageBox MB_OK "ChangeUserPassword Result : $0"

	UserMgr::SetUserInfo "myuserA" "PASSWORD" "mypasswordc"
	Pop $0
        MessageBox MB_OK "SetUserInfo PASSWORD Result : $0"

	UserMgr::DeleteAccount "myuserA"
	Pop $0
        MessageBox MB_OK "DeleteUser Result: $0"


FunctionEnd

Section
SectionEnd
