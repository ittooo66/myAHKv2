;変更対象キー定義一覧
Delete::`
RAlt::RWin

;IME向けキー定義
LShift Up::IME_EN()
RShift Up::IME_JP()

;無効キー定義一覧
sc03a::return ; Capslock
vkFF::return ; 変換/無変換(JPキーボード向け)
vkEB::return ; 変換/無変換(JPキーボード向け)
RWin::return ; R-Windows
RWin Up::return ; R-Windows
LWin::return ; L-Windows
LWin Up::return ; R-Windows

;キーのフック定義一覧
; ・明示的にフックの組み合わせを定義して全入力を刈り取る。*a,*bなどの定義だけだと、
;   各キー入力時の修飾キー側のupに反応して意図しないキー入力が行われる。
; 　 ⇒ 例：Shift+9を押下したとき、*9::mbind_9()でカッコ入力 ⇒ Shift Up::IME_EN()でIME無効
;          それぞれ行われた結果、カッコ入力後にIME無効が押され、入力が意図せず確定する
; ・RWin,LWinはフック定義に一切記載せず、これらのキー入力の状態はLCMD(),RCMD()で取得すること。
;   WinキーはUp時にキー入力が発動する仕様のため、RWin & ...で記載しきってもあらゆる形で漏れ出す。

*a::mbind_a()
*b::mbind_b()
*c::mbind_c()
*d::mbind_d()
*e::mbind_e()
*f::mbind_f()
*g::mbind_g()
*h::mbind_h()
*i::mbind_i()
*j::mbind_j()
*k::mbind_k()
*l::mbind_l()
*m::mbind_m()
*n::mbind_n()
*o::mbind_o()
*p::mbind_p()
*q::mbind_q()
*r::mbind_r()
*s::mbind_s()
*t::mbind_t()
*u::mbind_u()
*v::mbind_v()
*w::mbind_w()
*x::mbind_x()
*y::mbind_y()
*z::mbind_z()
*1::mbind_1()
*2::mbind_2()
*3::mbind_3()
*4::mbind_4()
*5::mbind_5()
*6::mbind_6()
*7::mbind_7()
*8::mbind_8()
*9::
LShift & 9::{
	mbind_9()
}
*0::mbind_0()
*-::mbind_minus()
*=::mbind_equal()
*\::mbind_backslash()
*;::mbind_semicolon()
*'::mbind_quote()
*.::mbind_period()
*,::mbind_camma()
*/::mbind_slash()
*[::mbind_bracket_left()
*]::mbind_bracket_right()
*BackSpace::mbind_backspace()
*Enter::mbind_enter()
*`::mbind_delete()
*Esc::mbind_escape()

Alt & Tab::AltTab
*Tab::mbind_tab()

;Space機能向けの定義
*Space::mbind_space("Down")
*Space Up::mbind_space("Up")

;マウス ベース定義
RButton::
MButton & RButton::
XButton1 & RButton::
XButton2 & RButton::
F19 & RButton::
F20 & RButton::
^!RButton::
!+RButton::{
	mbind_mrb()
}

MButton::
RButton & MButton::
XButton1 & MButton::
XButton2 & MButton::
F19 & MButton::
F20 & MButton::
^!MButton::
!+MButton::{
	mbind_mmb()
}

;LButton::ここだけはバインドしない。
RButton & LButton::
MButton & LButton::
XButton1 & LButton::
XButton2 & LButton::
F19 & LButton::
F20 & LButton::
!+LButton::
^!LButton::
{
	mbind_mlb()
}

XButton1 & WheelUp::ShiftAltTab
WheelUp::
MButton & WheelUp::
RButton & WheelUp::
XButton2 & WheelUp::
F20 & WheelUp::
F19 & WheelUp::
^!WheelUp::
!+WheelUp::{
	mbind_wheelup()
}

XButton1 & WheelDown::AltTab
WheelDown::
MButton & WheelDown::
RButton & WheelDown::
XButton2 & WheelDown::
F20 & WheelDown::
F19 & WheelDown::
^!WheelDown::
!+WheelDown::{
	mbind_wheeldown()
}

XButton1::
RButton & XButton1::
MButton & XButton1::
XButton2 & XButton1::
F19 & XButton1::
F20 & XButton1::
^!XButton1::
!+XButton1::{
	mbind_msblb()
}

XButton2::
RButton & XButton2::
MButton & XButton2::
XButton1 & XButton2::
F19 & XButton2::
F20 & XButton2::
^!XButton2::
!+XButton2::{
	mbind_msblf()
}

F19::
RButton & F19::
MButton & F19::
XButton1 & F19::
XButton2 & F19::
F20 & F19::{
	mbind_msbrf()
}

F20::
RButton & F20::
MButton & F20::
XButton1 & F20::
XButton2 & F20::
F19 & F20::{
	mbind_msbrb()
}

;キーパッド ベース定義
Numpad1::mbind_key1()
NumpadEnd::mbind_key1()
Numpad2::mbind_key2()
NumpadDown::mbind_key2()
Numpad3::mbind_key3()
NumpadPgdn::mbind_key3()
Numpad4::mbind_key4()
NumpadLeft::mbind_key4()
Numpad5::mbind_key5()
NumpadClear::mbind_key5()
Numpad6::mbind_key6()
NumpadRight::mbind_key6()
Numpad7::mbind_key7()
NumpadHome::mbind_key7()
Numpad8::mbind_key8()
NumpadUp::mbind_key8()
Numpad9::mbind_key9()
NumpadPgup::mbind_key9()
