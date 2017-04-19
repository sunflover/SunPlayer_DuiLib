; --------------------------------------
; 这个是NSIS中用 nsWindows 创建关于窗口的示例
; 这里有部分常用函数的详细说明

; 首先, 当然是要引入这个头文件, 才能使用其中的函数和宏
!include "nsWindows.nsh"

; 避免可能与其它的冲突，定义变量前进行判断
!ifndef hWNDAboutWindow
 ;  定义你的窗口句柄
 ;  如果需要在脚本的其它地方使用某控件, 还要定义其它控件的句柄
  var hWNDAboutWindow
  !define hWNDAboutWindow
!endif

; 主函数，用于创建窗口
Function ${un}.AboutWindow
; 判断窗口是否存在, 如果存在就显示窗口, 避免重复创建
  IsWindow $hWNDAboutWindow Create_End
  
/*在这里创建窗口,以及调整窗口*/
  ; 这个当然是插件窗口的主代码
  ; 格式:	${NSW_CreateWindow} 保存窗口句柄的变量 窗口标题 要模仿的NSIS内部对话框
	${NSW_CreateWindow} $hWNDAboutWindow "关于 $(^NameDA) v${VERSION} 少轻狂增强版" 1018
;  ShowWindow $hWNDAboutWindow ${SW_HIDE}

;创建窗口后,需要先对窗口进行调整,包括窗口大小,位置,界面颜色,等等
  ; 设置窗口的背景色(这里是白色)
	SetCtlColors $hWNDAboutWindow "" ${WHITE}
  ; 设置窗口大小(单位: 像素)
  ${NSW_SetWindowSize} $hWNDAboutWindow 450 420
  ; 设置窗口位置(单位: 像素)
  ;  ${NSW_SetWindowPos} $hWNDAboutWindow 450 420
  ; 设置窗口居中
  ; 格式: ${NSW_CenterWindow} 窗口句柄  用作参照的父窗口句柄
  ${NSW_CenterWindow} $hWNDAboutWindow $hwndparent
  
  ; 最小化窗口
;  ${NSW_MinimizeWindow} $hwndparent
;  EnableWindow $hwndparent 0

  ;设置窗口不透明度
  ${NSW_SetTransparent} $hWNDAboutWindow 95

  ;窗口的页面回调函数, 也就是你点击X按钮后要执行的函数
	${NSW_OnBack} ${un}.OnAboutClose

/*从这里开始, 添加你自己的控件*/
  ; 创建一个Label控件, 所支持的控件类型请查阅说明文件, 用法基本上与nsDialogs类似
	${NSW_CreateLabel} 15 8 95% 40% "此增强版除了主程序的翻译之外还把主要的文档作了翻译并修正了官方\
  	版本里简体中文语言习惯用语不合适之处。单纯的使用脚本来编写安装程序对\
  	于大多数人来说不仅困难而且容易出错，为此，增强版里集成了一个\
  	相当好用的脚本编辑器 - VNISEdit 增强版 (Build 060712 By Restools)。\
  	只需要根据向导就能轻松的做出很酷的安装程序，甚至，您还可以在向导里给\
  	您的安装程序添加启动画面、让您的安装程序在安装过程中播放音乐，而这，\
  	只需要点几下鼠标即可。除此之外，VNISEdit 附带的注册表转换插件还可以把\
  	 .reg 文件一次性的转换为 NSIS 脚本，补丁制作向导可以一次性地为您生成体\
  	积超小的补丁升级程序。另外，此增强版还在官方版本的基础上集成了一些有用\
  	的插件和范例脚本。\
   $\n$\n由于各个组件在使用时各自独立，所以强烈推荐安装全部组件。"
    ; 所创建 Label 的句柄, 从堆栈中弹出, 存入 $R0 ($R0 相当于局部变量
    ; 如果你需要在其它位置使用这个句柄, 请自定义一个变量来保持.)
		Pop $R0
      SetCtlColors $R0 0x009300 ${WHITE} ;设置控件颜色(前景色, 背景色)
		
  StrCpy $0 100
  StrCpy $1 12
	${NSW_CreateLabel} 15 $0u 30% 10u "主要参与者:"
		Pop $R0
		SetCtlColors $R0 0x009300 ${WHITE}

  IntOp $0 $0 + $1
	${NSW_CreateLink} 40 $0u 30% 12u 蓝色网际
		Pop $R0
		SetCtlColors $R0 ${BLUE} ${WHITE}
	; 添加控件的事件, 一般是 OnClick , 也就是点击, 其它类型的事件请查阅说明文件
	; 格式: ${NSW_OnClick}  控件句柄 目标函数
	${NSW_OnClick} $R0 ${un}.On蓝色网际

  IntOp $0 $0 + $1
	${NSW_CreateLink} 40 $0u 30% 12u Restools
		Pop $R0
		SetCtlColors $R0 ${BLUE} ${WHITE}
	${NSW_OnClick} $R0 ${un}.OnRestools

  IntOp $0 $0 + $1
	${NSW_CreateLink} 40 $0u 30% 12u 陈敏毅
		Pop $R0
		SetCtlColors $R0 ${BLUE} ${WHITE}
	${NSW_OnClick} $R0 ${un}.On陈敏毅

  IntOp $0 $0 + $1
	${NSW_CreateLink} 40 $0u 30% 12u 似水年华
		Pop $R0
		SetCtlColors $R0 ${BLUE} ${WHITE}
	${NSW_OnClick} $R0 ${un}.On似水年华

  IntOp $0 $0 + $1
	${NSW_CreateLink} 40 $0u 30% 12u X-Star
		Pop $R0
		SetCtlColors $R0 ${BLUE} ${WHITE}
	${NSW_OnClick} $R0 ${un}.OnX-Star

  IntOp $0 $0 + $1
	${NSW_CreateLink} 40 $0u 30% 12u zhfi
		Pop $R0
		SetCtlColors $R0 ${BLUE} ${WHITE}
	${NSW_OnClick} $R0 ${un}.Onzhfi

  IntOp $0 $0 + $1
	${NSW_CreateLink} 40 $0u 30% 12u Athanasia
		Pop $R0
		SetCtlColors $R0 ${BLUE} ${WHITE}
	${NSW_OnClick} $R0 ${un}.OnAthanasia

  IntOp $0 $0 + $1
	${NSW_CreateLabel} 15 $0u 95% 20u "其它：$\t篮球梦音乐心、贾可、如风 等\
    $\n此版本在zhfi增强版的基础上由少轻狂重新打包，在此一并感谢！"
		Pop $R0
		SetCtlColors $R0 0x009300 ${WHITE}

	${NSW_CreateButton} 40% -22u 50u 18u '关闭'
		Pop $R0
		SetCtlColors $R0 "" ${WHITE}
	${NSW_OnClick} $R0 ${un}.OnAboutClose

/*在所有的控件都完成之后, 必须用这个宏将窗口显示出来, 以及关联上面添加到控件的事件*/
	${NSW_MessageBeep} ${MB_ICONINFORMATION} ;弹出提示声音
	${NSW_Show}
Create_End:
  ShowWindow $hWNDAboutWindow ${SW_SHOW}
  EnableWindow $HWNDPARENT 0
FunctionEnd

;控件回调函数
Function ${un}.OnAboutClose
  ${NSW_CloseWindow} $hWNDAboutWindow
  EnableWindow $HWNDPARENT 1
  BringToFront
FunctionEnd

Function ${un}.On蓝色网际
	ExecShell "open" "http://hi.baidu.com/ikiki/"
FunctionEnd

Function ${un}.OnRestools
	ExecShell "open" "http://restools.hanzify.org/"
FunctionEnd

Function ${un}.On陈敏毅
	ExecShell "open" "http://chenmy.hanzify.org/"
FunctionEnd

Function ${un}.On似水年华
	ExecShell "open" "http://www.dreams8.com/"
FunctionEnd

Function ${un}.OnX-Star
	ExecShell "open" "http://hi.baidu.com/XStar2008/"
FunctionEnd

Function ${un}.OnAthanasia
	ExecShell "open" "http://www.dreams8.com/"
FunctionEnd

Function ${un}.Onzhfi
	ExecShell "open" "http://hi.baidu.com/zhfi1022/"
FunctionEnd

