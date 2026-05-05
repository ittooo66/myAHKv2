;Clipboard関連の追加機能

;コピー
ClipExt_copy(){
	;ClipboardにCopy
    A_Clipboard := ""  ; ClipWait用の初期化
	Send("^c")
    ClipWait(3)

	;clip.logにログ追記
	FileAppend(A_Clipboard . "`n`n-----`n`n", A_WorkingDir "\clip.log", "UTF-8-RAW")
}

;切り取り
ClipExt_cut(){
	;ClipboardにCut
    A_Clipboard := ""  ; ClipWait用の初期化
	Send("^x")
    ClipWait(3)

	;clip.logにログ追記
	FileAppend(A_Clipboard . "`n`n-----`n`n", A_WorkingDir "\clip.log", "UTF-8-RAW")
}

;Supabaseにコピー
ClipExt_SCopy() {
    A_Clipboard := ""
    Send("^c")
    if !ClipWait(3)
        return

    clipText := A_Clipboard
    if clipText = ""
        return

    ; UTF-8 → Base64
    buf := Buffer(StrPut(clipText, "UTF-8"))
    bytesWritten := StrPut(clipText, buf, "UTF-8")
    bytesLen := bytesWritten - 1

    DllCall("Crypt32\CryptBinaryToStringW"
        , "Ptr", buf
        , "UInt", bytesLen
        , "UInt", 0x40000001
        , "Ptr", 0
        , "UInt*", &outLen := 0)

    out := Buffer(outLen * 2)

    DllCall("Crypt32\CryptBinaryToStringW"
        , "Ptr", buf
        , "UInt", bytesLen
        , "UInt", 0x40000001
        , "Ptr", out
        , "UInt*", outLen)

    sclip := StrGet(out)

    ; JSON escape
    sclip := StrReplace(sclip, "\", "\\")
    sclip := StrReplace(sclip, '"', '\"')
    sclip := StrReplace(sclip, "`r", "\r")
    sclip := StrReplace(sclip, "`n", "\n")
    sclip := StrReplace(sclip, "`t", "\t")

    url := getEnv("ClipExt_SupabaseUrl") "/rest/v1/" getEnv("ClipExt_Table") "?on_conflict=slot"
    body := '[{"slot":"default","content_base64":"' sclip '"}]'

    http := ComObject("WinHttp.WinHttpRequest.5.1")
    http.Open("POST", url, false)
    http.SetRequestHeader("apikey", getEnv("ClipExt_ApiKey"))
    http.SetRequestHeader("Authorization", "Bearer " getEnv("ClipExt_ApiKey"))
    http.SetRequestHeader("Content-Type", "application/json")
    http.SetRequestHeader("Prefer", "resolution=merge-duplicates,return=representation")
    http.Send(body)

    if (http.Status < 200 || http.Status >= 300) {
        MsgBox("ClipExt_SCopy failed.`nStatus: " http.Status "`nResponse: " http.ResponseText)
        return
    }
}

;Supabaseからペースト
ClipExt_SPaste() {
    url := getEnv("ClipExt_SupabaseUrl") "/rest/v1/" getEnv("ClipExt_Table")
        . "?select=content_base64&slot=eq.default&limit=1"

    http := ComObject("WinHttp.WinHttpRequest.5.1")
    http.Open("GET", url, false)
    http.SetRequestHeader("apikey", getEnv("ClipExt_ApiKey"))
    http.SetRequestHeader("Authorization", "Bearer " getEnv("ClipExt_ApiKey"))
    http.Send()

    if (http.Status < 200 || http.Status >= 300) {
        MsgBox("ClipExt_SPaste failed.`nStatus: " http.Status "`nResponse: " http.ResponseText)
        return
    }

    res := http.ResponseText

    if !RegExMatch(res, '"content_base64"\s*:\s*"([^"]*)"', &m)
        return

    b64 := m[1]

    ; Base64 → UTF-8
    DllCall("Crypt32\CryptStringToBinaryW"
        , "Str", b64
        , "UInt", 0
        , "UInt", 0x1
        , "Ptr", 0
        , "UInt*", &bytesLen := 0
        , "Ptr", 0
        , "Ptr", 0)

    buf := Buffer(bytesLen)

    ok := DllCall("Crypt32\CryptStringToBinaryW"
        , "Str", b64
        , "UInt", 0
        , "UInt", 0x1
        , "Ptr", buf
        , "UInt*", bytesLen
        , "Ptr", 0
        , "Ptr", 0)

    if !ok
        return

    sclip := StrGet(buf, bytesLen, "UTF-8")

    if sclip = ""
        return

    directInput(sclip)
}

;拡張クリップボード(copy)
ClipExt_copyTo(num){
	;Spaceキーのスタックを消費
	mbind_space("Consume")

	;確認画面をつける
	if (MsgBox("ClipExt_copyto(" . num . ") Execute? " ,,4) != "Yes"){
		return
	}
	;cb_bkに中身を退避
	cb_bk := ClipboardAll()
	
	A_Clipboard := ""  ; ClipWait用の初期化
	Send("^c")
	ClipWait(3)

	;clip.logにログ追記
	FileAppend(A_Clipboard . "`n`n-----`n`n", A_WorkingDir "\clip.log", "UTF-8-RAW")
	;ファイルにClipboardを保存
	setEnv("CLIPEXT_" . num , A_Clipboard)
	;cb_bkから取得
	A_Clipboard := cb_bk
}

;拡張クリップボード(paste)
ClipExt_pasteFrom(num){
    ;一式SPACE()から呼ぶため、Spaceキースタック消費処理はこちらに実装
    mbind_space("Consume")

	;暴発防止のSleep
	Sleep(200)
	if SPACE(){
		content := getEnv("CLIPEXT_" . num )
		;content出力
		directInput(content)
	}
}

;ショートカット生成
ClipExt_addAlias(num){
    ;一式SPACE()から呼ぶため、Spaceキースタック消費処理はこちらに実装
    mbind_space("Consume")

	;Explorer画面以外で暴発しないように
	class := WinGetClass("A")
	if(class != "CabinetWClass"){
		return
	}
	;Clipboard退避
	cb_bk := ClipboardAll()

    A_Clipboard := ""  ; ClipWait用の初期化
	Send("^c")
	ClipWait(3)

	;filepathの書き出し
	param := "CLIPEXT_ALIAS_" . num
	setEnv(param,A_Clipboard)
	;Clipboard復帰
	A_Clipboard := cb_bk
}

;ショートカットを開く
ClipExt_openAlias(num){
    ;一式SPACE()から呼ぶため、Spaceキースタック消費処理はこちらに実装
    mbind_space("Consume")

	Run(getEnv("CLIPEXT_ALIAS_" . num))
}

;ClipBoard履歴の表示
ClipExt_openLog(){
	Run("notepad.exe " A_WorkingDir "\clip.log")
	Sleep(500)
	Send("^{End}")
}

;ClipLogのガベージ(AHKのReloadにひっかけて定期実行)
ClipLogGarbage() {
    logFile := A_WorkingDir "\clip.log"

    ; ファイルが存在しない場合は終了
    if !FileExist(logFile)
        return

    ; ファイル内容を読み込む
    content := FileRead(logFile, "UTF-8")

    ; 改行で分割
    lines := StrSplit(content, "`n")

    ; 残す行数（5000行）
    keepLines := 10000

    ; 行数が5000以下なら何もしない
    if lines.Length <= keepLines
        return

    ; 末尾の5000行を取得
    trimmed := ""
    Loop keepLines {
        trimmed .= lines[lines.Length - keepLines + A_Index] . "`n"
    }

    ; ファイルに上書き保存
    FileDelete(logFile)
    FileAppend(trimmed, logFile, "UTF-8")
}
