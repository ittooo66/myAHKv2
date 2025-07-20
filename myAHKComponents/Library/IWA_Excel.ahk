;Excel 個別バインド一式
#HotIf WinActive("ahk_class XLMAIN")

iwa_xlsx_1     := () => Send("!{h}{s}{f}") ; フィルタ
iwa_xlsx_2     := () => Send("!{h}{a}{t}") ; 文字列 - 上揃え
iwa_xlsx_3     := () => Send("!{h}{a}{m}") ; 文字列 - 上下中央揃え
iwa_xlsx_4     := () => Send("!{h}{a}{b}") ; 文字列 - 下揃え
iwa_xlsx_5     := () => Send("!{h}{b}{i}") ; 罫線 - 色変更

iwa_xlsx_tab   := () => Send("TBD")

iwa_xlsx_q     := () => Send("!{o}{c}{a}") ; セル幅調整
iwa_xlsx_w     := () => Send("!{h}{a}{l}") ; 文字列 - 左揃え
iwa_xlsx_e     := () => Send("!{h}{a}{c}") ; 文字列 - 中央揃え
iwa_xlsx_r     := () => Send("!{h}{a}{r}") ; 文字列 - 右揃え
iwa_xlsx_t     := () => Send("!{h}{f}{c}") ; 

iwa_xlsx_a     := () => Send("TBD")
iwa_xlsx_s     := () => Send("TBD")
iwa_xlsx_d     := () => Send("!{h}{h}")
iwa_xlsx_f     := () => Send("TBD")
iwa_xlsx_g     := () => Send("!{h}{m}{c}")

iwa_xlsx_z     := () => Send("TBD")
iwa_xlsx_x     := () => Send("TBD")
iwa_xlsx_c     := () => Send("TBD")
iwa_xlsx_v     := () => Send("!{w}{f}{f}")
iwa_xlsx_b     := () => Send("!{h}{b}{y}")

; Excelバインド - 罫線関連
iwa_xlsx_u     := () => Send("!{h}{b}{a}")
iwa_xlsx_h     := () => Send("!{h}{b}{n}")
iwa_xlsx_i     := () => Send("!{h}{b}{p}")
iwa_xlsx_j     := () => Send("!{h}{b}{l}")
iwa_xlsx_k     := () => Send("!{h}{b}{o}")
iwa_xlsx_l     := () => Send("!{h}{b}{r}")
iwa_xlsx_o     := () => Send("!{h}{b}{s}")

; Excelバインド - パッチ関連
Shift & Space::Send("+{Space}")					; 挙動是正パッチ

XButton2 & LButton::{
	;初期マウス位置の取得
	MouseGetPos(&preMouseX, &preMouseY)

	;スクロール処理開始
	SetScrollLockState("On")

	while(GetKeyState("LButton","P")){
		;現在マウス位置の取得
		MouseGetPos(&mouseX, &mouseY)
		;差分取得
		mouseDiffX :=mouseX-preMouseX
		mouseDiffY :=mouseY-preMouseY
		
		;スクロール分量値調整
		diffPointY := Float(mouseDiffY/30)
		diffPointX := Float(mouseDiffX/30)
		
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
					Send("{WheelLeft}") 		;Excel_scrollRight()
				else
					Send("{WheelRight}") 	;Excel_scrollLeft()
				
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
			if (absDiffPointY = 0){
				absDiffPointY := 1
			}
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
	;スクロール処理終了
	SetScrollLockState("Off")
}


; リスナー処理
*1::
<^1::
LControl & 1::{ 
	if LCMD() && CAPS() 
		iwa_xlsx_1()
	else mbind_1()
}
*2::
<^2::
LControl & 2::{ 
	if LCMD() && CAPS() 
		iwa_xlsx_2()
	else mbind_2()
}
*3::
<^3::
LControl & 3::{ 
	if LCMD() && CAPS() 
		iwa_xlsx_3()
	else mbind_3()
}
*4::
<^4::
LControl & 4::{ 
	if LCMD() && CAPS() 
		iwa_xlsx_4()
	else mbind_4()
}
*5::
<^5::
LControl & 5::{ 
	if LCMD() && CAPS() 
		iwa_xlsx_5()
	else mbind_5()
}

*Tab::
<^Tab::
LControl & tab::{
	if LCMD() && CAPS()
		iwa_xlsx_tab()
	else mbind_tab()
}

*q::
<^q::
LControl & q::{ 
	if LCMD() && CAPS() 
		iwa_xlsx_q()
	else mbind_q() 
}
*w::
<^w::
LControl & w::{ 
	if LCMD() && CAPS()
		iwa_xlsx_w()
	else mbind_w()
}
*e::
<^e::
LControl & e::{ 
	if LCMD() && CAPS()
		iwa_xlsx_e()
	else mbind_e()
}
*r::
<^r::
LControl & r::{ 
	if LCMD() && CAPS()
		iwa_xlsx_r()
	else mbind_r()
}
*t::
<^t::
LControl & t::{ 
	if LCMD() && CAPS()
		iwa_xlsx_t()
	else mbind_t()
}
*a::
<^a::
LControl & a::{ 
	if LCMD() && CAPS() 
		iwa_xlsx_a()
	else mbind_a()
}
<^s::
LControl & s::{ 
	if LCMD() && CAPS() 
		iwa_xlsx_s()
	else mbind_s()
}
<^d::
LControl & d::{ 
	if LCMD() && CAPS() 
		iwa_xlsx_d()
	else mbind_d()
}
<^f::
LControl & f::{ 
	if LCMD() && CAPS() 
		iwa_xlsx_f()
	else mbind_f()
}
*g::
<^g::
LControl & g::{ 
	if LCMD() && CAPS()
		iwa_xlsx_g()
	else mbind_g()
}
*z::
<^z::
LControl & z::{ 
	if LCMD() && CAPS()
		iwa_xlsx_z()
	else mbind_z()
}
*x::
<^x::
LControl & x::{ 
	if LCMD() && CAPS()
		iwa_xlsx_x()
	else mbind_x()
}
*c::
<^c::
LControl & c::{ 
	if LCMD() && CAPS()
		iwa_xlsx_c()
	else mbind_c()
}
*v::
<^v::
LControl & v::{ 
	if LCMD() && CAPS() 
		iwa_xlsx_v()
	else mbind_v()
}
*b::
<^b::
LControl & b::{ 
	if LCMD() && CAPS() 
		iwa_xlsx_b()
	else mbind_b()
}
*u::
<^u::
LControl & u::{ 
	if LCMD() && CAPS()
		iwa_xlsx_u()
	else mbind_u()
}
*h::
<^h::
LControl & h::{ 
	if LCMD() && CAPS()
		iwa_xlsx_h()
	else mbind_h()
}
*i::
<^i::
LControl & i::{ 
	if LCMD() && CAPS()
		iwa_xlsx_i()
	else mbind_i()
}
*j::
<^j::
LControl & j::{ 
	if LCMD() && CAPS()
		iwa_xlsx_j()
	else mbind_j()
}
*k::
<^k::
LControl & k::{ 
	if LCMD() && CAPS()
		iwa_xlsx_k()
	else mbind_k()
}
*l::
<^l::
LControl & l::{ 
	if LCMD() && CAPS()
		iwa_xlsx_l()
	else mbind_l()
}
*o::
<^o::
LControl & o::{ 
	if LCMD() && CAPS()
		iwa_xlsx_o()
	else mbind_o()
}

#HotIf