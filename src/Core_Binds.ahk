mbind_a(){
	if (SPACE() && CAPS())
		launch("A",SHIFT(),1)
	else if LSHIFT() && RSHIFT()
		ControlMouseFast("w","r","a","g")
	else if CAPS() && ALT()
		Send("{Volume_Down}")
	else if LCMD() && CAPS()
		Send("^{NumpadSub}") ;Chromeの画面縮小。Q側の拡大バインドと対応
	else if RCMD() || CAPS()
		press("^{LEFT}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("A")
	else if SPACE()
		ClipExt_pasteFrom("A")
	else
		press("a")
}

mbind_b(){
	if SPACE() && SHIFT()
		ClipExt_copyTo("B")
	else if SPACE()
		ClipExt_pasteFrom("B")
	else if RCMD() || CAPS()
		press("{PgDn}")
	else
		press("b")
}

mbind_c(){
	if (SPACE() && CAPS())
		launch("C",SHIFT())
	else if CAPS() && ALT()
		Send("#^{c}")
	else if RCMD() || CAPS()
		ClipExt_Tcopy()
	else if LCMD()
		ClipExt_copy()
	else if SPACE() && SHIFT()
		ClipExt_copyTo("C")
	else if SPACE()
		ClipExt_pasteFrom("C")
	else
		press("c")
}

mbind_d(){
	if (SPACE() && CAPS())
		launch("D",SHIFT())
	else if LSHIFT() && RSHIFT()
		ControlMouse("e","d","s","f")
	else if CAPS() && ALT(){
		;yt-dlp Support
		Send("^l")
		Sleep(250)
		A_Clipboard := ""
		Send("^c")
		Errorlevel := !ClipWait()
		FileAppend(A_Clipboard, getEnv("YTDLP_PATH") . FormatTime(, "yyyyMMddHHmmss") , "UTF-8-RAW")
		splash("yt-dlp Queued : " . A_Clipboard ,,800)
	}else if RCMD() || CAPS()
		press("{DOWN}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("D")
	else if SPACE()
		ClipExt_pasteFrom("D")
	else
		press("d")
}

mbind_e(){
	if (SPACE() && CAPS())
		launch("E",SHIFT(),1, "`"" . A_Desktop . "\memo\"  . FormatTime(, "yyyyMMdd") ".txt" . "`"" ) ; 引数に日付メモ.txtを指定して起動
	else if LSHIFT() && RSHIFT()
		ControlMouse("e","d","s","f")
	else if CAPS() || RCMD()
		press("{UP}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("E")
	else if SPACE()
		ClipExt_pasteFrom("E")
	else
		press("e")
}

mbind_f(){
	if (SPACE() && CAPS())
		launch("F",SHIFT())
	else if LCMD() && CAPS()
		Send("^{PgDn}")
	else if LSHIFT() && RSHIFT()
		ControlMouse("e","d","s","f")
	else if CAPS() || RCMD()
		press("{RIGHT}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("F")
	else if SPACE()
		ClipExt_pasteFrom("F")
	else
		press("f")
}

mbind_g(){
	if (SPACE() && CAPS())
		launch("G",SHIFT())
	else if LSHIFT() && RSHIFT()
		ControlMouseFast("w","r","a","g")
	else if RCMD() || CAPS()
		press("^{RIGHT}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("G")
	else if SPACE()
		ClipExt_pasteFrom("G")
	else
		press("g")
}

mbind_h(){
	if LSHIFT() && RSHIFT()
		moveWindow()
	else if RCMD() || CAPS()
		press("{BackSpace}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("H")
	else if SPACE()
		ClipExt_pasteFrom("H")
	else
		press("h")
}

mbind_i(){
	if LSHIFT() && RSHIFT()
		Send("{MButton}")
	else if RCMD() || (CAPS() && SHIFT())
		press("8")
	else if CAPS()
		press("{numpad8}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("I")
	else if SPACE()
		ClipExt_pasteFrom("I")
	else
		press("i")
}

mbind_j(){
	if LSHIFT() && RSHIFT()
		mousePress("j")
	else if RCMD() || (CAPS() && SHIFT())
		press("4")
	else if CAPS()
		press("{numpad4}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("J")
	else if SPACE()
		ClipExt_pasteFrom("J")
	else
		press("j")
}

mbind_k(){
	if LSHIFT() && RSHIFT()
		Send("{RButton}")
	else if RCMD() || (CAPS() && SHIFT())
		press("5")
	else if CAPS()
		press("{numpad5}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("K")
	else if SPACE()
		ClipExt_pasteFrom("K")
	else
		press("k")
}

mbind_l(){
	if LSHIFT() && RSHIFT()
		Send("{WheelLeft}")
	else if RCMD() || (CAPS() && SHIFT())
		press("6")
	else if CAPS() && LCMD()
		Send("^{l}")
	else if CAPS()
		press("{numpad6}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("L")
	else if SPACE()
		ClipExt_pasteFrom("L")
	else if LCMD(){
		;Win+L問題のため無効化。Lキーと組み合わせたとたんダメになる。
		;上で書いてる通り、CAPS付きで入力すること。
	}else
		press("l")
}

mbind_m(){
	if RCMD() || (CAPS() && SHIFT())
		press("1")
	else if CAPS()
		press("{numpad1}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("M")
	else if SPACE()
		ClipExt_pasteFrom("M")
	else
		press("m")
}

mbind_n(){
	if LSHIFT() && RSHIFT()
		changeWindowSize()
	else if RCMD() || (CAPS() && SHIFT())
		press("0")
	else if CAPS()
		press("{numpad0}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("N")
	else if SPACE()
		ClipExt_pasteFrom("N")
	else
		press("n")
}

mbind_o(){
	if RCMD() || (CAPS() && SHIFT())
		press("9")
	else if CAPS()
		press("{numpad9}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("O")
	else if SPACE()
		ClipExt_pasteFrom("O")
	else
		press("o")
}

mbind_p(){
	if RCMD() || CAPS()
		press("{PrintScreen}")
	else if LSHIFT() && RSHIFT()
		Send("{WheelUp}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("P")
	else if SPACE()
		ClipExt_pasteFrom("P")
	else
		press("p")
}

mbind_q(){
	if (SPACE() && CAPS())
		launch("Q",SHIFT())
	else if LSHIFT() && RSHIFT()
		mouseCursorResetToCenter()
	else if CAPS() && ALT()
		Send("{Volume_Up}")
	else if LCMD() && CAPS()
		Send("^{NumpadAdd}") ;Chromeの画面拡大。A側の拡大バインドと対応。Explorerの表示整理バインドでもある
	else if RCMD() || CAPS()
		Send("{BackSpace}")
	else if LCMD(){
		;セーフティ付きのAltF4

		;遅延時間の定義
		static CLOSE_TIME_DELAY := 400
		;変数初期化
		static windowCloseDownTime := A_TickCount - CLOSE_TIME_DELAY
		;前回押し下げが遅延時間(ms)以内に行われていた場合
		if (A_TickCount - windowCloseDownTime < CLOSE_TIME_DELAY){
			Send("!{F4}")
			;今回の押し下げ時間を記録(暴発防止で遅延時間も加算)
			windowCloseDownTime := A_TickCount - CLOSE_TIME_DELAY
		}else{
			;今回の押し下げ時間を記録
			windowCloseDownTime := A_TickCount
		}
	}else if SPACE() && SHIFT()
		ClipExt_copyTo("Q")
	else if SPACE()
		ClipExt_pasteFrom("Q")
	else
		press("q")
}

mbind_r(){
	if CAPS() && ALT(){
		;Explorerの再起動
		Run("taskkill /f /im explorer.exe", , "Hide")
		Sleep(1000)  ; 1秒待機（explorerが完全に終了するのを待つ）
		Run("explorer.exe")
	}else if SPACE() && CAPS()
		launch("R",SHIFT())
	else if LSHIFT() && RSHIFT()
		ControlMouseFast("w","r","a","g")
	else if RCMD() || CAPS()
		press("{END}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("R")
	else if SPACE()
		ClipExt_pasteFrom("R")
	else
		press("r")
}

mbind_s(){
	if SPACE() && CAPS()
		launch("S",SHIFT())
	else if LCMD() && CAPS()
		Send("^{PgUp}")
	else if LSHIFT() && RSHIFT()
		ControlMouse("e","d","s","f")
	else if CAPS() && ALT(){
		if ( getEnv("PC_NAME") == "X" ){
			Send("^!{s}")
		}else{
			Send("#+{s}")
		}
	}else if RCMD() || CAPS()
		press("{LEFT}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("S")
	else if SPACE()
		ClipExt_pasteFrom("S")
	else
		press("s")
}

mbind_t(){
	if SPACE() && CAPS()
		launch("T",SHIFT())
	else if RCMD() || CAPS()
		press("{Enter}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("T")
	else if SPACE()
		ClipExt_pasteFrom("T")
	else
		press("t")
}

mbind_u(){
	if RCMD() || (CAPS() && SHIFT())
		press("7")
	else if CAPS()
		press("{numpad7}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("U")
	else if SPACE()
		ClipExt_pasteFrom("U")
	else
		press("u")
}

mbind_v(){
	if (SPACE() && CAPS() && SHIFT())
		Run("`"C:\Program Files\TrueCrypt\TrueCrypt.exe`" /q /dr")
	else if (SPACE() && CAPS())
		Run("`"C:\Program Files\TrueCrypt\TrueCrypt.exe`" /q /v \Device\Harddisk1\Partition0 /lr")
	else if RCMD() || CAPS()
		ClipExt_Tpaste()
	else if SPACE() && SHIFT()
		ClipExt_copyTo("V")
	else if SPACE()
		ClipExt_pasteFrom("V")
	else if LCMD() && LALT()
		directInput(A_Clipboard) ;テキスト形式の貼り付け
	else
		press("v")
}

mbind_w(){
	if (SPACE() && CAPS())
		launch("W",SHIFT())
	else if LSHIFT() && RSHIFT()
		ControlMouseFast("w","r","a","g")
	else if RCMD() || CAPS()
		press("{HOME}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("W")
	else if SPACE()
		ClipExt_pasteFrom("W")
	else
		press("w")
}

mbind_x(){
	if SPACE() && CAPS()
		launch("X",SHIFT())
	else if ( CAPS() || RCMD() )&& SHIFT()
		launch("E",SHIFT(),1," `"" . A_WorkingDir "\src\Util_Macros.ahk`"")
	else if RCMD() || CAPS()
		MacroX()
	else if LCMD()
		ClipExt_cut()
	else if SPACE() && SHIFT()
		ClipExt_copyTo("X")
	else if SPACE()
		ClipExt_pasteFrom("X")
	else
		press("x")
}

mbind_y(){
	if SPACE() && SHIFT()
		ClipExt_copyTo("Y")
	else if SPACE()
		ClipExt_pasteFrom("Y")
	else if RCMD() || CAPS()
		press("{PgUp}")
	else
		press("y")
}

mbind_z(){
	if SPACE() && CAPS()
		launch("Z",SHIFT())
	else if ( CAPS() || RCMD() )&& SHIFT()
		launch("E",SHIFT(),1," `"" . A_WorkingDir "\src\Util_Macros.ahk`"")
	else if RCMD() || CAPS()
		MacroZ()
	else if SPACE() && SHIFT()
		ClipExt_copyTo("Z")
	else if SPACE()
		ClipExt_pasteFrom("Z")
	else if SHIFT() && LCMD()
		Send("^{y}") ;Shift押しで「進む」
	else
		press("z")
}

mbind_1(){
	if SPACE() && CAPS() && SHIFT()
		ClipExt_addAlias("1")
	else if SPACE() && CAPS()
		ClipExt_openAlias("1")
	else if RCMD() || CAPS(){
		;F1無効化
	}else if SPACE() && SHIFT()
		ClipExt_copyTo("1")
	else if SPACE()
		ClipExt_pasteFrom("1")
	else
		press("1")
}

mbind_2(){
	if SPACE() && CAPS() && SHIFT()
		ClipExt_addAlias("2")
	else if SPACE() && CAPS()
		ClipExt_openAlias("2")
	else if RCMD() || CAPS()
		press("{F2}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("2")
	else if SPACE()
		ClipExt_pasteFrom("2")
	else
		press("2")
}

mbind_3(){
	if SPACE() && CAPS() && SHIFT()
		ClipExt_addAlias("3")
	else if SPACE() && CAPS()
		ClipExt_openAlias("3")
	else if RCMD() || CAPS()
		press("{F3}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("3")
	else if SPACE()
		ClipExt_pasteFrom("3")
	else
		press("3")
}

mbind_4(){
	if SPACE() && CAPS() && SHIFT()
		ClipExt_addAlias("4")
	else if SPACE() && CAPS()
		ClipExt_openAlias("4")
	else if RCMD() || CAPS()
		press("{F4}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("4")
	else if SPACE()
		ClipExt_pasteFrom("4")
	else
		press("4")
}

mbind_5(){
	if SPACE() && CAPS() && SHIFT()
		ClipExt_addAlias("5")
	else if SPACE() && CAPS()
		ClipExt_openAlias("5")
	else if RCMD() || CAPS()
		press("{F5}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("5")
	else if SPACE()
		ClipExt_pasteFrom("5")
	else
		press("5")
}

mbind_6(){
	if RCMD() || CAPS()
		press("{F6}")
	else if SPACE() && CAPS() && SHIFT()
		ClipExt_addAlias("6")
	else if SPACE() && CAPS()
		ClipExt_openAlias("6")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("6")
	else if SPACE()
		ClipExt_pasteFrom("6")
	else
		press("6")
}

mbind_7(){
	if RCMD() || CAPS()
		press("{F7}")
	else if SPACE() && CAPS() && SHIFT()
		ClipExt_addAlias("7")
	else if SPACE() && CAPS()
		ClipExt_openAlias("7")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("7")
	else if SPACE()
		ClipExt_pasteFrom("7")
	else
		press("7")
}

mbind_8(){
	if RCMD() || CAPS()
		press("{F8}")
	else if SPACE() && CAPS() && SHIFT()
		ClipExt_addAlias("8")
	else if SPACE() && CAPS()
		ClipExt_openAlias("8")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("8")
	else if SPACE()
		ClipExt_pasteFrom("8")
	else
		press("8")
}

mbind_9(){
	if SPACE() && CAPS() && SHIFT()
		ClipExt_addAlias("9")
	else if SPACE() && CAPS()
		ClipExt_openAlias("9")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("9")
	else if SPACE()
		ClipExt_pasteFrom("9")
	else if SHIFT()
		Send("{(}{)}{Left}")
	else if RCMD() || CAPS()
		press("{F9}")
	else
		press("9")
}

mbind_0(){
	if SPACE() && CAPS() && SHIFT()
		ClipExt_addAlias("0")
	else if SPACE() && CAPS()
		ClipExt_openAlias("0")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("0")
	else if SPACE()
		ClipExt_pasteFrom("0")
	else if RCMD() || CAPS()
		press("{F10}")
	else
		press("0")
}

mbind_minus(){
	if RCMD() || CAPS()
		press("{F11}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("Minus")
	else if SPACE()
		ClipExt_pasteFrom("Minus")
	else
		press("-")
}

mbind_equal(){
	if RCMD() || CAPS()
		press("{F12}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("Equal")
	else if SPACE()
		ClipExt_pasteFrom("Equal")
	else
		press("=")
}

mbind_bracket_left(){
	if ( CAPS() || RCMD() )&& SHIFT()
		launch("E",SHIFT(),1," `"" . A_WorkingDir "\src\Util_Macros.ahk`"")
	else if RCMD() || CAPS()
		MacroBRL()
	else if SPACE() && SHIFT()
		ClipExt_copyTo("LBracket")
	else if SPACE()
		ClipExt_pasteFrom("LBracket")
	else{
		press("[")
		press("]")
		Send("{Left}")
	}
}

mbind_bracket_right(){
	if ( CAPS() || RCMD() )&& SHIFT()
		launch("E",SHIFT(),1," `"" . A_WorkingDir "\src\Util_Macros.ahk`"")
	else if RCMD() || CAPS()
		MacroBRR()
	else if SPACE() && SHIFT()
		ClipExt_copyTo("RBracket")
	else if SPACE()
		ClipExt_pasteFrom("RBracket")
	else
		press("]")
}

mbind_backslash(){
	if RCMD() || CAPS()
		ClipExt_openLog()
	else if SPACE() && SHIFT()
		ClipExt_copyTo("Backslash")
	else if SPACE()
		ClipExt_pasteFrom("Backslash")
	else
		press("\")
}

mbind_semicolon(){
	if ( CAPS() || RCMD() )&& SHIFT()
		launch("E",SHIFT(),1," `"" . A_WorkingDir "\src\Util_Macros.ahk`"")
	else if RCMD() || CAPS()
		MacroSMC()
	else if LSHIFT() && RSHIFT()
		Send("{WheelDown}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("Semicolon")
	else if SPACE()
		ClipExt_pasteFrom("Semicolon")
	else if LCMD() && SHIFT()
		directInput(FormatTime(, "HH") . ":" . FormatTime(, "mm"))
	else if LCMD()
		directInput(FormatTime(, "yyyy") . "/" . FormatTime(, "MM") . "/" . FormatTime(, "dd"))
	else if SHIFT()
		Send("{:}")
	else
		press("`;")
}

mbind_quote(){
	if RCMD() || CAPS()
		press("{*}")
	else if LSHIFT() && RSHIFT()
		Send("{WheelRight}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("Quote")
	else if SPACE()
		ClipExt_pasteFrom("Quote")
	else
		press("'")
}

mbind_period(){
	if RCMD() || (CAPS() && SHIFT())
		press("3")
	else if CAPS()
		press("{numpad3}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("Period")
	else if SPACE()
		ClipExt_pasteFrom("Period")
	else
		press(".")
}

mbind_camma(){
	if RCMD() || (CAPS() && SHIFT())
		press("2")
	else if CAPS()
		press("{numpad2}")
	else if SPACE() && SHIFT()
		ClipExt_copyTo("Camma")
	else if SPACE()
		ClipExt_pasteFrom("Camma")
	else
		press(",")
}

mbind_slash(){
	if ( CAPS() || RCMD() )&& SHIFT()
		launch("E",SHIFT(),1," `"" . A_WorkingDir "\src\Util_Macros.ahk`"")
	else if RCMD() || CAPS()
		MacroSLS()
	else if SPACE() && SHIFT()
		ClipExt_copyTo("Slash")
	else if SPACE()
		ClipExt_pasteFrom("Slash")
	else
		press("/")
}

mbind_backspace(){
	if RCMD() || CAPS(){
		;一行消し
		Send("+{Home}")
		ClipExt_copy()
		Send("{BackSpace}")
	}else if SPACE() && SHIFT()
		ClipExt_copyTo("Backspace")
	else if SPACE()
		ClipExt_pasteFrom("Backspace")
	else
		press("{BackSpace}")
}

mbind_enter(){
	if (SPACE() && CAPS()) 
		launch("Enter",SHIFT())
	else if SPACE() && SHIFT()
		ClipExt_copyTo("Enter")
	else if SPACE()
		ClipExt_pasteFrom("Enter")
	else if CAPS() || RCMD()
		Send("^{Enter}")
	else
		press("{Enter}")
}

mbind_delete(){
	if RCMD(){
		;一行消し
		Send("+{End}")
		ClipExt_copy()
		Send("{BackSpace}")
	}else if SPACE() && SHIFT()
		ClipExt_copyTo("Delete")
	else if SPACE()
		ClipExt_pasteFrom("Delete")
	else
		press("{Delete}")
}

mbind_escape(){
	resetMods() ;押しっぱなし解消キー

	if CAPS() || RCMD()
		Send("{Delete}")
	else
		press("{Esc}")	
}

mbind_tab(){
	if CAPS() || RCMD()
		Send("^{Tab}")
	else if LCMD()
		Send("#{Tab}")
	else
		press("{Tab}")
}

mbind_mlb(){
	if MRB()
		changeWindowSize()
	else if MMB()
		Send("#{Tab}")
	else if MSBRB()
		philipsHue(1,getEnv("HUE_BRI"),getEnv("HUE_CT"))
	else if MSBLF()
		intelliScroll()
	else if MSBLB(){
		if !activateWindow("CabinetWClass","explorer.exe","")
			Send("#{e}")
	}else if MSBRF()
		Send("^+{k}") ; 要EarTrunpetショートカット設定
	else
		Send("{LButton}")
}

mbind_mrb(){
	if MMB()
		Send("^{n}")
	else if MSBRB()
		philipsHue(0)
	else if MSBRF(){
		ToolTip "Measuring CO2 concentration..."
		execScripts("read_co2.py",,,1)
		ToolTip 
		splash("CO2 Concentration : " . getEnv("CO2") . "ppm",1500,400)
	}else if MSBLB(){
		Send("{RWin Down}")
		while(GetKeyState("RButton","P")){
			Sleep(30)
		}
		Send("{RWin Up}")
	}else if MSBLF()
		AHK_Dashboard()
	else
		Send("{RButton}")
}

mbind_mmb(){
	if MRB()
		Send("^{t}")
	else if MSBRB()
		philipsHueControlCT()
	else
		moveWindow()
}

mbind_msblb(){
	if MRB(){
		Send("^{w}")
		Sleep(250)
	}else if MMB()
		WinMinimize("A")
	else if MSBLF()
		changeWindowSize()
	else if MSBRF(){
		; MuteTimer
		IB := InputBox("Mute After N minute", "Delayed Mute", "w200 h130", 60), muteMinute := IB.Value, ErrorLevel := IB.Result="OK" ? 0 : IB.Result="CANCEL" ? 1 : IB.Result="Timeout" ? 2 : "ERROR"
			if (ErrorLevel != 0)
				return
			else {
				if isInteger(muteMinute)
				{
					MsgBox("Mute After " muteMinute " Minute")
					Loop muteMinute
					{
						Sleep(60000)
					}
					Loop 50
					{
						Send("{Volume_Down}")
					}
				}else
					MsgBox("Invalid Input Number")
			}
	}else if MSBRB()
		Send("+{.}")
	else
		Send("{XButton1}")
}

mbind_msblf(){
	if MRB()
		Send("^+{t}")
	else if MSBRB()
		Send("+{,}")
	else if MSBRF()
		execScripts("SetAudioDevice.ps1")
	else if MSBLB()
		changeWindowSize()
	else if MSBLF(){
		;最小化されているウィンドウをすべてアクティブにする
		; 配列idsに現在稼働中のWindowを突っ込む
		ids := WinGetList(,,"Program Manager")

		; 最下層から順番に検索
		for i, this_id in ids {
			WinActivate("ahk_id " this_id)
		}
	}else
		Send("{XButton2}")
}

mbind_msbrb(){
	resetMods()
}

mbind_msbrf(){
	resetMods()
}

mbind_wheelup(){
	if MRB()
		Send("^{PgUp}")
	else if MSBLF()
		Send("{WheelLeft}")
	else if MSBRF()
		Send("#^{Volume_Up}")
	else if MSBRB() {
		philipsHueControlBRI("Up")
	}else if MMB()
		Send("#^{Left}")
	else
		Send("{WheelUp}")
}

mbind_wheeldown(){
	if MRB()
		Send("^{PgDn}")
	else if MSBLF()
		Send("{WheelRight}")
	else if MSBRF()
		Send("#^{Volume_Down}")
	else if MSBRB() {
		philipsHueControlBRI("Down")
	}else if MMB()
		Send("#^{Right}")
	else
		Send("{WheelDown}")
}

;command : "Up"|"Down"|"Consume" 
mbind_space(command){

	;Spaceの仮想押下時間
	static A_SpaceDownTime := 0

	if command = "Up"{
		;Spaceの仮想押下を解除済みならば、何もせず終了
		if (A_SpaceDownTime = 0)
			return

		;各種Spaceバインド
		;　一定時間経過後のスペースキーを修飾キー(入力なし)として扱う
		if CAPS() || RCMD()
			press("^{Space}")
		else if(A_TickCount - A_SpaceDownTime < 400){
			press("{Space}")
		}
		
		;Spaceの仮想押下解除
		A_SpaceDownTime := 0
		
	}else if command = "Down"{
		;Spaceの仮想押下時間を記録する
		if (A_SpaceDownTime = 0)
			A_SpaceDownTime := A_TickCount

		;IME切り替え（即時発動）
		if LCMD() || RCMD(){
			Send("!{``}")
			mbind_space("Consume")
 		}
	}else if command = "Consume"{
		;Spaceの仮想押下を解除する
		A_SpaceDownTime := 0
	}else{
		MsgBox("mbind_space() Invalid Command : " . command)
	}
}


