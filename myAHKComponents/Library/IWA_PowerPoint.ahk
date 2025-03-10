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
LWin & 1::{ 
	if LCMD() && CAPS() 
		Send("!{j}{p}{v}{c}") ; トリミング
	else mbind_1()
}
LWin & 2::{ 
	if LCMD() && CAPS() 
		Send("!{h}{a}{t}{t}") ; 上揃え
	else mbind_2()
}
LWin & 3::{ 
	if LCMD() && CAPS() 
		Send("!{h}{a}{t}{m}") ; 中央揃え
	else mbind_3()
}
LWin & 4::{ 
	if LCMD() && CAPS() 
		Send("!{h}{a}{t}{b}") ; 下揃え
	else mbind_4()
}
LWin & 5::{ 
	if LCMD() && CAPS() 
		Send("!{h}{s}{o}") ; 枠色変更（任意）
	else mbind_5()
}

LWin & tab::{
	if LCMD() && CAPS()
		Send("!{w}{m}")
	else mbind_tab()
}
LWin & q::{
	if LCMD() && CAPS() 
		Send("!{h}{n}") ; 箇条書き(ID)
	else mbind_q()
}
LWin & w::{ 
	if LCMD() && CAPS() 
		Send("!{h}{a}{l}") ; 文字左揃え
	else if LCMD()
		return ; 閉じるショートカットの無効化
	else mbind_w()
}
LWin & e::{ 
	if LCMD() && CAPS() 
		Send("!{h}{a}{c}") ; 文字中央揃え
	else mbind_e()
}
LWin & r::{ 
	if LCMD() && CAPS() 
		Send("!{h}{a}{r}") ; 文字左揃え
	else mbind_r()
}
LWin & t::{
	if LCMD() && CAPS() 
		Send("!{h}{f}{c}") ; 文字色変更(任意)
	else mbind_t()
}

LWin & a::{ 
	if LCMD() && CAPS() 
		Send("!{h}{u}")
	else mbind_a()
}
LWin & s::{ 
	if LCMD() && CAPS() 
		Send("!{n}{s}{h}")
	else mbind_s()
}
LWin & d::{ 
	if LCMD() && CAPS() 
		Send("!{h}{s}{f}")
	else mbind_d()
}
LWin & f::{ 
	if LCMD() && CAPS() 
		Send("!{h}{g}{a}") ; 図形揃え
	else mbind_f()
}
LWin & g::{ 
	if LCMD() && CAPS() 
		Send("!{h}{o}{1}")
	else mbind_g()
}

LWin & z::{ 
	if LCMD() && CAPS() 
		Send("!{h}{g}{k}") ; 最背面に移動
	else mbind_z()
}
LWin & x::{ 
	if LCMD() && CAPS() 
		Send("!{h}{g}{r}") ; 最前面に移動
	else mbind_x()
}
LWin & c::{ 
	if LCMD() && CAPS() 
		Send("!{n}{t}") ; 表
	else mbind_c()
}
LWin & v::{ 
	if LCMD() && CAPS() 
		Send("!{n}{n}{s}") ; TODO
	else mbind_v()
}
LWin & b::{ 
	if LCMD() && CAPS() 
		Send("!{h}{s}{o}")
	else mbind_b()
}

#HotIf
