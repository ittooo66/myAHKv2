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

;ウィンドウサイズ変更
;ディスプレイ設定(DPIスケール、モニタ配置)に大幅に依存してるので、注意
changeWindowSize(){

	;マウス位置を固定
	BlockInput "Mouse"

	;画面情報を取得
	;X,Y:スケーリング後のアクティブウインドウの左上のピクセル位置（モニタ1の左上(0,0)からのX:Y座標）
	;W,H:スケーリング後のアクティブウインドウ幅(W),高さ(H)
	WinGetPos(&X, &Y, &W, &H, "A")
	
	;現在のディスプレイ枚数を取得
	cnt := MonitorGetCount()

	;対象ウィンドウの左上中心として(rawX,rawY)を取得
	rawX := 0
	rawY := 0

	; 渦巻きの最大半径
	maxRadius := 5

	; 現在の位置と方向
	x := rawX
	y := rawY
	step := 1

	; 初期方向 (右方向)
	dx := 1
	dy := 0

	; 現在のスパイラルの幅と方向切り替えカウンタ
	currentWidth := 1
	stepCounter := 0
	turns := 0

	; Grab成功判定
	grabSuccess := 0

	Loop {
		; マウスカーソル妥当性判定
		MouseMove(x , y , 0)
		if ( A_Cursor = "SizeNWSE"){
			grabSuccess := 1
			break
		}

		; 次の座標に移動
		x += dx
		y += dy

		stepCounter++

		; 指定した幅分進んだら方向を変更
		if (stepCounter = currentWidth) {
			stepCounter := 0
			turns++

			; 時計回りに方向を変更
			if (dx = 1 && dy = 0) { ; 右 → 下
				dx := 0
				dy := 1
			} else if (dx = 0 && dy = 1) { ; 下 → 左
				dx := -1
				dy := 0
			} else if (dx = -1 && dy = 0) { ; 左 → 上
				dx := 0
				dy := -1
			} else if (dx = 0 && dy = -1) { ; 上 → 右
				dx := 1
				dy := 0
			}

			; 方向を2回変更した後、幅を1増やす
			if Mod(turns, 2) = 0
				currentWidth++
		}

		; 渦巻きの最大範囲を超えたら終了
		if Abs(x - rawX) > maxRadius || Abs(y - rawY) > maxRadius
			break
	}

	;前述のうずまき戦法で掴み切れなかった場合、後述の十字戦法で掴みに行く
	;Joplin, Meryなどはこちらじゃないと掴めない
	if(grabSuccess = 0){
		diffX := 0
		diffY := 0
		buffer := 9999
	
		;ポイント調整:Y
		Loop 20
			{
				diffX := -10 + A_Index
				MouseMove(rawX + diffX , rawY + 30 , 100)
				if ( A_Cursor = "SizeNWSE"){
					buffer := 9999
					break
				}if ( A_Cursor = "SizeWE"){
					if(buffer = 9999){
						buffer := diffX
					}
				}else if (buffer != 9999){
					diffX := (diffX + buffer)/2
					buffer := 9999
					break
				}
			}
		;ポイント調整:X
		Loop 60
		{
			diffY := 10 - A_Index
			MouseMove(rawX + diffX , rawY + diffY, 100)
			if ( A_Cursor = "SizeNWSE"){
				buffer := 9999
				break
			}if ( A_Cursor = "SIZENS" ){
				if(buffer = 9999){
					buffer := diffY
				}
			}else if (buffer != 9999){
				diffY := (diffY + buffer)/2
				buffer := 9999
				break
			}
		}
		MouseMove(RawX + diffX , rawY + diffY , 0)
	}
	
	Send("{LButton Down}")
	BlockInput "off"
	
	while(MRB()&&MLB()){
		Sleep(50)
	}
	Send("{LButton Up}")
}