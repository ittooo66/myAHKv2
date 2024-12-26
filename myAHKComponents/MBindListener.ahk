;キーボード ベース定義

*a::
vkFF & a::
vkEB & a::
LControl & a::
RControl & a::
LShift & a::
RShift & a::{
	mbind_a()
}
*b::
vkFF & b::
vkEB & b::
LControl & b::
RControl & b::
LShift & b::
RShift & b::{
	mbind_b()
}
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
LShift & 9::{ ; Shift押しつつカッコ入力したとき、Shift UpのIME入力に反応してカッコの入力が確定してしまうので必要
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
*Tab::mbind_tab()
;Space機能向けの定義
*Space::mbind_space_down()
*Space Up::mbind_space_up()

;マウス ベース定義
*RButton::
XButton1 & RButton:: ;明示的に入力を定義しないとXButtonの消費判定が行われず、XButton Upのタイミングでmbind()が発動してしまうため記載
XButton2 & RButton:: ;明示的に入力を定義しないとXButtonの消費判定が行われず、XButton Upのタイミングでmbind()が発動してしまうため記載
{
	mbind_mrb()
}
*MButton::mbind_mmb()
*WheelUp::
WheelUp::{
	mbind_wheelup()
}
*WheelDown::
RButton & WheelDown::{
	mbind_wheeldown()
}

*XButton1::mbind_msblb()
*XButton2::mbind_msblf()
*F19::mbind_msbrf()
*F20::mbind_msbrb()

;LButton::ここだけはバインドしない。生命線。
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
