// SunPlayer.cpp : 定义应用程序的入口点。
//

#include "stdafx.h"
#include "SunPlayer.h"
#include "MainFrameWnd.h"

void InitResource();

int APIENTRY _tWinMain(_In_ HINSTANCE hInstance, _In_opt_ HINSTANCE hPrevInstance, _In_ LPTSTR lpCmdLine,_In_ int nCmdShow)
{
	UNREFERENCED_PARAMETER(hPrevInstance);
	UNREFERENCED_PARAMETER(lpCmdLine);

 	// TODO:  在此放置代码。
	CoInitialize(NULL);
	OleInitialize(NULL);
	// 初始化UI管理器
	CPaintManagerUI::SetInstance(hInstance);
	// 初始化资源
	InitResource();

	CMainFrameWnd* pFrame = new CMainFrameWnd();
	pFrame->Create(NULL, _T("SunPlayer"), UI_WNDSTYLE_FRAME, WS_EX_STATICEDGE | WS_EX_APPWINDOW);
	::ShowWindow(*pFrame, SW_SHOW);
	CPaintManagerUI::MessageLoop();

	CResourceManager::GetInstance()->Release();

	OleUninitialize();
	CoUninitialize();


	return 0;
}

void InitResource()
{
	// 资源类型
#ifdef _DEBUG
	CPaintManagerUI::SetResourceType(UILIB_FILE);
#else
	CPaintManagerUI::SetResourceType(UILIB_ZIPRESOURCE);
#endif
	// 加载资源
	switch (CPaintManagerUI::GetResourceType())
	{
	case UILIB_FILE:
	{
		// 资源路径
		CDuiString strResourcePath = CPaintManagerUI::GetInstancePath();
		strResourcePath += _T("Res\\");
		CPaintManagerUI::SetResourcePath(strResourcePath.GetData());
		break;
	}
	case UILIB_ZIPRESOURCE:
	{
		HRSRC hResource = ::FindResource(CPaintManagerUI::GetResourceDll(), MAKEINTRESOURCE(IDR_ZIPRES), _T("ZIPRES"));
		if (hResource != NULL)
		{
			HGLOBAL hGlobal = ::LoadResource(CPaintManagerUI::GetResourceDll(), hResource);
			if (hGlobal != NULL)
			{
				DWORD dwSize = ::SizeofResource(CPaintManagerUI::GetResourceDll(), hResource);
				if (dwSize > 0)
				{
					CPaintManagerUI::SetResourceZip((LPBYTE)::LockResource(hGlobal), dwSize);
				}
			}
			::FreeResource(hResource);
		}
		break;
	}
	}
}