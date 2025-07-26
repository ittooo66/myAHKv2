; 指定された条件（クラス名・プロセス名・タイトル名）に一致するウィンドウをアクティブ化する関数。
; ウィンドウはZオーダーの下位（背面）から順に検索され、最初に一致したものをアクティブにする。
; オプションで複数一致させる処理も可能。
;
; パラメータ:
;   className   - ウィンドウクラス名（部分一致、空文字で無条件）
;   processName - プロセス名（部分一致、空文字で無条件）
;   titleName   - ウィンドウタイトル（部分一致、空文字で無条件）
;   multi       - 複数ウィンドウ一致許可フラグ（0: 最初に一致したウィンドウのみアクティブ化, 1: 一致する全ウィンドウをアクティブ化）
;
; 戻り値:
;   一致するウィンドウが見つかってアクティブ化された場合は true、見つからなければ false。
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

; 指定された名前と値を環境設定ファイル(env.yaml)に保存する関数。
; 既存のキーがあれば上書きし、なければ新しく追加する。
; パラメータ:
;   name  - 設定するキー名 (文字列)
;   param - 設定する値 (文字列)
setEnv(name, param) {
    envMap := Map()

	yaml := FileRead(A_WorkingDir "\env\env.yaml")
	Loop Parse, yaml, "`n", "`r"
	{
		if RegExMatch(A_LoopField, "^\s*(\S+)\s*:\s*(.*)$", &m)
			envMap[m[1]] := m[2]
	}
	
    ; 値を更新
    envMap[name] := param

    ; YAMLとして保存
    out := ""
    for key, val in envMap
        out .= key ": " val "`n"

    FileDelete(A_WorkingDir "\env\env.yaml")
    FileAppend(out, A_WorkingDir "\env\env.yaml")
}

; 環境設定ファイル(env.yaml)から指定された名前の値を取得する関数。
; 指定したキーが存在しない場合は空文字を返す。
; パラメータ:
;   name - 取得するキー名 (文字列)
; 戻り値:
;   対応する値 (文字列)、または見つからなければ空文字
getEnv(name) {
    yaml := FileRead(A_WorkingDir "\env\env.yaml")
    Loop Parse, yaml, "`n", "`r"
    {
        if RegExMatch(A_LoopField, "^\s*(\S+)\s*:\s*(.*)$", &m)
            if (m[1] = name)
                return m[2]
    }
    return ""
}

; 指定されたスクリプトファイル（PowerShell または Python）を実行する関数。
; 対応拡張子は .ps1（PowerShell）および .py（Python）。
; スクリプトが存在しない場合や未対応の拡張子の場合はエラーメッセージを表示。
;
; パラメータ:
;   scriptName - 実行するスクリプトファイル名（tools フォルダ内）
;   visible    - 実行時のウィンドウ表示状態（省略時は "Hide"）
;   arg        - スクリプトに渡す追加の引数（省略可）
execScripts(scriptName, visible := "Hide", arg := "") {
	
	; スクリプトファイル存在チェック
	scriptPath := A_WorkingDir "\tools\" scriptName
    if !FileExist(scriptPath) {
        MsgBox "スクリプトが存在しません: " scriptPath
        return
    }

    SplitPath(scriptPath, , , &ext)

    switch ext {
        case "ps1":
            runner := "pwsh.exe"
            cmd := '-ExecutionPolicy Bypass -File "' scriptPath '" ' arg
        case "py":
            runner := "python"
            cmd := '"' scriptPath '" ' arg
        default:
            MsgBox "サポートされていない拡張子: " ext
            return
    }

    Run runner " " cmd, , visible
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

; 環境変数に定義されたアプリケーションを起動、または既存のウィンドウをアクティブにする関数。
; ショートカットやウィンドウのクラス名・プロセス名・タイトルに基づいて起動制御を行う。
;
; パラメータ:
;   str   - アプリケーション識別子（例: "EXCEL" → APP_EXCEL_PATH などの環境変数に対応）
;   shift - 強制起動フラグ（≠0 で強制起動モード。0 なら通常起動モード）
;   man   - 手動入力モード（1 の場合、Win+R ダイアログ経由で直接コマンド入力）
;
; 動作概要:
;   - shift ≠ 0（強制起動）:
;       man = 1 : Win+R ダイアログでアプリのパスを直接入力して起動
;       man ≠ 1 : Run コマンドで直接実行
;   - shift = 0（通常起動）:
;       - 対象ウィンドウが存在する場合はアクティブ化
;       - 存在しない場合は起動（man の値により起動方法を分岐）
launch(str, shift:=0, man:=0){
	
	;該当するショートカットがなければ、何もしない
	path := getEnv("APP_" . str . "_PATH")
	if !FileExist(path)	{
		splash("invalid Application path : " . path )
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


; 指定したテキストを、マウス位置または指定位置に一時的にスプラッシュ表示する関数。
; DPIスケーリングに対応し、現在のモニターの解像度に合わせた表示を行う。
;
; パラメータ:
;   str       - 表示する文字列（スプラッシュメッセージ）
;   sleeptime - 表示持続時間（ミリ秒、デフォルト: 1500ms）
;   width     - （未使用）GUIの幅。将来的な拡張用（現在は0）
;   mx, my    - スプラッシュ表示位置の座標。省略時は現在のマウス位置＋アクティブウィンドウ位置
splash(str, sleeptime := 1500, width := 0, mx := 0, my := 0) {
    if (mx = 0 && my = 0) {
        MouseGetPos(&mx, &my)
        WinGetPos(&wx, &wy, , , "A")
        mx += wx
        my += wy
    }

    ; DPI取得（内部関数として統合）
    GetDpiForMonitor(hMonitor) {
        return DllCall("Shcore\GetDpiForMonitor"
            , "ptr", hMonitor
            , "int", 0  ; MDT_EFFECTIVE_DPI
            , "uint*", &dpiX := 0
            , "uint*", &dpiY := 0
        ) = 0 ? dpiX : 96  ; 失敗時は96dpiとみなす
    }

    hMonitor := DllCall("MonitorFromPoint", "int64", (mx & 0xFFFFFFFF) | (my << 32), "uint", 2, "ptr")
    dpi := GetDpiForMonitor(hMonitor)
    scale := dpi / 96

    fontSize := Round(16 * scale)

    splashGui := Gui()
    splashGui.SetFont("s" fontSize " c12d4b4 bold")
    splashGui.BackColor := "000000"
    splashGui.Opt("-Caption +AlwaysOnTop")

    splashGui.AddText(, str)
    splashGui.Show("x" . mx . " y" . my)
    Sleep sleeptime
    splashGui.Destroy
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
	resetMods()
}

;AHKの停止
AHK_Exit(){
    splash("Shutting down AHK...", 500)
	execScripts("SetMouseCursor.ps1",,"standard")
	logger("AHK Exit")
	ExitApp()
}

;AHKのサスペンド
AHK_Suspend(){
	if !A_IsSuspended {
		Suspend
		execScripts("SetMouseCursor.ps1",,"standard")
		splash("Suspending AHK...", 300)
		logger("AHK Suspend Enabled")
	}else{
		splash("AHK is already suspended.", 300)
	}
}

;修飾キーの押しっぱなし問題解除用
resetMods(){
	if LCMD() 
		Send("{vkEB Up}{LWin Up}")
	if RCMD()
		Send("{vkFF Up}{RWin Up}")
	if CAPS()
		Send("{LControl Up}{RControl Up}{sc03a Up}")
	if SHIFT()
		Send("{LShift Up}{RShift Up}")
	if SPACE()
		Send("{Space Up}")
	if ALT()
		Send("{LAlt Up}{RAlt Up}")
	if MLB()
		Send("{LButton Up}")
	if MRB()
		Send("{RButton Up}")
	if MMB()
		Send("{MButton Up}")
	if MSBLB()
		Send("{XButton1 Up}")
	if MSBLF()
		Send("{XButton2 Up}")
	if MSBRF()
		Send("{F19 Up}{Ctrl Up}{Alt Up}")
	if MSBRB()
		Send("{F20 Up}{Alt Up}{Shift Up}")
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