;Powerpoint 個別バインド一式
#HotIf WinActive("ahk_class PPTFrameClass")

; LControl & * の定義があれば修飾キーを根こそぎ無効化して吸い込めるため、LControl & * で定義しきる。

LControl & 1:: LCMD() && CAPS() ? Send("!{j}{p}{v}{c}") : mbind_1()		;トリミング
LControl & 2:: LCMD() && CAPS() ? Send("!{h}{a}{t}{t}") : mbind_2()		;上揃え
LControl & 3:: LCMD() && CAPS() ? Send("!{h}{a}{t}{m}") : mbind_3()		;中央揃え
LControl & 4:: LCMD() && CAPS() ? Send("!{h}{a}{t}{b}") : mbind_4()		;下揃え
LControl & 5:: LCMD() && CAPS() ? Send("!{h}{s}{o}")    : mbind_5()		;枠色変更

LControl & q:: LCMD() && CAPS() ? Send("!{h}{n}")       : mbind_q()		;箇条書き(ID)
*w:: ; 閉じるショートカットの無効化をするため、*wも利用
LControl & w:: {
	if LCMD() && CAPS()
		Send("!{h}{a}{l}")												;文字左揃え								
	else if LCMD()
		return ; 閉じるショートカットの無効化
	else mbind_w()
}
LControl & e:: LCMD() && CAPS() ? Send("!{h}{a}{c}")    : mbind_e()		;文字中央揃え
LControl & r:: LCMD() && CAPS() ? Send("!{h}{a}{r}")    : mbind_r()		;文字右揃え
LControl & t:: LCMD() && CAPS() ? Send("!{h}{f}{c}")    : mbind_t()		;文字色変更

LControl & a:: LCMD() && CAPS() ? Send("!{h}{u}")       : mbind_a()		;箇条書き
LControl & s:: LCMD() && CAPS() ? Send("!{n}{s}{h}")    : mbind_s()		;図形選択
LControl & d:: LCMD() && CAPS() ? Send("!{h}{s}{f}")    : mbind_d()		;図形の塗りつぶし
LControl & f:: LCMD() && CAPS() ? Send("!{h}{g}{a}")    : mbind_f()		;図形の位置揃え
LControl & g:: LCMD() && CAPS() ? Send("!{h}{o}{1}")    : mbind_g()		;図形の書式設定

LControl & z:: LCMD() && CAPS() ? Send("!{h}{g}{k}")    : mbind_z()		;最背面に移動
LControl & x:: LCMD() && CAPS() ? Send("!{h}{g}{r}")    : mbind_x()		;最前面に移動
LControl & c:: LCMD() && CAPS() ? Send("!{n}{t}")       : mbind_c()		;表
LControl & v:: LCMD() && CAPS() ? Send("!{n}{n}{s}")    : mbind_v()		;アイコン挿入
LControl & b:: LCMD() && CAPS() ? Send("!{h}{s}{o}")    : mbind_b()		;図形の枠線

LControl & tab:: LCMD() && CAPS() ? Send("!{w}{m}")     : mbind_tab()	;スライドマスタ

LShift & WheelUp::Send("^{]}")                							;文字サイズ変更
LShift & WheelDown::Send("^{[}")              							;文字サイズ変更

XButton1::Send("^{z}")                        							;戻る
XButton2::Send("^{y}")                        							;進む

Space & g::Send((SHIFT() ? "^+" : "^") "{g}"), mbind_space("Consume")	;グループ化

#HotIf
