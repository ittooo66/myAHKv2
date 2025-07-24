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
        mbind_space("Consume")

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
}

;直接入力、IME無視で文字列(string)(dat可)を入力する
directInput(string){
	;cb_bkに中身を退避
	cb_bk := ClipboardAll()
	try{
		;Clipboard経由で文字列一括入力
		A_Clipboard := ClipboardAll(string)
	}catch{
		;受け取ったstringがdatではなくstringだった場合、直接入力を行う
		A_Clipboard := string
	}
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

;Scripts配下のファイルを実行する
;scriptName:"ファイル名" 
;visible:可視性設定。デフォルトで非可視、""(空文字列指定)で可視。
execScripts(scriptName,visible:="hide",arg1:=0,arg2:=0,arg3:=0){
	script := A_WorkingDir . "\myAHKComponents\Tools\" . scriptName
	if InStr(scriptName , "ps1") {
		if (arg1=0 && arg2=0) {
			Run("pwsh.exe " script, , visible)
		}else{
			;やや反応おそめ。実行時引数が必要になった時だけ、こっちを使う
			RunWait("pwsh.exe -ExecutionPolicy Bypass -File `"" script "`" `"" arg1 "`" `"" arg2 "`"", , "Hide")
		}
	} else if InStr(scriptName, ".py") {
        ; Pythonスクリプトを実行（作業ディレクトリをスクリプトの場所に）
        Run("python " script, ,"Hide")
    } else {
		Run(script, , "hide")
	}
}

;よさげなスクロール
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

;ランチャ
;str:アプリ名称。バインドしたキー名称のアルファベットに合わせる
;shift:強制起動モード。1で有効化
;man:マニュアル起動モード(Windowsメニューから起動)。1で有効化、デフォルト0
;IEのとき：CLASS="IEFrame",PROCESS="",TITLE=""
;Outlookのとき：CLASS="rctrl_renwnd32",PROCESS="OUTLOOK.EXE",TITLE=""
;AppDirはmyAHKComponents\Resources\Apps配下。
launch(str, shift:=0, man:=0){
	
	;該当するショートカットがなければ、何もしない
	path := getEnv("APP_" . str . "_PATH")

	if !FileExist(path)
		{
			Splash("invalid Application path : " %path% )
			return
		}
	;強制起動モードの場合、strに紐づくアプリショートカットを起動して終了
	if (shift != 0){
		if (man = 1 ){
			name := getEnv("APP_" . str . "_PATH")
			Send("#{r}")
			Sleep(100)
			directInput(name)
			Send("{Enter}")
		}else{
			Run(path)
		}
	;通常モードの場合、	既存WindowをActivateして、いなければ起動
	}else{
		className := getEnv("APP_" . str . "_CLASS")
		processName := getEnv("APP_" . str . "_PROCESS")
		titleName := getEnv("APP_" . str . "_TITLE")
		if !activateWindow(className,processName,titleName) {
			if (man = 1){
				name := getEnv("APP_" . str . "_PATH")
				Send("#{r}")
				Sleep(100)
				directInput(name)
				Send("{Enter}")
			}else{
				Run(path)
			}
		}
	}
}

;通知メッセージの表示
;str:通知メッセージの文字列
;sleeptime:表示時間(ms)。未入力の場合はデフォルトで3秒(3000ms)表示
;mx,my:メッセージ表示場所。未入力の場合はマウスカーソル位置に表示
splash(str, sleeptime:=1500 ,width:=0 ,mx:=0,my:=0){
    if (mx = 0 && my = 0){
        MouseGetPos(&mx, &my)
        WinGetPos(&wx, &wy, , , "a")
        mx+=wx
        my+=wy
    }

    ; 現在のモニターのDPI取得
    hMonitor := DllCall("MonitorFromPoint", "int64", (mx & 0xFFFFFFFF) | (my << 32), "uint", 2, "ptr")
    dpi := GetDpiForMonitor(hMonitor)
    scale := dpi / 96

    ; フォントサイズをスケーリング
    fontSize := Round(16 * scale)

    splashGui := Gui()
    splashGui.SetFont("s" fontSize " c12d4b4 bold")
    splashGui.BackColor := "000000"
    splashGui.Opt("-Caption +AlwaysOnTop")

    splashGui.addText(, str)
    splashGui.Show("x" . mx . " y" . my)
    Sleep sleeptime
    splashGui.Destroy
}

; GetDpiForMonitor 関数の定義
GetDpiForMonitor(hMonitor) {
    ; Windows 8.1以降必要
    return DllCall("Shcore\GetDpiForMonitor"
        , "ptr", hMonitor
        , "int", 0  ; MDT_EFFECTIVE_DPI
        , "uint*", &dpiX := 0
        , "uint*", &dpiY := 0
    ) = 0 ? dpiX : 96  ; 失敗時は96dpiとみなす
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

;ウィンドウの移動
moveWindow(){
	hwnd := WinExist("A")  ; アクティブウィンドウのハンドルを取得
    if hwnd {
        PostMessage(0x112, 0xF010, , , hwnd)  ; WM_SYSCOMMAND + SC_MOVE
        Sleep(50)
        Send("{Left}{Right}")  ; 任意のキーで移動モードを開始
    }
}

;AHKのリロード
AHK_Reload(){
    splash("Reloading AHK...", 300)
    logger("AHK Reloaded")
	Reload()
}

;AHKの停止
AHK_Exit(){
    splash("Shutting down AHK...", 500)
	execScripts("mouseCursor_standard.ps1")
	logger("AHK Exit")
	ExitApp()
}

;AHKのサスペンド
AHK_Suspend(){
	if !A_IsSuspended {
		Suspend
		execScripts("mouseCursor_standard.ps1")
		splash("Suspending AHK...", 300)
		logger("AHK Suspend Enabled")
	}else{
		splash("AHK is already suspended.", 300)
	}
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
	
	;Space Up入れるとlaunchのマニュアル起動がバグるので抜く?
	Send("{Space Up}")
}

;PhilipsHue用関数
philipsHue(state, bri:=0, ct:=0){
	if state = 0 {
		Run('curl -X PUT "http://192.168.10.20/api/wYcnCswCImWhoyfzFtGKhVgsS-W8H6J1S1LjcVbq/lights/2/state" -d "{\"on\":false}"', , "Hide")
		Run('curl -X PUT "http://192.168.10.20/api/wYcnCswCImWhoyfzFtGKhVgsS-W8H6J1S1LjcVbq/lights/3/state" -d "{\"on\":false}"', , "Hide")
	}else{
		Run('curl -X PUT http://192.168.10.20/api/wYcnCswCImWhoyfzFtGKhVgsS-W8H6J1S1LjcVbq/lights/2/state -d "{\"on\":true,\"bri\":' . bri . ',\"ct\":' . ct . '}"', , "Hide")
		Run('curl -X PUT http://192.168.10.20/api/wYcnCswCImWhoyfzFtGKhVgsS-W8H6J1S1LjcVbq/lights/3/state -d "{\"on\":true,\"bri\":' . bri . ',\"ct\":' . ct . '}"', , "Hide")
	}
}