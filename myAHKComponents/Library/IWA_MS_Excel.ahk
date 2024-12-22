;Excel 個別バインド一式
#HotIf WinActive("ahk_class XLMAIN")

; Excelバインド - セル関連
*d::{ 
	if LCMD() && CAPS() 
		Send("!{h}{h}")							; セル：背景色変更
	else mbind_d()
}
*q::{
	if LCMD() && CAPS() 
		Send("!{o}{c}{a}")						; セル：幅調整
	else mbind_q() 
}
*g::{
	if LCMD() && CAPS()
		Send("!{h}{m}{c}")						; セル：結合/結合解除
	else mbind_g()
}

; Excelバインド - 文字列関連
*w::{
	if LCMD() && CAPS()
		Send("!{h}{a}{l}")						; 文字列：左寄せ
	else mbind_w()
}
*e::{
	if LCMD() && CAPS()
		Send("!{h}{a}{c}")						; 文字列：中央寄せ
	else mbind_e()
}
*r::{
	if LCMD() && CAPS()
		Send("!{h}{a}{r}")						; 文字列：右寄せ	
	else mbind_r()
}
*t::{
	if LCMD() && CAPS(){
		Send("!{h}{f}{c}")						; 文字列：赤字
	}else mbind_t()
}

; Excelバインド - 罫線関連
*u::{
	if LCMD() && CAPS()
		Send("!{h}{b}{a}")						; 罫線：格子
	else mbind_u()
}
*h::{
	if LCMD() && CAPS()
		Send("!{h}{b}{n}")						; 罫線：削除
	else mbind_h()
}
*i::{
	if LCMD() && CAPS()
		Send("!{h}{b}{p}")						; 罫線：上
	else mbind_i()
}
*j::{
	if LCMD() && CAPS()
		Send("!{h}{b}{l}")						; 罫線：左
	else mbind_j()
}
*k::{
	if LCMD() && CAPS()
		Send("!{h}{b}{o}")						; 罫線：下
	else mbind_k()
}
*l::{
	if LCMD() && CAPS()
		Send("!{h}{b}{r}")						; 罫線：右
	else mbind_l()
}
*o::{
	if LCMD() && CAPS()
		Send("!{h}{b}{s}")						; 罫線：外枠
	else mbind_o()
}

; Excelバインド - パッチ関連
Shift & Space::{
	Send("+{Space}")							; 挙動是正パッチ
}

;スクロール機能一式
XButton2 & WheelUp::{
	SetScrollLockState("On")
	Send("{Left}")
	SetScrollLockState("Off")
}
XButton2 & WheelDown::{
	SetScrollLockState("On")
	Send("{Right}")
	SetScrollLockState("Off")
}
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
					Send("{Left}") 		;Excel_scrollRight()
				else
					Send("{Right}") 	;Excel_scrollLeft()
				
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

#HotIf