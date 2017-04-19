#pragma once

class CMediaPlay
{
public:
	CMediaPlay();
	~CMediaPlay();
	// 设置显示视频的窗口句柄
	void SetHwnd(HWND hWnd);
	// 设置饰品显示区域
	void SetDisplayArea(RECT rect);
	// 播放
	bool Play(CDuiString strFileName);
	bool Play(int nIndex);
	// 停止
	void Stop();
	// 暂停
	void Pause();
	// 继续播放
	void Play();
	// 播放下一个文件
	bool Next();
	// 播放上一个文件
	bool Previous();
	// seek
	void Seek(LONGLONG ms);
	// 是否正在播放
	bool IsPlaying();
	// 是否打开了文件
	bool IsOpenFile();
	// 获取正在播放的文件名
	CDuiString GetPlayingFileName();
	// 获取播放列表中文件个数 重复也算
	int GetPlayListCount();
	// 获取播放列表中当前索引
	int GetCurIndex();
	// 添加文件到播放列表
	void AddToPlayList(vector<CDuiString> &vecFileNames);
	// 设置视频渲染模式
	void SetRenderType(int nRenderType = VDEV_RENDER_TYPE_D3D);
	// 设置音量
	//用于设置播放音量，不同于系统音量，ffplayer 内部具有一个 - 30dB 到 + 12dB 的软件音量控制单元
	//音量范围：[-182, 73]， - 182 对应 - 30dB，73 对应 + 12dB
	//特殊值  ：0 对应 0dB 增益， - 255 对应静音， + 255 对应最大增益
	void SetAudioVolume(int nAudioVolume = 0);
	// 获取音量值
	int GetAudioVolume();
	// 获得视频长度
	LONGLONG GetVideoDuration();
	// 获得当前播放进度
	LONGLONG GetCurPosition();
	// 获取视频宽
	int GetVideoWidth();
	// 获取视频高
	int GetVideoHeight();

private:
	// 播放列表
	vector<CDuiString> m_vecFileNames;
	int m_nIndex;
	void *m_hplayer;
	HWND m_hWnd;
	bool m_bPlaying;
	RECT m_rect;
	int m_nRenderType;
	int m_nAudioVolume;
	LONGLONG m_llDuration;
	int m_nVideoWidth;
	int m_nVideoHeight;
};

