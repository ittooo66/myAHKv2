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
	FileAppend(log, A_WorkingDir "\" label ".log")
}
