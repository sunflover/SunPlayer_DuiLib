nsRandom
随机数产生插件

用法:
Push x
nsRandom
Pop y

x	:	范围数正数则生成0~x的整型随机数
		负数则生成0~1的浮点型随机数
		
		
y	:	结果输出

例子:

Push "-1"
nsRandom::GetRandom
Pop $0
;$0=0.721664637327194


Push "100"
nsRandom::GetRandom
Pop $0
;$0=88

____________________________
			Write By Ansifa
			2008-12-13