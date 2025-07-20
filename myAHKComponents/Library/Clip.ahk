;Clipboard関連の追加機能

;コピー
ClipExt_copy(){
	;ClipboardにCopy
	Send("^c")
	;0.5secクリップボードの中身が入ってくるまで待つ。第二引数はClipboardAllタイプの変数を待つ、の証(1)
	Errorlevel := !ClipWait(0.5, 1)
	;ログ追記
	logger(A_Clipboard , "clip")
}

;切り取り
ClipExt_cut(){
	;ClipboardにCut
	Send("^x")
	;0.5secクリップボードの中身が入ってくるまで待つ。第二引数はClipboardAllタイプの変数を待つ、の証(1)
	Errorlevel := !ClipWait(0.5, 1)
	;ログ追記
	logger(A_Clipboard , "clip")
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

; クリップボードのテキストを暗号化し、Base64文字列に置き換える
ClipExt_Ecopy() {
    A_Clipboard := ""  ; クリップボード初期化
    Send("^c")
    if !ClipWait(1) {
        MsgBox("クリップボードの取得に失敗しました。")
        return
    }

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
}

; クリップボード内のBase64文字列を復号・貼り付け
ClipExt_Epaste() {
    Sleep(200)
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
	;一旦clipboardを空にする
	A_Clipboard := ""
	;clipboardにCopy
	Send("^c")
	;0.5secクリップボードの中身が入ってくるまで待つ。第二引数はClipboardAllタイプの変数を待つ、の証(1)
	Errorlevel := !ClipWait(0.5, 1)
	;ログ追記
	logger(A_Clipboard , "clip")
	;ファイルにClipboardを保存
	try {
		FileDelete(A_WorkingDir "\Env\CLIPEXT_" num ".dat")
	}
	FileAppend(ClipboardAll(), A_WorkingDir "\Env\CLIPEXT_" num ".dat")
	;cb_bkから取得
	A_Clipboard := cb_bk
}

;拡張クリップボード(paste)
ClipExt_pasteFrom(num){
	;Spaceキーのスタックを消費
	mbind_space("Consume")
	;暴発防止のSleep
	Sleep(200)
	if SPACE(){
		try{
			;content取得
			content := FileRead(A_WorkingDir "\Env\CLIPEXT_" num ".dat", 'RAW')
		}catch{
			;登録コンテンツがなく、FileReadが決まらなかった時にcontentにテキストを埋め込む
			content := ""
		}
		;content出力
		directInput(content)
	}
}

;ショートカット生成
ClipExt_addAlias(num){
	;Explorer画面以外で暴発しないように
	class := WinGetClass("A")
	if(class != "CabinetWClass"){
		return
	}
	;Clipboard退避
	cb_bk := ClipboardAll()
	;clipboardにコピー
	A_Clipboard := ""
	Send("^c")
	Errorlevel := !ClipWait(1)
	;filepathの書き出し
	param := "CLIPEXT_ALIAS_" . num
	setEnv(param,A_Clipboard)
	;Clipboard復帰
	A_Clipboard := cb_bk
}

;ショートカットを開く
ClipExt_openAlias(num){
	param := "CLIPEXT_ALIAS_" . num 
	filepath := getEnv(param)
	Run(filepath)
}

;ClipBoard履歴の表示
ClipExt_openLog(){
	Run("notepad.exe " A_WorkingDir "\clip.log")
	Sleep(500)
	Send("^{End}")
}
