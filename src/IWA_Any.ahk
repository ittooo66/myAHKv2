; 【DEPRECATED】AP個別定義
; ・定義部分だけコメントで一覧できるようにすること
; ・RDP時の挙動が安定しなくなる＆管理がしんどいので、使わない定義はなるべく削除すること
; ・PowerpointとExcel以外はここに雑多に追記していくこと

#HotIf WinActive("ahk_exe Code.exe")					;Visual Studio Code 個別定義 一式
	RButton & MButton::Send("^n")						;新規Tab
#HotIf

#HotIf WinActive("ahk_exe mpc-hc64.exe")				;MPC-HC 個別定義 一式
	XButton2 & WheelUp::Send("{Left}")					;戻る
	XButton2 & WheelDown::Send("{Right}")				;進む
	RButton & XButton1::Send("!{x}")					;閉じる
	XButton2 & LButton::MPC_intelliScroll()				;IntelliScroll
#HotIf

#HotIf WinActive("ahk_exe mpc-be64.exe")				;MPC-BE 個別定義 一式
	XButton2 & WheelUp::Send("{Left}")					;戻る
	XButton2 & WheelDown::Send("{Right}")				;進む
	RButton & XButton1::Send("!{x}")					;閉じる
	XButton2 & LButton::MPC_intelliScroll()				;IntelliScroll
	F20 & XButton1::Send("^{Up}")
	F20 & XButton2::Send("^{Down}")
#HotIf

#HotIf WinActive("ahk_exe vlc.exe")					    ;VLC 個別定義 一式
	XButton2 & WheelUp::Send("{Left}")					;戻る
	XButton2 & WheelDown::Send("{Right}")				;進む
	RButton & XButton1::Send("!{x}")					;閉じる
	XButton2 & LButton::MPC_intelliScroll()				;IntelliScroll
	F20 & XButton1::Send("^{Up}")
	F20 & XButton2::Send("^{Down}")
	XButton1::Send("p")
	XButton2::Send("n")
#HotIf

#HotIf WinActive("ahk_class CabinetWClass")				;WindowsExplorer 個別定義 一式

	RButton & WheelUp::Send("^+{Tab}")					;左へ
	*f::
	<^f::
	LControl & f::{ 
	if LCMD() && CAPS()
		Send("^{Tab}")
	else mbind_f()
	}

	RButton & WheelDown::Send("^{Tab}")					;右へ
	*s::
	<^s::
	LControl & s::{ 
	if LCMD() && CAPS()
		Send("^+{Tab}")
	else mbind_s()
	}

#HotIf

#HotIf WinActive("ahk_class VALORANTUnrealWindow")		
	;Valorant AHKバインド回避用上書き定義
	;  入力遅延回避のため、ゲーム操作用のキーは原則AHK管理外のキー(F1~F24,Num0~9)で操作させる。
	;  Spaceキーのみ特殊のためバインドを上書きして利用(AstralForm上昇がSpaceキー以外だとできない)
	Space::Space
#HotIf

#HotIf WinActive("ahk_class RiotWindowClass")
	;TFT AHKバインド回避用上書き定義
	;  無効でかぶせておけば直接入力側だけ入っていくのでそれでOK
	RButton::return
	XButton1::return
	XButton2::return
#HotIf

;よさげなスクロール(for MPC)
MPC_intelliScroll(){
	;初期マウス位置の取得
	MouseGetPos(&preMouseX, &preMouseY)
	while(GetKeyState("LButton","P") && MSBLF()){
		;現在マウス位置の取得
		MouseGetPos(&mouseX, &mouseY)
		;差分取得
		mouseDiffX :=mouseX-preMouseX
		;スクロール分量値調整
		diffPointX := Float(mouseDiffX/30)
		;abs変換
		absDiffPointX := abs(diffPointX)

		;Count値、Stack用意
		if (absDiffPointX = 0 ) {
			absDiffPointX := 1
		}
		sleepCount := float(100/absDiffPointX)
		sleepStack := 0

		;X方向適用
		while(absDiffPointX > 0){
			if(diffPointX>0.5)
				Send("{Left}")
			else if (diffPointX<-0.5)
				Send("{Right}")

			;スタック溜まったらSleep（１ミリSleepはまともに挙動しないので20程度見る）
			sleepStack +=sleepCount
			if(sleepStack > 20){
				Sleep(sleepCount)
				sleepStack := 0
			}

			absDiffPointX--
		}
	}
}
