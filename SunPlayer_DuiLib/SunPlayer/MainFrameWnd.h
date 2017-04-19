#pragma once
#include "MediaPlay.h"

class CMainFrameWnd :
	public WindowImplBase
{
public:
	CMainFrameWnd();
	~CMainFrameWnd();

	virtual CDuiString GetSkinFile()	{ return _T("MainWnd.xml"); }
	virtual LPCTSTR GetWindowClassName(void) const override	{ return _T("MainFrameWnd"); }

	virtual void InitWindow() override;
	LRESULT OnDestroy(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled) override;
	virtual void OnFinalMessage(HWND hWnd) override;
	virtual void OnClick(TNotifyUI& msg) override;
	virtual void Notify(TNotifyUI& msg) override;
	virtual LRESULT OnLButtonDown(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled) override;
	virtual LRESULT OnMouseMove(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled) override;
	virtual LRESULT OnLButtonUp(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled) override;
	virtual LRESULT OnSize(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled) override;
	virtual LRESULT HandleMessage(UINT uMsg, WPARAM wParam, LPARAM lParam) override;
	virtual LRESULT HandleCustomMessage(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled) override;


protected:
	LRESULT OnTimer(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);
	LRESULT OnMenuClick(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);
	LRESULT OnRButtonUp(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);	
	// 双击暂停处理
	LRESULT OnLButtonDClick(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);
	void OnValueChanged(TNotifyUI& msg);
	void OnShowMenu(TNotifyUI &msg);
	bool IsPointInControl(POINT pt);
	void SetupPlayingUI();
	void ShowPlayBtn(bool bShow = true);
	void OnFFPlayerMSG(WPARAM wParam, LPARAM lParam);
	void SetTimeText(LONGLONG position, LONGLONG duration);
	// 打开文件
	void OnOpen();
	// 暂停播放
	void OnPause();
	// 播放
	void OnPlay();
	// 停止
	void OnStop();
	// 下一个
	void OnNext();
	// 上一个
	void OnPrevious();
	// 前进
	void OnForward();
	// 后退
	void OnBackward();
	// 播放进度调整
	void Seek();
	// 声音调整
	void Volume();
	// 静音
	void OnMute(bool bMute = true);
	// 窗口总在最前
	void OnPin(bool bPin = true);
	// 全屏
	void OnFullScreen(bool bFull = true);
	void UpdateFullBtns();


private:
	// 鼠标左键按下时位置
	POINT m_LPoint;
	// 是否可以移动
	bool m_bMove;
	// 音量
	int m_nAudioVolume;
	bool m_bMaxed;
	CMediaPlay m_player;
	CHorizontalLayoutUI *m_pAreaTitle;
	CHorizontalLayoutUI *m_pAreaCtrl;
	CHorizontalLayoutUI *m_pAreaPlay;
	CVerticalLayoutUI *m_pAreaLogo;
	CLabelUI *m_pLblTime;
	CLabelUI *m_pLblTitle;
	CSliderUI *m_pSliderPlay;
	CSliderUI *m_pSliderVolume;
	CButtonUI *m_pBtnPlay;
	CButtonUI *m_pBtnPause;
	CButtonUI *m_pBtnNext;
	CButtonUI *m_pBtnPrevious;	
	CButtonUI *m_pBtnBackward;
	CButtonUI *m_pBtnForward;
	CButtonUI *m_pBtnMute;
	CButtonUI *m_pBtnMuted;
	CButtonUI *m_pBtnDock;
	CButtonUI *m_pBtnDocked;
	CButtonUI *m_pBtnFull;
	CButtonUI *m_pBtnFull2;
	CButtonUI *m_pBtnExitFull;
	CButtonUI *m_pBtnExitFull2;
	CButtonUI *m_pBtnMenu;
	CMenuWnd *m_pMenu;
	CMenuElementUI *m_MenuVideoGDI;
	CMenuElementUI *m_MenuVideoD3D;

	CStdStringPtrMap m_MenuCheckInfo; //保存菜单的单选复选信息
};

