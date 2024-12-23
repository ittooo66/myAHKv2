;特定のWindowクラスを最下層から引っ張る
;className:クラス名。空指定（""）の場合、Class指定なし
;processName:プロセス名。idea.exeとかそういうやつ。空指定（""）の場合、Process指定なし
;titleName:タイトル。空指定（""）の場合、Title指定なし
;multi:該当Windowの複数フックモード、デフォルトは無効(0)
;===返り値===
;true:引っ張ってこれた
;false:存在しなかった
activateWindow(className := "", processName := "", titleName := "", multi := 0) {
    ; Spaceバインドで呼び出している場合、Spaceキーを消費
    if (SPACE())
        consumeSpace()

    ; 配列idsに現在稼働中のWindowを突っ込む
    ids := WinGetList(,,"Program Manager")

	; idsを反転した配列を生成
	idsR := Array()
	for id in ids
	    idsR.InsertAt(1, id) ; InsertAtを使用して先頭に挿入することで反転を作成

	; 最下層から順番に検索
    for i, this_id in idsR {
        ; this_idのClass, Title, Processを取得
        this_class := WinGetClass(this_id)
		this_process := WinGetProcessName(this_id)
        this_title := WinGetTitle(this_id)

        ; class一致確認
        if (className = "" or InStr(this_class, className)) {
            ; process一致確認
            if (processName = "" or InStr(this_process, processName)) {
				; title一致確認
				if (titleName = "" or InStr(this_title, titleName)) {
                    ; 最前面に表示
                    WinActivate(this_id)
                    if (multi = 0) {
                        return true
                    }
                }
            }
        }
    }
    return false
}

;最小化されているウィンドウをすべてアクティブにする
activeAllWindow(){
    ; 配列idsに現在稼働中のWindowを突っ込む
    ids := WinGetList(,,"Program Manager")

	; 最下層から順番に検索
    for i, this_id in ids {
		WinActivate("ahk_id " this_id)
	}
}

;修飾キー付きのkeypress
press(key){
	;修飾キー変数
	modifiers := ""
	;修飾キー検知して追加
	if LCMD()
		modifiers := modifiers . "^"
	if SHIFT()
		modifiers := modifiers . "+"
	if LALT()
		modifiers := modifiers . "!"
	if RALT()
		modifiers := modifiers . "#"
	;修飾キーつきkeyPress
	Send(modifiers "" key)
	;log出力
	;logger_key(key)
}

;直接入力、IME無視で文字列(string)(dat可)を入力する
directInput(string){
	;cb_bkに中身を退避
	cb_bk := ClipboardAll()
	;Clipboard経由で文字列一括入力
	A_Clipboard := ClipboardAll(string)
	;Clipboard の変更を待機
	Sleep(50)
	;文字列貼り付け
	Send("^v")
	;入力完了を待ってClipboard内容を復元(要Tuning)
	Sleep(200)
	A_Clipboard := cb_bk
}

;外部変数への書き込み
;揮発性なし（Reload,再起動でも値は普遍）
;書き方：setEnv("var","true")でvar.txtにtrueが書き込まれる
setEnv(name, param){
	FileDelete(A_WorkingDir "\Env\" name ".txt")
	FileAppend(param, A_WorkingDir "\Env\" name ".txt")
}

;外部変数の読み込み
;揮発性なし（Reload,再起動でも値は普遍）
;書き方：getEnv("var")でvar.txt内部の文字列を取得する
getEnv(name){
	Try file := FileRead(A_WorkingDir "\Env\" name ".txt")
	Catch
		return ""

	return file
}

;Scripts配下のファイルを実行する ● TODO
;scriptName:"ファイル名" 
execScripts(scriptName,arg1:=0,arg2:=0){
	script := A_WorkingDir . "\myAHKComponents\Tools\" . scriptName
	if InStr(scriptName , "ps1") {
		if (arg1=0 && arg2=0) {
			Run("powershell.exe " script, , "hide")
		}else{
			;やや反応おそめ。実行時引数が必要になった時だけ、こっちを使う
			RunWait("powershell.exe -ExecutionPolicy Bypass -File `"" script "`" `"" arg1 "`" `"" arg2 "`"", , "Hide")
		}
	} else {
		Run(script, , "hide")
	}
}

;よさげなスクロール
intelliScroll(){
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

;ランチャ
;str:アプリ名称。バインドしたキー名称のアルファベットに合わせる
;shift:強制起動モード。1で有効化
;IEのとき：CLASS="IEFrame",PROCESS="",TITLE=""
;Outlookのとき：CLASS="rctrl_renwnd32",PROCESS="OUTLOOK.EXE",TITLE=""
;AppDirはmyAHKComponents\Resources\Apps配下。
launch(str, shift:=0){
	
	;該当するショートカットがなければ、何もしない
	path := getEnv("APP_" . str . "_PATH")

	if !FileExist(path)
		{
			Splash("invalid Application path : " %path% )
			return
		}
	;強制起動モードの場合、strに紐づくアプリショートカットを起動して終了
	if (shift != 0){
		Run(path)

	;通常モードの場合、	既存WindowをActivateして、いなければ起動
	}else{
		className := getEnv("APP_" . str . "_CLASS")
		processName := getEnv("APP_" . str . "_PROCESS")
		titleName := getEnv("APP_" . str . "_TITLE")
		if !activateWindow(className,processName,titleName) 
			Run(path)
	}
}

;通知メッセージの表示
;str:通知メッセージの文字列
;sleeptime:表示時間(ms)。未入力の場合はデフォルトで3秒(3000ms)表示
;mx,my:メッセージ表示場所。未入力の場合はマウスカーソル位置に表示
splash(str, sleeptime:=3000 ,width:=0 ,mx:=0,my:=0){
	if (mx = 0 && my = 0){
		MouseGetPos(&mx, &my)
		WinGetPos(&wx, &wy, , , "a")
		mx+=wx
		my+=wy
	}

	; 新しいGUIオブジェクトを作成
	splashGui := Gui()

	; GUI設定：フォント
	splashGui.SetFont("s16 c12d4b4 bold")
	; GUI設定：背景
	splashGui.BackColor := "000000"
	; GUI設定：キャプション無効
	splashGui.Opt("-Caption")

	; テキストを追加
	splashGui.addText(, str)

	; n秒間表示
	splashGui.Show("x" . mx . " y" . my)
	Sleep sleeptime
	splashGui.Destroy()
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
	buffer := 9999
	
	;ポイント調整:Y
	Loop 50
	{
		diffX := -25 + A_Index
		MouseMove(rawX + diffX , rawY + 25 , 0)
		if ( A_Cursor = "SizeWE"){
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
	Loop 50
	{
		diffY := 25 - A_Index
		MouseMove(rawX + 25 , rawY + diffY, 0)
		if ( A_Cursor = "SIZENS" ){
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

	Send("{LButton Down}")
	BlockInput "off"
	
	while(MRB()){
		Sleep(50)
	}
	Send("{LButton Up}")
}

;ウィンドウの移動
moveWindow(){
	Send("!{Space}")
	Sleep(150)
	Send("{m}")
	Sleep(100)
	Send("{Left}{Right}")
}

;AHKのリロード
AHK_Reload(){
	#SuspendExempt
	splash("AHK reloading...",300)
	logger("AHK RELOADED")
	Reload()
}

;AHKの停止
AHK_Exit(){
	#SuspendExempt
	splash("AHK shutting down...",500)
	execScripts("mouseCursor_standard.ps1")
	logger("AHK EXIT")
	ExitApp()
}

;修飾キーの押しっぱなし問題解除用
resetMods(){
	Send("{RWin Up}")
	Send("{LWin Up}")
	Send("{LAlt Up}")
	Send("{RAlt Up}")
	Send("{LShift Up}")
	Send("{RShift Up}")
	Send("{LControl Up}")
	Send("{RControl Up}")
}