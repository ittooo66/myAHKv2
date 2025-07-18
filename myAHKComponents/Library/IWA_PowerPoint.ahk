;Powerpoint 個別バインド一式
#HotIf WinActive("ahk_class PPTFrameClass")

iwa_pptx_1     := () => Send("!{j}{p}{v}{c}") ; トリミング
iwa_pptx_2     := () => Send("!{h}{a}{t}{t}") ; 上揃え
iwa_pptx_3     := () => Send("!{h}{a}{t}{m}") ; 中央揃え
iwa_pptx_4     := () => Send("!{h}{a}{t}{b}") ; 下揃え
iwa_pptx_5     := () => Send("!{h}{s}{o}")    ; 枠色変更（任意）

iwa_pptx_tab   := () => Send("!{w}{m}")       ; スライドマスタ

iwa_pptx_q     := () => Send("!{h}{n}")       ; 箇条書き(ID)
iwa_pptx_w     := () => Send("!{h}{a}{l}")    ; 文字左揃え
iwa_pptx_e     := () => Send("!{h}{a}{c}")    ; 文字中央揃え
iwa_pptx_r     := () => Send("!{h}{a}{r}")    ; 文字左揃え
iwa_pptx_t     := () => Send("!{h}{f}{c}")    ; 文字色変更(任意)

iwa_pptx_a     := () => Send("!{h}{u}")       ; 箇条書き
iwa_pptx_s     := () => Send("!{n}{s}{h}")    ; 図形選択
iwa_pptx_d     := () => Send("!{h}{s}{f}")    ; 図形の塗りつぶし
iwa_pptx_f     := () => Send("!{h}{g}{a}")    ; 図形の位置揃え
iwa_pptx_g     := () => Send("!{h}{o}{1}")    ; 図形の書式設定

iwa_pptx_z     := () => Send("!{h}{g}{k}")    ; 最背面に移動
iwa_pptx_x     := () => Send("!{h}{g}{r}")    ; 最前面に移動
iwa_pptx_c     := () => Send("!{n}{t}")       ; 表
iwa_pptx_v     := () => Send("!{n}{n}{s}")    ; アイコン挿入
iwa_pptx_b     := () => Send("!{h}{s}{o}")    ; 図形の枠線

LShift & WheelUp::Send("^{]}")			;文字サイズ変更
LShift & WheelDown::Send("^{[}")		;文字サイズ変更

;図形サイズの変更
Space & WheelUp::Send(MSBLF() ? "+{Left}" : "+{Up}")
Space & WheelDown::Send(MSBLF()?"+{Right}":"+{Down}")

XButton1::Send("^{z}")
XButton2::Send("^{y}")

;グループ化
Space & g::Send((SHIFT() ? "^+" : "^") "{g}"), mbind_space("Consume")

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

; リスナー処理
*1::
<^1::
LControl & 1::{ 
	if LCMD() && CAPS() 
		iwa_pptx_1()
	else mbind_1()
}
*2::
<^2::
LControl & 2::{ 
	if LCMD() && CAPS() 
		iwa_pptx_2()
	else mbind_2()
}
*3::
<^3::
LControl & 3::{ 
	if LCMD() && CAPS() 
		iwa_pptx_3()
	else mbind_3()
}
*4::
<^4::
LControl & 4::{ 
	if LCMD() && CAPS() 
		iwa_pptx_4()
	else mbind_4()
}
*5::
<^5::
LControl & 5::{ 
	if LCMD() && CAPS() 
		iwa_pptx_5()
	else mbind_5()
}

*Tab::
<^Tab::
LControl & tab::{
	if LCMD() && CAPS()
		iwa_pptx_tab()
	else mbind_tab()
}

*q::
<^q::
LControl & q::{ 
	if LCMD() && CAPS() 
		iwa_pptx_q()
	else mbind_q() 
}
*w::
<^w::
LControl & w::{ 
	if LCMD() && CAPS()
		iwa_pptx_w()
	else if LCMD()
		return ; 閉じるショートカットの無効化
	else mbind_w()
}
*e::
<^e::
LControl & e::{ 
	if LCMD() && CAPS()
		iwa_pptx_e()
	else mbind_e()
}
*r::
<^r::
LControl & r::{ 
	if LCMD() && CAPS()
		iwa_pptx_r()
	else mbind_r()
}
*t::
<^t::
LControl & t::{ 
	if LCMD() && CAPS()
		iwa_pptx_t()
	else mbind_t()
}
*a::
<^a::
LControl & a::{ 
	if LCMD() && CAPS() 
		iwa_pptx_a()
	else mbind_a()
}
<^s::
LControl & s::{ 
	if LCMD() && CAPS() 
		iwa_pptx_s()
	else mbind_s()
}
<^d::
LControl & d::{ 
	if LCMD() && CAPS() 
		iwa_pptx_d()
	else mbind_d()
}
<^f::
LControl & f::{ 
	if LCMD() && CAPS() 
		iwa_pptx_f()
	else mbind_f()
}
*g::
<^g::
LControl & g::{ 
	if LCMD() && CAPS()
		iwa_pptx_g()
	else mbind_g()
}
*z::
<^z::
LControl & z::{ 
	if LCMD() && CAPS()
		iwa_pptx_z()
	else mbind_z()
}
*x::
<^x::
LControl & x::{ 
	if LCMD() && CAPS()
		iwa_pptx_x()
	else mbind_x()
}
*c::
<^c::
LControl & c::{ 
	if LCMD() && CAPS()
		iwa_pptx_c()
	else mbind_c()
}
*v::
<^v::
LControl & v::{ 
	if LCMD() && CAPS() 
		iwa_pptx_v()
	else mbind_v()
}
*b::
<^b::
LControl & b::{ 
	if LCMD() && CAPS() 
		iwa_pptx_b()
	else mbind_b()
}

#HotIf
