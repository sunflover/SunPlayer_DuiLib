/*
Email地址格式校验插件示例
by Ansifa
*/
OutFile "Email validation Test.EXE"
Name "Email validation Test"
Section
EmailValidation::EmailValidation pippo@gino.com
pop $R0
StrCmp $R0 "failed" +1 +3
MessageBox MB_OK 'Email地址格式不正确'
Goto +2
MessageBox MB_OK 'Email地址格式正确'
SectionEnd
