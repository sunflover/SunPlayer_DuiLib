//MyOutputDebugString.cpp
#include <Windows.h>
#include <stdlib.h>
#include <stdarg.h>
#include <vector>
using namespace std;

#define MYPRINT

void MyOutputDebugStringA(const char * lpcszOutputString, ...)
{
#ifdef MYPRINT
	string strResult;
	if (NULL != lpcszOutputString)
	{
		va_list marker = NULL;
		va_start(marker, lpcszOutputString); //初始化变量参数
		size_t nLength = _vscprintf(lpcszOutputString, marker) + 1; //获取格式化字符串长度
		std::vector<char> vBuffer(nLength, '\0'); //创建用于存储格式化字符串的字符数组
		int nWritten = _vsnprintf_s(&vBuffer[0], vBuffer.size(), nLength, lpcszOutputString, marker);
		if (nWritten>0)
		{
			strResult = &vBuffer[0];
		}
		va_end(marker); //重置变量参数
	}
	if (!strResult.empty())
	{
		string strFormated = "[sunflover] ";
		strFormated.append(strResult);
		OutputDebugStringA(strFormated.c_str());
	}	
#endif
}

void MyOutputDebugStringW(const wchar_t * lpcwszOutputString, ...)
{
#ifdef MYPRINT
	wstring strResult;
	if (NULL != lpcwszOutputString)
	{
		va_list marker = NULL;
		va_start(marker, lpcwszOutputString); //初始化变量参数
		size_t nLength = _vscwprintf(lpcwszOutputString, marker) + 1; //获取格式化字符串长度
		std::vector<wchar_t> vBuffer(nLength, L'\0'); //创建用于存储格式化字符串的字符数组
		int nWritten = _vsnwprintf_s(&vBuffer[0], vBuffer.size(), nLength, lpcwszOutputString, marker);
		if (nWritten>0)
		{
			strResult = &vBuffer[0];
		}
		va_end(marker); //重置变量参数
	}
	if (!strResult.empty())
	{
		wstring strFormated = L"[sunflover] ";
		strFormated.append(strResult);
		OutputDebugStringW(strFormated.c_str());
	}	
#endif
}
