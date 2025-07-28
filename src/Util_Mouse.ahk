;マウス操作関係

;key: イベント対象のキー4つ
ControlMouse(keyUp,keyDown,keyLeft,keyRight,val:=2,slp:=10){
	while(GetKeyState(keyUp,"P") || GetKeyState(keyDown,"P") || GetKeyState(keyLeft,"P") || GetKeyState(keyRight,"P")){

		;移動
		MoveY := val*(GetKeyState(keyDown, "P") - GetKeyState(keyUp, "P"))
		MoveX := val*(GetKeyState(keyRight, "P") - GetKeyState(keyLeft, "P") )

		MouseMove(MoveX,MoveY,0,"R")
		Sleep 1
	}
}

;key: イベント対象のキー4つ
ControlMouseFast(keyUp,keyDown,keyLeft,keyRight){
	ControlMouse(keyUp,keyDown,keyLeft,keyRight,30,10)
}

;マウスカーソルを中央に配置
mouseCursorResetToCenter(){

		;現在のディスプレイ枚数を取得
		cnt := MonitorGetCount()

		CoordMode("Mouse","Screen")
		MouseGetPos(&x, &y)
		
		;各画面位置に応じた補正を行い、対象ウィンドウの左上中心として(rawX,rawY)を取得
		if (cnt > 1 && x > 2560){
			;EIZO 27-4K-60Hz のとき
			MouseMove(4480,1080,0)
		}else{
			;DELL 27-WQHD-144Hz のとき
			MouseMove(1280,720,0)
		}	

}

;マウスの左クリックエミュレート
mousePress(leftButtonKey){
	Send("{LButton Down}")
	while(GetKeyState(leftButtonKey,"P")){
		Sleep(100)
	}
	Send("{LButton Up}")
}

; マウスのドラッグ操作に応じて、スクロールを行う関数。
; 左マウスボタン + サイドボタン（進むボタン）を押しながらマウスを移動することで、
; 水平方向または垂直方向にスクロールする。
; 移動量に応じてスクロール速度と回数を調整する動的な挙動を提供する。
intelliScroll(){
	;初期マウス位置の取得
	MouseGetPos(&preMouseX, &preMouseY)
	while(MLB() && MSBLF()){
		;現在マウス位置の取得
		MouseGetPos(&mouseX, &mouseY)
		
		;差分取得
		mouseDiffX :=mouseX-preMouseX
		mouseDiffY :=mouseY-preMouseY

		;スクロール分量値調整
		diffPointY := Float(mouseDiffY/30)
		diffPointX := Float(mouseDiffX/50)

		;絶対値取得
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
					Send("{WheelLeft}")
				else
					Send("{WheelRight}")

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
				;ToolTip(absDiffPointY)
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

;ウィンドウサイズ変更
;ディスプレイ設定(DPIスケール、モニタ配置)に大幅に依存してるので、注意
changeWindowSize(){
	;新セット発見時、再試行ですぐ消せるように定義
	ToolTip

	; Grab成功判定
	grabSuccess := 0

	; アクティブウィンドウの左上(x=0,y=0)に即時(=0)移動し、カーソル変化が起きるまでSleep()
	MouseMove(0, 0, 0)
	Sleep(5)

	; カーソルが左上-右下の矢印になっている場合、成功
	if(A_Cursor = "SizeNWSE")
		grabSuccess := 1

	; ここまでの処理でうまく掴めてない場合、試行錯誤を実施
	if(!grabSuccess)
		grabSuccess := MouseMove_NWSE(-3,+2) ; Windows Explorer (Low Dpi)
	if(!grabSuccess)
		grabSuccess := MouseMove_NWSE(-6,+4) ; Windows Explorer (High Dpi)
	if(!grabSuccess)
		grabSuccess := MouseMove_NWSE(-4,-24) ; Joplin & Mery (Low Dpi)
	if(!grabSuccess)
		grabSuccess := MouseMove_NWSE(-5,-38) ; Joplin & Mery (High Dpi)

	; 試行錯誤で何ともならなかった場合、x,yの新セットを捜索
	if(!grabSuccess){
		x := 0
		y := 0
		xTemp := 9999
		;ポイント調整:X(-10~10),Yは30で固定
		Loop 20 {
			x := -10 + A_Index
			MouseMove(x, 30, 0)
			if ((A_Cursor = "SizeWE") && (xTemp = 9999)){
				xTemp := x
			}else if (xTemp != 9999){
				x := (x + xTemp)/2
				break
			}
		}
		;ポイント調整:Y(10 ~ -50),Xは前半の調整値で固定
		Loop 60 {
			y := 10 - A_Index
			MouseMove(x, y, 0)
			if ( A_Cursor = "SizeNWSE")
				break
		}
		tooltip("New Window Type : x=" . x . ", y=" y)
	}

	; GrabWindow操作を実施
	Send("{LButton Down}")
	while(MRB()&&MLB())
		Sleep(100)
	Send("{LButton Up}")
}

MouseMove_NWSE(x,y){
	MouseMove(x, y, 0)
	Sleep(5)
	if(A_Cursor = "SizeNWSE")
		return 1
	else
		return 0
}