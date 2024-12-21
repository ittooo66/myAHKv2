;マウス操作関係

;ウィンドウサイズ変更
;ディスプレイ設定(DPIスケール、モニタ配置)に大幅に依存してるので、注意
changeWindowSize(){
	

	;画面情報を取得
	;X,Y:スケーリング後のアクティブウインドウの左上のピクセル位置（モニタ1の左上(0,0)からのX:Y座標）
	;W,H:スケーリング後のアクティブウインドウ幅(W),高さ(H)
	WinGetPos(&X, &Y, &W, &H, "A")
	BlockInput("MouseMove")

	;現在のディスプレイ枚数を取得
	cnt := MonitorGetCount()

	;各画面位置に応じた補正
	if (cnt > 1 && X > 2560){
		; DELL 27-WQHD-144Hz のとき
		rawX := (X-2560)/2
		rawY := (Y+722)/2
	}else{
		;EIZO 27-4K-60Hz のとき
		rawX := 0
		rawY := 0
		;rawX := -X/3
		;rawY := -Y/3
	}

	diffX := 0
	diffY := 0

	;ポイント調整:Y
	Loop 50
	{
		diffX := -25 + A_Index
		MouseMove(rawX + diffX , rawY + 25 , 0)
		if ( A_Cursor = "SizeWE"){
			break
		}
	}
	;ポイント調整:X
	Loop 50
	{
		diffY := 25 - A_Index
		MouseMove(rawX + diffX , rawY + diffY, 0)
		if ( A_Cursor = "SizeNWSE" ){
			MouseMove(RawX + diffX - 1 , rawY + diffY - 1, 0.1)
			break
		}
	}

	Send("{LButton Down}")
	BlockInput("MouseMoveOff")
	
	while(MRB()){
		Sleep(50)
	}
	Send("{LButton Up}")
}

;ウィンドウの移動
moveWindow(){
	Send("!{Space}")
	Sleep(200)
	Send("{m}{Left}{Right}")
}

;key: イベント対象のキー4つ
;mouseMove(keyUp,keyDown,keyLeft,keyRight,val:=5,slp:=10){
;	while(GetKeyState(keyUp,"P") || GetKeyState(keyDown,"P") || GetKeyState(keyLeft,"P") || GetKeyState(keyRight,"P")){
;
;		;移動
;		MoveY += GetKeyState(keyUp, "P") ? -val : 0
;		MoveX += GetKeyState(keyLeft, "P") ? -val : 0
;		MoveY += GetKeyState(keyDown, "P") ? val : 0
;		MoveX += GetKeyState(keyRight, "P") ? val : 0
;
;		;Powershellによるマウス移動
;		;※ HiDPIディスプレイ混成環境にてAHK純正のMouseMoveがバグるため、ps1化
;		execScripts("MouseMove.ps1", MoveX, MoveY )
;		
;		;Control系処理
;		Sleep(slp)
;		val++
;
;	}
;}

;key: イベント対象のキー4つ
mouseMoveFast(keyUp,keyDown,keyLeft,keyRight){
;	mouseMove(keyUp,keyDown,keyLeft,keyRight,50,10)
}

;マウスカーソルを中央に配置
mouseCursorResetToCenter(){

	;Mouse関連機能を絶対座標モードに変更
	CoordMode("Mouse", "Screen")

	;各モニタの表示倍率値(DPIScale取得が各モニタ毎にできなかったのでこの形式)
	monitor1_dpi := 1
	monitor2_dpi := 1.5

	;各モニタの設定値を取得(paramが逆っぽいのでこの形式)
	MonitorGet(2, &mon1Left, &mon1Top, &mon1Right, &mon1Bottom)
	MonitorGet(1, &mon2Left, &mon2Top, &mon2Right, &mon2Bottom)

	;各モニタの幅・高さを取得
	monitor1_width := (mon1Right - mon1Left)*monitor1_dpi
	monitor1_height := (mon1Bottom - mon1Top)*monitor1_dpi
	monitor2_width := (mon2Right - mon2Left)*monitor2_dpi
	monitor2_height := (mon2Bottom - mon2Top)*monitor2_dpi

	;Mouseの座標を取得(中途半端にDPIスケールがかかっている)
	MouseGetPos(&X, &Y, , , 1)

	;中央の絶対座標(画面左上からのpixel値：mouseW,mouseH)を取得
	if( mon1Left < X && X < mon1Right && mon1Top < Y && Y < mon1Bottom){
		;Monitor1のとき
		mouseW := mon1Left+monitor1_width/2
		mouseH := mon1Top+monitor1_height/2
	}else{
		;Monitor2のとき
		mouseW := mon2Left+monitor2_width/2
		mouseH := mon2Top+monitor2_height/2
	}
	;Mouseを中央に移動
	MouseMove(mouseW, mouseH, 0, "R")
}

;マウスの左クリックエミュレート
mousePress(leftButtonKey){
	Send("{LButton Down}")
	while(GetKeyState(leftButtonKey,"P")){
		Sleep(100)
	}
	Send("{LButton Up}")
}
