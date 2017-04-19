// stdafx.h : 标准系统包含文件的包含文件，
// 或是经常使用但不常更改的
// 特定于项目的包含文件
//

#pragma once

#include "targetver.h"

#define WIN32_LEAN_AND_MEAN             //  从 Windows 头文件中排除极少使用的信息
// Windows 头文件: 
#include <windows.h>

// C 运行时头文件
#include <stdlib.h>
#include <malloc.h>
#include <memory.h>
#include <tchar.h>


// TODO:  在此处引用程序需要的其他头文件
#include "Resource.h"
#ifdef _DEBUG
#include "vld.h"
#endif

#include "SunFun.h"
#include "MyOutputDebugString.h"

#include "../ffplayer/ffplayer.h"

#include "../DuiLib/UIlib.h"
using namespace DuiLib;

#define PROGRESSTIMER						666

#define safe_delete(p) do{ delete p; p=NULL; } while(false) 
