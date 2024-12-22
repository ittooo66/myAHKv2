;マウス操作関係

;key: イベント対象のキー4つ
ControlMouse(keyUp,keyDown,keyLeft,keyRight,val:=5,slp:=10){
	while(GetKeyState(keyUp,"P") || GetKeyState(keyDown,"P") || GetKeyState(keyLeft,"P") || GetKeyState(keyRight,"P")){

		;移動
		MoveY += GetKeyState(keyUp, "P") ? -val : 0
		MoveX += GetKeyState(keyLeft, "P") ? -val : 0
		MoveY += GetKeyState(keyDown, "P") ? val : 0
		MoveX += GetKeyState(keyRight, "P") ? val : 0

		;Powershellによるマウス移動
		;※ HiDPIディスプレイ混成環境にてAHK純正のMouseMoveがバグるため、ps1化
		execScripts("MouseMove.ps1", MoveX, MoveY )
		
		;Control系処理
		Sleep(slp)
		val++

	}
}

;key: イベント対象のキー4つ
ControlMouseFast(keyUp,keyDown,keyLeft,keyRight){
	ControlMouse(keyUp,keyDown,keyLeft,keyRight,50,10)
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


;log出力機能
logger( message , label:="info" ){
	;日付情報の作成
	year := FormatTime(, "yyyy")
	month := FormatTime(, "MM")
	day := FormatTime(, "dd")
	hour := FormatTime(, "HH")
	minute := FormatTime(, "mm")
	second := FormatTime(, "ss")
	logger_date := year . "-" . month . "-" . day . " " . hour . ":" . minute ":" . second . "." . A_MSec . " "
	log := logger_date . message . "`n"
	FileAppend(log, A_WorkingDir "\myAHKComponents\Resources\Log\" label ".log")
}
