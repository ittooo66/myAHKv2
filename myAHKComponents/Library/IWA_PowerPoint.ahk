#HotIf WinActive("ahk_class PPTFrameClass")

LShift & WheelUp::Send("^{]}")			;文字サイズ変更
LShift & WheelDown::Send("^{[}")		;文字サイズ変更

;図形サイズの変更
Space & WheelUp::{
  if(MSBLF()){
		Send("+{Left}")
	}else{
		Send("+{Up}")
	}
}
Space & WheelDown::{
	if(MSBLF()){
		Send("+{Right}")
	}else{
		Send("+{Down}")
	}
}
XButton1::Send("^{z}")
XButton2::Send("^{y}")

;グループ化
Space & G::{
	if (SHIFT()){
		Send("^+{g}")
		mbind_space("Consume")
	}else{
		Send("^{g}")
		mbind_space("Consume")
	}
}

;スクロール機能一式
XButton2 & LButton::{
	;初期マウス位置の取得
	MouseGetPos(&preMouseX, &preMouseY)
	while(GetKeyState("LButton","P")){
		;現在マウス位置の取得
		MouseGetPos(&mouseX, &mouseY)
		;差分取得
		mouseDiffX :=mouseX-preMouseX
		mouseDiffY :=mouseY-preMouseY

		;スクロール分量値調整
		diffPointY := Float(mouseDiffY/30)
		diffPointX := Float(mouseDiffX/50)

		;abs変換
		absDiffPointY := abs(diffPointY)
		absDiffPointX := abs(diffPointX)

		;適用対象判定
		if(absDiffPointX > absDiffPointY ){
			;Count値、Stack用意
			sleepCount := float(100/absDiffPointX)
			sleepStack := 0

			;X方向適用
			while(absDiffPointX > 0){
				if(diffPointX>0)
					Send("{Right}")
				else
					Send("{Left}")

				;スタック溜まったらSleep（１ミリSleepはまともに挙動しないので20程度見る）
				sleepStack +=sleepCount
				if(sleepStack > 20){
					Sleep(sleepCount)
					sleepStack := 0
				}
				absDiffPointX--
			}
		}else{
			if (absDiffPointY = 0){
				absDiffPointY := 1
			}
			;Count値、Stack用意
			sleepCount := 100/absDiffPointY
			sleepStack := 0

			;Y方向適用
			while(absDiffPointY > 0){
				if(diffPointY>0.5)
					Send("{WheelUp}")
				else if(diffPointY<-0.5)
					Send("{WheelDown}")

				;スタック溜まったらSleep（１ミリSleepはまともに挙動しないので20程度見る）
				sleepStack +=sleepCount
				if(sleepStack > 20){
					Sleep(sleepCount)
					sleepStack := 0
				}

				absDiffPointY--
			}
		}
	}
}

;App個別バインド 一式
*1::
<^1::
LControl & 1::{
	if LCMD() && CAPS() 
		Send("!{j}{p}{v}{c}") ; トリミング
	else mbind_1()
}
*2::
<^2::
LControl & 2::{ 
	if LCMD() && CAPS() 
		Send("!{h}{a}{t}{t}") ; 上揃え
	else mbind_2()
}
*3::
<^3::
LControl & 3::{ 
	if LCMD() && CAPS() 
		Send("!{h}{a}{t}{m}") ; 中央揃え
	else mbind_3()
}
*4::
<^4::
LControl & 4::{ 
	if LCMD() && CAPS() 
		Send("!{h}{a}{t}{b}") ; 下揃え
	else mbind_4()
}
*5::
<^5::
LControl & 5::{ 
	if LCMD() && CAPS() 
		Send("!{h}{s}{o}") ; 枠色変更（任意）
	else mbind_5()
}

*Tab::
<^Tab::
LControl & tab::{
	if LCMD() && CAPS()
		Send("!{w}{m}")
	else mbind_tab()
}
*q::
<^q::
LControl & q::{
	if LCMD() && CAPS() 
		Send("!{h}{n}") ; 箇条書き(ID)
	else mbind_q()
}
*w::
<^w::
LControl & w::{ 
	if LCMD() && CAPS() 
		Send("!{h}{a}{l}") ; 文字左揃え
	else if LCMD()
		return ; 閉じるショートカットの無効化
	else mbind_w()
}
*e::
<^e::
LControl & e::{ 
	if LCMD() && CAPS() 
		Send("!{h}{a}{c}") ; 文字中央揃え
	else mbind_e()
}
*r::
<^r::
LControl & r::{ 
	if LCMD() && CAPS() 
		Send("!{h}{a}{r}") ; 文字左揃え
	else mbind_r()
}
*t::
<^t::
LControl & t::{
	if LCMD() && CAPS() 
		Send("!{h}{f}{c}") ; 文字色変更(任意)
	else mbind_t()
}

*a::
<^a::
LControl & a::{
	if LCMD() && CAPS() 
		Send("!{h}{u}")
	else mbind_a()
}
*s::
<^s::
LControl & s::{
	if LCMD() && CAPS() 
		Send("!{n}{s}{h}")
	else mbind_s()
}
*d::
<^d::
LControl & d::{ 
	if LCMD() && CAPS() 
		Send("!{h}{s}{f}")
	else mbind_d()
}
*f::
<^f::
LControl & f::{ 
	if LCMD() && CAPS() 
		Send("!{h}{g}{a}") ; 図形揃え
	else mbind_f()
}
*g::
<^g::
LControl & g::{ 
	if LCMD() && CAPS() 
		Send("!{h}{o}{1}")
	else mbind_g()
}

*z::
<^z::
LControl & z::{ 
	if LCMD() && CAPS() 
		Send("!{h}{g}{k}") ; 最背面に移動
	else mbind_z()
}
*x::
<^x::
LControl & x::{ 
	if LCMD() && CAPS() 
		Send("!{h}{g}{r}") ; 最前面に移動
	else mbind_x()
}
*c::
<^c::
LControl & c::{ 
	if LCMD() && CAPS() 
		Send("!{n}{t}") ; 表
	else mbind_c()
}
*v::
<^v::
LControl & v::{ 
	if LCMD() && CAPS() 
		Send("!{n}{n}{s}") ; TODO
	else mbind_v()
}
*b::
<^b::
LControl & b::{ 
	if LCMD() && CAPS() 
		Send("!{h}{s}{o}")
	else mbind_b()
}
#HotIf
