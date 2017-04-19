//MyOutputDebugString.h 
#ifndef MY_OUTPUTDEBUGSTRING_H
#define MY_OUTPUTDEBUGSTRING_H


//使用示例：MyOutputDebugStringA("%d,%s",123,"hello");
void MyOutputDebugStringA(const char * lpcszOutputString, ...);

//使用示例：MyOutputDebugStringW(L"%d,%s",456,L"world!");
void MyOutputDebugStringW(const wchar_t * szOutputString,...);

#endif