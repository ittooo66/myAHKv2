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

; XOR暗号化・復号（共通）
xorCrypt(buf) {
	key := getEnv("key")
    keyLen := StrLen(key)
    out := Buffer(buf.Size)
    Loop buf.Size {
        offset := A_Index - 1
        byte := NumGet(buf, offset, "UChar")
        keyByte := Ord(SubStr(key, Mod(offset, keyLen) + 1, 1))
        NumPut("UChar", byte ^ keyByte, out, offset)
    }
    return out
}

; クリップボードのテキストを暗号化し、Base64文字列に置き換えてTrelloに送信
ClipExt_Tcopy() {

	A_Clipboard := ""  ; ClipWait用の初期化
    Send("^c")
    ClipWait(3)

    clipText := A_Clipboard
    if clipText = ""
        return

    ; UTF-8 文字列をバッファに格納
    textSize := StrPut(clipText, "UTF-8")
    buf := Buffer(textSize - 1, 0)
    StrPut(clipText, buf, "UTF-8")

    ; 暗号化
    encrypted := xorCrypt(buf)

    ; Base64 エンコード (CryptBinaryToStringW)
    DllCall("Crypt32\CryptBinaryToStringW", "Ptr", encrypted, "UInt", encrypted.Size
        , "UInt", 0x40000001, "Ptr", 0, "UInt*", &outSize := 0)
    outBuf := Buffer(outSize * 2, 0)
    success := DllCall("Crypt32\CryptBinaryToStringW", "Ptr", encrypted, "UInt", encrypted.Size
        , "UInt", 0x40000001, "Ptr", outBuf, "UInt*", &outSize)
    if !success {
        MsgBox("Base64エンコードに失敗しました。")
        return
    }

    base64 := StrGet(outBuf, outSize, "UTF-16")
    A_Clipboard := base64

	CardID := getEnv("TRELLO_CARD_ID") 
	TrelloKey := getEnv("TRELLO_API_KEY")
	TrelloToken := getEnv("TRELLO_API_TOKEN")
	descText := A_Clipboard

	; Trello API の URL（descの更新）
	url := Format("https://api.trello.com/1/cards/{}/desc?key={}&token={}", CardID, TrelloKey, TrelloToken)

	; HTTPリクエスト送信（POST）
	http := ComObject("WinHttp.WinHttpRequest.5.1")
	http.Open("PUT", url, false)
	http.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
	http.Send("value=" . UriEncode(descText))

	; レスポンスの確認
	if (http.Status == 200) {
		splash "TrelloClipの送信処理が正常終了しました。"
	} else {
		MsgBox Format("エラーが発生しました。Status: {}`nResponse: {}", http.Status, http.ResponseText)
	}

}

; URIエンコード関数（必要）
UriEncode(str) {
    static enc := "%"
    size := StrPut(str, "UTF-8")
    buf := Buffer(size)
    StrPut(str, buf.Ptr, size, "UTF-8")

    out := ""
    Loop size - 1 {
        code := NumGet(buf.Ptr + A_Index - 1, "UChar")
        if (code >= 0x30 && code <= 0x39  ; 0-9
         || code >= 0x41 && code <= 0x5A  ; A-Z
         || code >= 0x61 && code <= 0x7A  ; a-z
         || code = 0x2D || code = 0x2E || code = 0x5F || code = 0x7E)  ; - . _ ~
            out .= Chr(code)
        else
            out .= enc . Format("{:02X}", code)
    }
    return out
}

; クリップボード内のBase64文字列を復号・貼り付け
ClipExt_Tpaste() {
	CardID := getEnv("TRELLO_CARD_ID") 
	TrelloKey := getEnv("TRELLO_API_KEY")
	TrelloToken := getEnv("TRELLO_API_TOKEN")
    url := Format("https://api.trello.com/1/cards/{}/desc?key={}&token={}", CardID, TrelloKey, TrelloToken)

    try {
        http := ComObject("WinHttp.WinHttpRequest.5.1")
        http.Open("GET", url, false)
        http.Send()

        if (http.Status == 200) {
            ; レスポンスはJSON（例: {"desc":"説明文"})
            desc := JSONExtract(http.ResponseText, "_value")
            A_Clipboard := desc
            ClipWait(3)
        } else {
            MsgBox Format("エラー: Status {} - {}", http.Status, http.ResponseText)
        }
    } catch {
        MsgBox "通信エラー" 
    }

    try {
        base64 := A_Clipboard
        if !base64
            throw Error("Clipboard is empty")

        ; Base64デコード (CryptStringToBinaryW)
        DllCall("Crypt32\CryptStringToBinaryW", "Str", base64, "UInt", 0
            , "UInt", 0x1, "Ptr", 0, "UInt*", &outSize := 0, "Ptr", 0, "Ptr", 0)
        bin := Buffer(outSize, 0)
        success := DllCall("Crypt32\CryptStringToBinaryW", "Str", base64, "UInt", 0
            , "UInt", 0x1, "Ptr", bin, "UInt*", &outSize, "Ptr", 0, "Ptr", 0)
        if !success
            throw Error("Base64デコードに失敗しました。")

        ; 復号
        decryptedBuf := xorCrypt(bin)
        decrypted := StrGet(decryptedBuf, decryptedBuf.Size, "UTF-8")
    } catch {
        MsgBox("復号に失敗しました。")
        return
    }

    directInput(decrypted) 
}

JSONExtract(json, key) {
    ; 例: {"desc":"Hello world"} から "Hello world" を取り出す
    pattern := '"' key '":"((?:\\.|[^"\\])*)"'  ; エスケープ文字も考慮
    if RegExMatch(json, pattern, &m)
        return StrReplace(m[1], '\"', '"')  ; \" を " に戻す
    return ""
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
