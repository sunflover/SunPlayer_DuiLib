#pragma once
#include "stdafx.h"
#include <vector>
using namespace std;

class CFileUtil
{
public:
	CFileUtil(void);
	~CFileUtil(void);
public:

	//打开对话框 lpstrFilter：过滤字符串   hwndOwner：父窗口  fileNames：完整文件路径;使用示例CFileUtil::OpenFile(L"mp3文件\0*.mp3\0", m_hWnd, m_VecFileNames);
	static BOOL OpenFile(LPCWSTR lpstrFilter, HWND hwndOwner,vector<CDuiString> &fileNames, bool IsMulti = true);

	//浏览文件夹 path：路径  hwndOwner:父窗口  tile:窗口标题
	static BOOL BrowseDir(CDuiString &path,HWND hwndOwner,CDuiString title);

	//打开一个路径并选中一个文件
	static void OpenDir(HWND hwndOwner,CDuiString path,CDuiString fileName);
};

