#include "stdafx.h"
#include "MediaPlay.h"


CMediaPlay::CMediaPlay()
	:m_hplayer(NULL),
	m_hWnd(NULL),
	m_bPlaying(false),
	m_nRenderType(VDEV_RENDER_TYPE_GDI),
	m_nAudioVolume(0),
	m_llDuration(0),
	m_nVideoWidth(0),
	m_nVideoHeight(0),
	m_nIndex(0),
	m_rect({0,0,0,0})
{
}


CMediaPlay::~CMediaPlay()
{
}

void CMediaPlay::SetHwnd(HWND hWnd)
{
	m_hWnd = hWnd;
}

void CMediaPlay::SetDisplayArea(RECT rect)
{
	m_rect = rect;
	if (m_hplayer)
	{
		player_setrect(m_hplayer, 0, m_rect.left, m_rect.top, m_rect.right - m_rect.left, m_rect.bottom - m_rect.top);
		player_setrect(m_hplayer, 1, m_rect.left, m_rect.top, m_rect.right - m_rect.left, m_rect.bottom - m_rect.top);
	}
}

bool CMediaPlay::Play(CDuiString strFileName)
{
	if(!::IsWindow(m_hWnd))
	{
		return false;
	}
	Stop();

	m_hplayer = player_open(const_cast<char*>(WStringToString(strFileName.GetData()).c_str()),m_hWnd);	
	player_getparam(m_hplayer, PARAM_VIDEO_WIDTH, &m_nVideoWidth);
	player_getparam(m_hplayer, PARAM_VIDEO_HEIGHT, &m_nVideoHeight);
	player_getparam(m_hplayer, PARAM_MEDIA_DURATION, &m_llDuration);
	player_setparam(m_hplayer, PARAM_VDEV_RENDER_TYPE, &m_nRenderType);
	player_setparam(m_hplayer, PARAM_AUDIO_VOLUME, &m_nAudioVolume);
	player_play(m_hplayer);
	
	m_bPlaying = true;

	return true;
}

bool CMediaPlay::Play(int nIndex)
{
	if(nIndex >= m_vecFileNames.size() || nIndex < 0)
	{
		return false;
	}

	m_nIndex = nIndex;
	return Play(m_vecFileNames[nIndex]);
}

void CMediaPlay::Stop()
{
	if (m_hplayer)
	{
		player_close(m_hplayer);
		m_hplayer = NULL;
	}
	m_bPlaying = false;
	m_llDuration = 0;
	m_nVideoWidth = 0;
	m_nVideoHeight = 0;
}

void CMediaPlay::Pause()
{
	if (m_hplayer && m_bPlaying)
	{
		player_pause(m_hplayer);
		m_bPlaying = false;
	}
}

void CMediaPlay::Play()
{
	if (m_hplayer)
	{
		// continue to play
		player_play(m_hplayer);
		m_bPlaying = true;
	}
}

bool CMediaPlay::Next()
{
	return Play(m_nIndex + 1);
}

bool CMediaPlay::Previous()
{
	return Play(m_nIndex - 1);
}

void CMediaPlay::Seek(LONGLONG ms)
{
	if (m_hplayer)
	{
		ms = ms > m_llDuration ? m_llDuration : ms;
		if (ms < 0)
			ms = 0;
		player_seek(m_hplayer, ms);
	}
}

bool CMediaPlay::IsPlaying()
{
	return m_bPlaying;
}

bool CMediaPlay::IsOpenFile()
{
	return m_hplayer ? true : false;
}

CDuiString CMediaPlay::GetPlayingFileName()
{
	CDuiString strFileName;
	if (m_nIndex >= 0 && m_nIndex < m_vecFileNames.size())
	{
		CDuiString strFilePath = m_vecFileNames[m_nIndex];
		strFileName = strFilePath.Mid(strFilePath.ReverseFind(_T('\\')) + 1);
	}
	return strFileName;
}

int CMediaPlay::GetPlayListCount()
{
	return m_vecFileNames.size();
}

int CMediaPlay::GetCurIndex()
{
	return m_nIndex;
}

void CMediaPlay::AddToPlayList(vector<CDuiString>& vecFileNames)
{
	m_vecFileNames.insert(m_vecFileNames.end(), vecFileNames.begin(), vecFileNames.end());
}

void CMediaPlay::SetRenderType(int nRenderType)
{
	m_nRenderType = nRenderType;
	if (m_hplayer)
		player_setparam(m_hplayer, PARAM_VDEV_RENDER_TYPE, &m_nRenderType);
}

void CMediaPlay::SetAudioVolume(int nAudioVolume)
{
	m_nAudioVolume = nAudioVolume;
	if (m_hplayer)
		player_setparam(m_hplayer, PARAM_AUDIO_VOLUME, &m_nAudioVolume);
}

int CMediaPlay::GetAudioVolume()
{
	return m_nAudioVolume;
}

LONGLONG CMediaPlay::GetVideoDuration()
{
	return m_llDuration;
}

LONGLONG CMediaPlay::GetCurPosition()
{
	LONGLONG position = 0;
	if (m_hplayer)
		player_getparam(m_hplayer, PARAM_MEDIA_POSITION, &position);
	return position;
}

int CMediaPlay::GetVideoWidth()
{
	return m_nVideoWidth;
}

int CMediaPlay::GetVideoHeight()
{
	return m_nVideoHeight;
}

