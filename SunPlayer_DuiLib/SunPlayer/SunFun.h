#ifndef SUNFUN_H
#define SUNFUN_H
#include <Windows.h>
#include <string>
#include <vector>
using namespace std;

std::string GetAppPathA();

std::wstring GetAppPathW();

//ascii 转为 unicode
std::wstring StringToWString(std::string str);

//unicode 转为 ascii
std::string WStringToString(std::wstring str);

//utf8 转 Unicode
std::wstring UTF8ToWString(std::string str);

//Unicode 转 Utf8
std::string WStringToUTF8(std::wstring str);

//ascii 转 Utf8
std::string GBKToUTF8(std::string strGBK);

//utf-8 转 ascii
std::string UTF8ToGBK(std::string strUTF8);

std::string FormatString(const char *lpcszFormat, ...);

std::wstring FormatWstring(const wchar_t *lpcwszFormat, ...);

std::string replace(std::string str, std::string old_value,std::string new_value);

std::string GetMidString(std::string strSource, std::string strLeft, std::string strRight);

#endif