#include "stdafx.h"
#include "MainFrameWnd.h"
#include "FileUtil.h"


CMainFrameWnd *g_pMainWnd;

CMainFrameWnd::CMainFrameWnd()
	:m_bMove(false),
	m_LPoint({0,0}),
	m_nAudioVolume(182),
	m_bMaxed(false),
	m_pMenu(NULL)
{
	g_pMainWnd = this;
}


CMainFrameWnd::~CMainFrameWnd()
{
}

void CMainFrameWnd::InitWindow()
{
	SetIcon(IDI_SUNPLAYER);
	CenterWindow();

	//init control pointer
	m_pAreaTitle = (CHorizontalLayoutUI *)m_pm.FindControl(_T("areaTitle")); ASSERT(m_pAreaTitle);
	m_pAreaPlay = (CHorizontalLayoutUI *)m_pm.FindControl(_T("areaPlay")); ASSERT(m_pAreaPlay);
	m_pAreaLogo = (CVerticalLayoutUI *)m_pm.FindControl(_T("areaLogo")); ASSERT(m_pAreaLogo);
	m_pAreaCtrl = (CHorizontalLayoutUI *)m_pm.FindControl(_T("areaCtrl")); ASSERT(m_pAreaCtrl);

	m_pLblTime = (CLabelUI *)m_pm.FindControl(_T("lblTime")); ASSERT(m_pLblTime);
	m_pSliderPlay = (CSliderUI *)m_pm.FindControl(_T("sliderPlay")); ASSERT(m_pSliderPlay);
	m_pSliderVolume = (CSliderUI *)m_pm.FindControl(_T("sliderVolume")); ASSERT(m_pSliderVolume);
	m_pLblTitle = (CLabelUI *)m_pm.FindControl(_T("lblTitle")); ASSERT(m_pLblTitle);
	m_pBtnPlay = (CButtonUI *)m_pm.FindControl(_T("btnPlay")); ASSERT(m_pBtnPlay);
	m_pBtnPause = (CButtonUI *)m_pm.FindControl(_T("btnPause")); ASSERT(m_pBtnPause);
	m_pBtnNext = (CButtonUI *)m_pm.FindControl(_T("btnNext")); ASSERT(m_pBtnNext);
	m_pBtnPrevious = (CButtonUI *)m_pm.FindControl(_T("btnPrevious")); ASSERT(m_pBtnPrevious);
	m_pBtnBackward = (CButtonUI *)m_pm.FindControl(_T("btnBackward")); ASSERT(m_pBtnBackward);
	m_pBtnForward = (CButtonUI *)m_pm.FindControl(_T("btnForward")); ASSERT(m_pBtnForward);
	m_pBtnMute = (CButtonUI *)m_pm.FindControl(_T("btnMute")); ASSERT(m_pBtnMute);
	m_pBtnMuted = (CButtonUI *)m_pm.FindControl(_T("btnMuted")); ASSERT(m_pBtnMuted);
	m_pBtnDock = (CButtonUI *)m_pm.FindControl(_T("btnDock")); ASSERT(m_pBtnDock);
	m_pBtnDocked = (CButtonUI *)m_pm.FindControl(_T("btnDocked")); ASSERT(m_pBtnDocked);
	m_pBtnFull = (CButtonUI *)m_pm.FindControl(_T("btnFull")); ASSERT(m_pBtnFull);
	m_pBtnFull2 = (CButtonUI *)m_pm.FindControl(_T("btnFull2")); ASSERT(m_pBtnFull2);
	m_pBtnExitFull = (CButtonUI *)m_pm.FindControl(_T("btnExitFull")); ASSERT(m_pBtnExitFull);
	m_pBtnExitFull2 = (CButtonUI *)m_pm.FindControl(_T("btnExitFull2")); ASSERT(m_pBtnExitFull2);
	m_pBtnMenu = (CButtonUI *)m_pm.FindControl(_T("btnMenu")); ASSERT(m_pBtnMenu);

	m_player.SetHwnd(m_hWnd);
	// 播放时间显示
	SetTimer(m_hWnd, PROGRESSTIMER, 100, NULL);
}

LRESULT CMainFrameWnd::OnDestroy(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	// 退出程序
	PostQuitMessage(0);

	bHandled = FALSE;
	return 0;
}

void CMainFrameWnd::OnFinalMessage(HWND hWnd)
{
	if (m_pMenu != NULL)
	{
		safe_delete(m_pMenu);
	}

	__super::OnFinalMessage(hWnd);
	delete this;
}

void CMainFrameWnd::OnClick(TNotifyUI& msg)
{
	CDuiString sCtrlName = msg.pSender->GetName();
	if (sCtrlName == _T("btnOpen"))
	{
		OnOpen();
		return;
	}
	else if (sCtrlName == _T("btnPause"))
	{
		OnPause();
		return;
	}
	else if (sCtrlName == _T("btnPlay"))
	{
		OnPlay();
		return;
	}
	else if (sCtrlName == _T("btnStop"))
	{
		OnStop();
		return;
	}
	else if (sCtrlName == _T("btnNext") || sCtrlName == _T("btnForward"))
	{
		OnForward();
		return;
	}
	else if (sCtrlName == _T("btnPrevious") || sCtrlName == _T("btnBackward"))
	{
		OnBackward();
		return;
	}
	else if (sCtrlName == _T("btnMute"))
	{
		OnMute(true);
		return;
	}
	else if (sCtrlName == _T("btnMuted"))
	{
		OnMute(false);
		return;
	}
	else if (sCtrlName == _T("btnDock"))
	{
		OnPin(true);
		return;
	}
	else if (sCtrlName == _T("btnDocked"))
	{
		OnPin(false);
		return;
	}
	else if (sCtrlName == _T("btnFull") || sCtrlName == _T("btnFull2"))
	{
		OnFullScreen(true);
		return;
	}
	else if (sCtrlName == _T("btnExitFull") || sCtrlName == _T("btnExitFull2"))
	{
		OnFullScreen(false);
		return;
	}
	else if (sCtrlName == _T("maxbtn")) 
	{
		SendMessage(WM_SYSCOMMAND, SC_MAXIMIZE, 0);

		return;
	}
	else if (sCtrlName == _T("restorebtn")) 
	{
		if (m_bMaxed)
		{
			m_bMaxed = false;
			UpdateFullBtns();
		}
		SendMessage(WM_SYSCOMMAND, SC_RESTORE, 0);

		return;
	}
	else if (sCtrlName == _T("btnMenu"))
	{
		OnShowMenu(msg);
	}


	WindowImplBase::OnClick(msg);
}

void CMainFrameWnd::Notify(TNotifyUI& msg)
{
	if (msg.sType == DUI_MSGTYPE_VALUECHANGED || msg.sType == DUI_MSGTYPE_VALUECHANGED_MOVE)
	{
		OnValueChanged(msg);
	}
	else if (msg.sType == DUI_MSGTYPE_MENU)
	{
		OnShowMenu(msg);
	}

	__super::Notify(msg);
}

LRESULT CMainFrameWnd::OnLButtonDown(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	m_LPoint.x = GET_X_LPARAM(lParam);
	m_LPoint.y = GET_Y_LPARAM(lParam);
	if (IsPointInControl(m_LPoint))
	{
		m_bMove = false;
	}
	else
	{
		m_bMove = true;
	}

	bHandled = FALSE;
	return 0;
}



LRESULT CMainFrameWnd::OnLButtonUp(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	if (m_bMove)
	{
		m_bMove = false;
		// 顶部吸附功能
		RECT rc;
		GetWindowRect(m_hWnd, &rc);
		RECT rect;
		SystemParametersInfo(SPI_GETWORKAREA, 0, &rect, 0);
		if (rc.top < rect.top)
		{
			MoveWindow(m_hWnd, rc.left, rect.top, rc.right - rc.left, rc.bottom - rc.top, TRUE);
		}
	}

	bHandled = FALSE;
	return 0;
}


LRESULT CMainFrameWnd::HandleMessage(UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	LRESULT lRes = 0;
	BOOL bHandled = TRUE;
	switch (uMsg)
	{
	case WM_TIMER:
	{
		lRes = OnTimer(uMsg, wParam, lParam, bHandled);
		break;
	}
	case WM_RBUTTONUP:
	{
		OnRButtonUp(uMsg, wParam, lParam, bHandled);

		break;
	}
	case WM_LBUTTONDBLCLK:
	{
		OnLButtonDClick(uMsg, wParam, lParam, bHandled);

		break;
	}
	default:				
		bHandled = FALSE; 
		break;
	}

	if (bHandled) 
		return lRes;
	else
		return WindowImplBase::HandleMessage(uMsg, wParam, lParam);
}

LRESULT CMainFrameWnd::HandleCustomMessage(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	bHandled = TRUE;
	switch (uMsg)
	{		
	case MSG_FFPLAYER://message post by ffplayer.dll
	{
		OnFFPlayerMSG(wParam, lParam);
		break;
	}

	case WM_MENUCLICK:
	{
		OnMenuClick(uMsg, wParam, lParam, bHandled);
		break;
	}


	default:
		bHandled = FALSE;
		break;
	}

	
	return 0;
}

LRESULT CMainFrameWnd::OnTimer(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	bHandled = FALSE;
	if (wParam == PROGRESSTIMER)
	{
		if (m_player.IsPlaying())
		{
			LONGLONG position = m_player.GetCurPosition();
			LONGLONG duration = m_player.GetVideoDuration();
			SetTimeText(position, duration);

			m_pSliderPlay->SetValue((int)(position / 1000));
		}

		bHandled = TRUE;
	}
	
	return 0;
}

LRESULT CMainFrameWnd::OnMenuClick(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	bHandled = TRUE;
	MenuCmd* pMenuCmd = (MenuCmd*)wParam;
	CDuiString strMenuName(pMenuCmd->szName);
	BOOL bChecked = pMenuCmd->bChecked;
	if (strMenuName == _T("menuOpenFile"))
	{
		OnOpen();
	}
	else if (strMenuName == _T("menuCloseFile"))
	{
		OnStop();
	}

	else
	{
		bHandled = FALSE;
	}

	return 0;
}

LRESULT CMainFrameWnd::OnRButtonUp(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	bHandled = TRUE;
	POINT pt = { GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam) };
	CDuiString strName;
	CControlUI *pControl = m_pm.FindControl(pt);
	if (pControl)
	{
		strName = pControl->GetName();
	}
	if (strName == _T("btnNext"))//右键下一个文件
	{
		OnNext();
	}
	else if (strName == _T("btnPrevious"))//右键上一个文件
	{
		OnPrevious();
	}
	else
	{
		bHandled = FALSE;
	}
	
	return 0;
}

LRESULT CMainFrameWnd::OnLButtonDClick(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	POINT pt = { GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam) };
	RECT rect = m_pAreaPlay->GetClientPos();	
	if (::PtInRect(&rect, pt))
	{
		if (m_player.IsPlaying())
		{
			OnPause();
		}
		else
		{
			OnPlay();
		}
		bHandled = TRUE;
		return 0;
	}

	bHandled = FALSE;
	return 0;
}

void CMainFrameWnd::OnValueChanged(TNotifyUI& msg)
{
	if (msg.pSender == m_pSliderPlay)
	{
		Seek();
	}
	else if (msg.pSender == m_pSliderVolume)
	{
		Volume();
	}
}

void CMainFrameWnd::OnShowMenu(TNotifyUI& msg)
{
	CDuiString strName = msg.pSender->GetName();
	if (strName == _T("Client") || strName == _T("btnMenu"))
	{
		if (m_pMenu != NULL)
		{
			safe_delete(m_pMenu);
		}
		m_pMenu = new CMenuWnd();
		DWORD dwAlignment = 0;
		POINT point;
		::GetCursorPos(&point);
		//两处菜单位置初始化不同
		if (strName == _T("Client"))
		{
			int nMenuWidth = 150;
			int nMenuHeight = 316;//人工计算的大小，用于菜单位置初始化
			int width = GetSystemMetrics(SM_CXSCREEN);
			int height = GetSystemMetrics(SM_CYSCREEN);
			dwAlignment |= ((point.x + nMenuWidth) <= width ? eMenuAlignment_Left : eMenuAlignment_Right);
			dwAlignment |= ((point.y + nMenuHeight) <= height ? eMenuAlignment_Top : eMenuAlignment_Bottom);
		}
		if(strName == _T("btnMenu"))
		{
			RECT rc = m_pBtnMenu->GetPos();
			point = { rc.left, rc.bottom };
			ClientToScreen(m_hWnd, &point);
			dwAlignment = eMenuAlignment_Left | eMenuAlignment_Top;
		}
		
		m_pMenu->Init(NULL, _T("menu.xml"), point, &m_pm, &m_MenuCheckInfo, dwAlignment);
	}
}

bool CMainFrameWnd::IsPointInControl(POINT pt)
{
	CDuiString strName;
	bool bRet = false;
	CControlUI *pControl = m_pm.FindControl(pt);
	if (pControl)
	{
		strName = pControl->GetClass();
	}	
	if (strName == _T("ButtonUI") || strName == _T("SliderUI"))
	{
		bRet = true;
	}
	return bRet;
}

void CMainFrameWnd::SetupPlayingUI()
{
	// get desktop workarea,resize window
	RECT rect;
	SystemParametersInfo(SPI_GETWORKAREA, 0, &rect, 0);
	int cx = rect.right - rect.left;
	int cy = rect.bottom - rect.top;

	int TitleHeight = m_pAreaTitle->GetHeight();
	int CtrlHeight = m_pAreaCtrl->GetHeight();
	int width = m_player.GetVideoWidth();
	int height = m_player.GetVideoHeight();
	int width_ = (width <= cx) ? width : cx;
	SIZE szMin = m_pm.GetMinInfo();
	width_ = width_ < szMin.cx ? szMin.cx : width_;
	int height_ = ((height + TitleHeight + CtrlHeight) <= cy) ? (height + TitleHeight + CtrlHeight) : cy;
	height_ = height_ < szMin.cy ? szMin.cy : height_;

	POINT pt = { 0, 0 };
	ClientToScreen(m_hWnd, &pt);
	RECT rc;
	rc.right = (pt.x + width_) > rect.right ? rect.right : (pt.x + width_);
	rc.left = rc.right - width_;
	rc.bottom = (pt.y + height_) > rect.bottom ? rect.bottom : (pt.y + height_);
	rc.top = rc.bottom - height_;
	MoveWindow(m_hWnd, rc.left, rc.top, width_, height_, TRUE);
	RECT displayRect = { 0, TitleHeight, width_, height_ - CtrlHeight };
	m_player.SetDisplayArea(displayRect);

	// setup UI
	m_pSliderPlay->SetMaxValue(static_cast<int>(m_player.GetVideoDuration() / 1000));
	m_pSliderPlay->SetValue(0);
	m_pLblTitle->SetText(m_player.GetPlayingFileName().GetData());
	m_pAreaLogo->SetVisible(false);
	ShowPlayBtn(false);
	
	OnFullScreen(m_bMaxed);
}

void CMainFrameWnd::ShowPlayBtn(bool bShow)
{
	m_pBtnPlay->SetVisible(bShow);
	m_pBtnPause->SetVisible(!bShow);
}

void CMainFrameWnd::OnFFPlayerMSG(WPARAM wParam, LPARAM lParam)
{
	if (wParam == PLAY_COMPLETED)
	{
		LONGLONG position = 0;
		LONGLONG duration = m_player.GetVideoDuration();
		SetTimeText(position, duration);

		m_player.Stop();

		m_pAreaLogo->SetVisible(true);
		ShowPlayBtn();
		m_pSliderPlay->SetValue(0);
	}
}

void CMainFrameWnd::SetTimeText(LONGLONG position, LONGLONG duration)
{
	CDuiString strTime;
	strTime.Format(_T("%.2I64u:%.2I64u:%.2I64u/%.2I64u:%.2I64u:%.2I64u"),
		position / 1000 / 60 / 60 % 60, position / 1000 / 60 % 60, position / 1000 % 60,
		duration / 1000 / 60 / 60 % 60, duration / 1000 / 60 % 60, duration / 1000 % 60);
	m_pLblTime->SetText(strTime);
}

void CMainFrameWnd::OnOpen()
{
	int nIndex = m_player.GetPlayListCount();
	//open file to play
	vector<CDuiString> vecFileNames;
	if (CFileUtil::OpenFile(L"All\0*.*\0", m_hWnd, vecFileNames))
	{
		m_player.AddToPlayList(vecFileNames);
		if(m_player.Play(nIndex))
			SetupPlayingUI();
	}
}

void CMainFrameWnd::OnPause()
{
	m_player.Pause();

	ShowPlayBtn();
}

void CMainFrameWnd::OnPlay()
{
	if (m_player.IsOpenFile())//continue
	{
		m_player.Play();

		ShowPlayBtn(false);
	}
	else
	{
		if (m_player.Play(m_player.GetCurIndex()))
		{
			//play list
			SetupPlayingUI();
		}
		else
		{
			//play a new file
			OnOpen();
		}
	}
}

void CMainFrameWnd::OnStop()
{
	m_player.Stop();

	m_pAreaLogo->SetVisible(true);
	ShowPlayBtn();
	m_pSliderPlay->SetValue(0);
	m_pLblTitle->SetText(_T(""));
	SetTimeText(0, 0);
}

void CMainFrameWnd::OnNext()
{
	if(m_player.Next())
		SetupPlayingUI();
}

void CMainFrameWnd::OnPrevious()
{
	if(m_player.Previous())
		SetupPlayingUI();
}

void CMainFrameWnd::OnForward()
{
	LONGLONG position = m_player.GetCurPosition();
	m_player.Seek(position + 10 * 1000);
}

void CMainFrameWnd::OnBackward()
{
	LONGLONG position = m_player.GetCurPosition();
	m_player.Seek(position - 10 * 1000);
}

void CMainFrameWnd::Seek()
{	
	m_player.Seek(m_pSliderPlay->GetValue() * 1000);
}

void CMainFrameWnd::Volume()
{
	m_player.SetAudioVolume(m_pSliderVolume->GetValue() - 182);
}

void CMainFrameWnd::OnMute(bool bMute)
{	
	if (bMute)
	{
		// 静音
		m_nAudioVolume = m_player.GetAudioVolume() + 182;
		m_pSliderVolume->SetValue(0);
	}
	else
	{
		// 静音恢复
		m_pSliderVolume->SetValue(m_nAudioVolume);		
	}
	m_player.SetAudioVolume(m_pSliderVolume->GetValue() - 182);	
	m_pBtnMute->SetVisible(!bMute);
	m_pBtnMuted->SetVisible(bMute);
}


void CMainFrameWnd::OnPin(bool bPin)
{
	if (bPin)
	{
		//设为总在最前
		::SetWindowPos(m_hWnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_SHOWWINDOW | SWP_NOSIZE | SWP_NOMOVE);
	}
	else
	{
		//取消总在最前
		::SetWindowPos(m_hWnd, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_SHOWWINDOW | SWP_NOSIZE | SWP_NOMOVE);
	}

	m_pBtnDock->SetVisible(!bPin);
	m_pBtnDocked->SetVisible(bPin);
}


LRESULT CMainFrameWnd::OnMouseMove(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	if (m_bMaxed)
	{
		int width = GetSystemMetrics(SM_CXSCREEN);
		int height = GetSystemMetrics(SM_CYSCREEN);
		// 标题浮动
		if (GET_Y_LPARAM(lParam) < m_pAreaTitle->GetFixedHeight())
		{
			m_pAreaTitle->SetVisible(true);
		}
		else
		{
			m_pAreaTitle->SetVisible(false);
		}
		// 控制栏浮动
		if (GET_Y_LPARAM(lParam) > (height - m_pAreaCtrl->GetFixedHeight()))
		{
			m_pAreaCtrl->SetVisible(true);
		}
		else
		{
			m_pAreaCtrl->SetVisible(false);
		}

		RECT rc = { 0, m_pAreaTitle->IsVisible() ? m_pAreaTitle->GetHeight() : 0, width, height - (m_pAreaCtrl->IsVisible() ? m_pAreaCtrl->GetHeight() : 0) };
		m_player.SetDisplayArea(rc);
	}

	if (m_bMove && wParam == MK_LBUTTON && !m_bMaxed)
	{
		POINT point = { GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam) };
		RECT rc;
		GetWindowRect(m_hWnd, &rc);
		int X = rc.left + (point.x - m_LPoint.x);
		int Y = rc.top + (point.y - m_LPoint.y);
		MoveWindow(m_hWnd, X, Y, rc.right - rc.left, rc.bottom - rc.top, TRUE);
	}

	bHandled = FALSE;
	return 0;
}

void CMainFrameWnd::OnFullScreen(bool bFull)
{
	m_bMaxed = bFull;
	UpdateFullBtns();

	if (bFull)
	{
		//WS_OVERLAPPEDWINDOW 改为 WS_POPUP
		LONG style = ::GetWindowLong(m_hWnd, GWL_STYLE);
		style &= ~WS_OVERLAPPEDWINDOW;
		style |= (WS_POPUP);
		SetWindowLong(m_hWnd, GWL_STYLE, style);

		SendMessage(WM_SYSCOMMAND, SC_MAXIMIZE, 0);

		// fullscreen
		int width = GetSystemMetrics(SM_CXSCREEN);
		int height = GetSystemMetrics(SM_CYSCREEN);
		MoveWindow(m_hWnd, 0, 0, width, height, TRUE);
	}
	else
	{
		// exit fullscreen
		SendMessage(WM_SYSCOMMAND, SC_RESTORE, 0);
	}
	
}

LRESULT CMainFrameWnd::OnSize(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	if (!::IsIconic(m_hWnd) && m_pAreaTitle)
	{
		RECT rc = { 0, m_pAreaTitle->IsVisible() ? m_pAreaTitle->GetHeight() : 0, GET_X_LPARAM(lParam), GET_Y_LPARAM(lParam) - (m_pAreaCtrl->IsVisible() ? m_pAreaCtrl->GetHeight() : 0) };
		m_player.SetDisplayArea(rc);
	}

	bHandled = FALSE;
	return WindowImplBase::OnSize(uMsg, wParam, lParam, bHandled);
}


void CMainFrameWnd::UpdateFullBtns()
{
	m_pAreaTitle->SetVisible(!m_bMaxed);
	m_pAreaCtrl->SetVisible(!m_bMaxed);
	m_pBtnFull->SetVisible(!m_bMaxed);
	m_pBtnFull2->SetVisible(!m_bMaxed);
	m_pBtnExitFull->SetVisible(m_bMaxed);
	m_pBtnExitFull2->SetVisible(m_bMaxed);
}

