;Excel 個別バインド一式
#HotIf WinActive("ahk_class XLMAIN")

; LControl & * の定義があれば修飾キーを根こそぎ無効化して吸い込めるため、LControl & * で定義しきる。

LControl & 1:: LCMD() && CAPS() ? Send("!{h}{s}{f}") : mbind_1()		; フィルタ
LControl & 2:: LCMD() && CAPS() ? Send("!{h}{a}{t}") : mbind_2()		; 文字列 - 上揃え
LControl & 3:: LCMD() && CAPS() ? Send("!{h}{a}{m}") : mbind_3()		; 文字列 - 上下中央揃え
LControl & 4:: LCMD() && CAPS() ? Send("!{h}{a}{b}") : mbind_4()		; 文字列 - 下揃え
LControl & 5:: LCMD() && CAPS() ? Send("!{h}{b}{i}") : mbind_5()		; 罫線 - 色変更

LControl & q:: LCMD() && CAPS() ? Send("!{o}{c}{a}") : mbind_q()		; セル幅調整
LControl & w:: LCMD() && CAPS() ? Send("!{h}{a}{l}") : mbind_w()		; 文字列 - 左揃え
LControl & e:: LCMD() && CAPS() ? Send("!{h}{a}{c}") : mbind_e()		; 文字列 - 中央揃え
LControl & r:: LCMD() && CAPS() ? Send("!{h}{a}{r}") : mbind_r()		; 文字列 - 右揃え
LControl & t:: LCMD() && CAPS() ? Send("!{h}{f}{c}") : mbind_t()		; 文字色変更(任意)

LControl & a:: LCMD() && CAPS() ? Send("TBD")        : mbind_a()		; TBD
;LControl & s:: 														; ページ送り(左): 元バインドをそのまま利用
LControl & d:: LCMD() && CAPS() ? Send("!{h}{h}")    : mbind_d()		; セルの塗りつぶし
;LControl & f:: 														; ページ送り(右): 元バインドをそのまま利用
LControl & g:: LCMD() && CAPS() ? Send("!{h}{m}{c}") : mbind_g()		; セルの結合/結合解除

LControl & z:: LCMD() && CAPS() ? Send("TBD")        : mbind_z()		; TBD
LControl & x:: LCMD() && CAPS() ? Send("TBD")        : mbind_x()		; TBD
LControl & c:: LCMD() && CAPS() ? Send("TBD")        : mbind_c()		; TBD
LControl & v:: LCMD() && CAPS() ? Send("!{w}{f}{f}") : mbind_v()		; ウィンドウ枠の固定/解除
LControl & b:: LCMD() && CAPS() ? Send("!{h}{b}{y}") : mbind_b()		; 罫線 - スタイル変更

LControl & u:: LCMD() && CAPS() ? Send("!{h}{b}{a}") : mbind_u()		; 罫線 - 格子
LControl & h:: LCMD() && CAPS() ? Send("!{h}{b}{n}") : mbind_h()		; 罫線 - 枠なし
LControl & i:: LCMD() && CAPS() ? Send("!{h}{b}{p}") : mbind_i()		; 罫線 - 上罫線
LControl & j:: LCMD() && CAPS() ? Send("!{h}{b}{l}") : mbind_j()		; 罫線 - 左罫線
LControl & k:: LCMD() && CAPS() ? Send("!{h}{b}{o}") : mbind_k()		; 罫線 - 下罫線
LControl & l:: LCMD() && CAPS() ? Send("!{h}{b}{r}") : mbind_l()		; 罫線 - 右罫線
LControl & o:: LCMD() && CAPS() ? Send("!{h}{b}{s}") : mbind_o()		; 罫線 - 外枠

LControl & tab:: LCMD() && CAPS() ? Send("TBD")      : mbind_tab()		; TBD

; 挙動是正パッチ
Shift & Space::Send("+{Space}")

#HotIf