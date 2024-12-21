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
		consumeSpace()
	}else{
		Send("^{g}")
		consumeSpace()
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
			sleepCount := 100/absDiffPointX
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
*1::{ 
	if LCMD() && CAPS() 
		Send("!{j}{d}{s}{o}{Right}{Right}{Right}{Right}{Right}{Down}{Down}{Down}{Down}{return}") ;枠色変更（青）
	else mbind_1()
}
*2::{ 
	if LCMD() && CAPS() 
		Send("!{j}{d}{s}{o}{Left}{Left}{Down}{Down}{Down}{Down}{return}") ;枠色変更（青）
	else mbind_2()
}
*3::{ 
	if LCMD() && CAPS() 
		Send("!{j}{d}{s}{o}{Left}{Down}{Down}{Down}{Down}{return}") ;枠色変更（緑）
	else mbind_3()
}
*4::{ 
	if LCMD() && CAPS() 
		Send("!{j}{d}{s}{o}{Down}{Down}{Down}{Down}{Down}{Down}{return}") ;枠色変更（赤）
	else mbind_4()
}
*5::{ 
	if LCMD() && CAPS() 
		Send("!{j}{d}{s}{o}") ;枠色変更（パレット）
	else mbind_5()
}
*f::{ 
	if LCMD() && CAPS() 
		Send("!{j}{d}{a}{a}") ; 図形揃え
	else mbind_f()
}


*q::{ 
	if LCMD() && CAPS() 
		Send("!{h}{f}{1}{Left}{Left}{Left}{Left}{Left}{Down}{Down}{Down}{Down}{return}") ; 文字色変更（橙）
	else mbind_q()
}
*w::{ 
	if LCMD() && CAPS() 
		Send("!{h}{f}{1}{Left}{Left}{Down}{Down}{Down}{Down}{return}") ; 文字色変更（青）
	else mbind_w()
}
*e::{ 
	if LCMD() && CAPS() 
		Send("!{h}{f}{1}{Left}{Down}{Down}{Down}{Down}{return}") ; 文字色変更（緑）
	else mbind_e()
}
*r::{ 
	if LCMD() && CAPS() 
		Send("!{h}{f}{1}{Down}{Down}{Down}{Down}{Down}{Down}{return}") ; 文字色変更（赤）
	else mbind_r()
}
*t::{ 
	if LCMD() && CAPS() 
		Send("!{h}{f}{c}")
	else mbind_t()
}
*a::{ 
	if LCMD() && CAPS() 
		Send("!{h}{u}{2}")
	else mbind_a()
}
*s::{ 
	if LCMD() && CAPS() 
		Send("!{n}{s}{h}")
	else mbind_s()
}
*d::{ 
	if LCMD() && CAPS() 
		Send("!{j}{d}{s}{f}")
	else mbind_d()
}
*g::{ 
	if LCMD() && CAPS() 
		Send("!{h}{o}")
	else mbind_g()
}
*z::{ 
	if LCMD() && CAPS() 
		Send("!{j}{d}{a}{f}{r}")
	else mbind_z()
}
*x::{ 
	if LCMD() && CAPS() 
		Send("!{j}{d}{a}{e}{k}")
	else mbind_x()
}
*b::{ 
	if LCMD() && CAPS() 
		Send("!{j}{d}{s}{o}{w}")
	else mbind_b()
	}

#HotIf
