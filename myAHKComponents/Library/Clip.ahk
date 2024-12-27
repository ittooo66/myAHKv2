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

;拡張クリップボード(copy)
ClipExt_copyTo(num){
	;Spaceキーのスタックを消費
	mbind_space("Consume")
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
	FileAppend(ClipboardAll(), A_WorkingDir "\Env\CLIPEXT_" num ".dat")
	;cb_bkから取得
	A_Clipboard := cb_bk
}

;拡張クリップボード(paste)
ClipExt_pasteFrom(num){
	;Spaceキーのスタックを消費
	mbind_space("Consume")
	;暴発防止のSleep
	;Sleep(250)
	if SPACE(){
		try{
			;content取得
			content := FileRead(A_WorkingDir "\Env\CLIPEXT_" num ".dat", 'RAW')
		}catch{
			;登録コンテンツがなく、FileReadが決まらなかった時にcontentにテキストを埋め込む
			content := "No Registered Text"
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
