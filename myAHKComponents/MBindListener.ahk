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
*c::
vkFF & c::
vkEB & c::
LControl & c::
RControl & c::
LShift & c::
RShift & c::{
	mbind_c()
}
*d::
vkFF & d::
vkEB & d::
LControl & d::
RControl & d::
LShift & d::
RShift & d::{
	mbind_d()
}
*e::
vkFF & e::
vkEB & e::
LControl & e::
RControl & e::
LShift & e::
RShift & e::{
	mbind_e()
}
*f::
vkFF & f::
vkEB & f::
LControl & f::
RControl & f::
LShift & f::
RShift & f::{
	mbind_f()
}
*g::
vkFF & g::
vkEB & g::
LControl & g::
RControl & g::
LShift & g::
RShift & g::{
	mbind_g()
}
*h::
vkFF & h::
vkEB & h::
LControl & h::
RControl & h::
LShift & h::
RShift & h::{
	mbind_h()
}
*i::
vkFF & i::
vkEB & i::
LControl & i::
RControl & i::
LShift & i::
RShift & i::{
	mbind_i()
}
*j::
vkFF & j::
vkEB & j::
LControl & j::
RControl & j::
LShift & j::
RShift & j::{
	mbind_j()
}
*k::
vkFF & k::
vkEB & k::
LControl & k::
RControl & k::
LShift & k::
RShift & k::{
	mbind_k()
}
*l::
vkFF & l::
vkEB & l::
LControl & l::
RControl & l::
LShift & l::
RShift & l::{
	mbind_l()
}
*m::
vkFF & m::
vkEB & m::
LControl & m::
RControl & m::
LShift & m::
RShift & m::{
	mbind_m()
}
*n::
vkFF & n::
vkEB & n::
LControl & n::
RControl & n::
LShift & n::
RShift & n::{
	mbind_n()
}
*o::
vkFF & o::
vkEB & o::
LControl & o::
RControl & o::
LShift & o::
RShift & o::{
	mbind_o()
}
*p::
vkFF & p::
vkEB & p::
LControl & p::
RControl & p::
LShift & p::
RShift & p::{
	mbind_p()
}
*q::
vkFF & q::
vkEB & q::
LControl & q::
RControl & q::
LShift & q::
RShift & q::{
	mbind_q()
}
*r::
vkFF & r::
vkEB & r::
LControl & r::
RControl & r::
LShift & r::
RShift & r::{
	mbind_r()
}
*s::
vkFF & s::
vkEB & s::
LControl & s::
RControl & s::
LShift & s::
RShift & s::{
	mbind_s()
}
*t::
vkFF & t::
vkEB & t::
LControl & t::
RControl & t::
LShift & t::
RShift & t::{
	mbind_t()
}
*u::
vkFF & u::
vkEB & u::
LControl & u::
RControl & u::
LShift & u::
RShift & u::{
	mbind_u()
}
*v::
vkFF & v::
vkEB & v::
LControl & v::
RControl & v::
LShift & v::
RShift & v::{
	mbind_v()
}
*w::
vkFF & w::
vkEB & w::
LControl & w::
RControl & w::
LShift & w::
RShift & w::{
	mbind_w()
}
*x::
vkFF & x::
vkEB & x::
LControl & x::
RControl & x::
LShift & x::
RShift & x::{
	mbind_x()
}
*y::
vkFF & y::
vkEB & y::
LControl & y::
RControl & y::
LShift & y::
RShift & y::{
	mbind_y()
}
*z::
vkFF & z::
vkEB & z::
LControl & z::
RControl & z::
LShift & z::
RShift & z::{
	mbind_z()
}
*1::
vkFF & 1::
vkEB & 1::
LControl & 1::
RControl & 1::
LShift & 1::
RShift & 1::{
	mbind_1()
}
*2::
vkFF & 2::
vkEB & 2::
LControl & 2::
RControl & 2::
LShift & 2::
RShift & 2::{
	mbind_2()
}
*3::
vkFF & 3::
vkEB & 3::
LControl & 3::
RControl & 3::
LShift & 3::
RShift & 3::{
	mbind_3()
}
*4::
vkFF & 4::
vkEB & 4::
LControl & 4::
RControl & 4::
LShift & 4::
RShift & 4::{
	mbind_4()
}
*5::
vkFF & 5::
vkEB & 5::
LControl & 5::
RControl & 5::
LShift & 5::
RShift & 5::{
	mbind_5()
}
*6::
vkFF & 6::
vkEB & 6::
LControl & 6::
RControl & 6::
LShift & 6::
RShift & 6::{
	mbind_6()
}
*7::
vkFF & 7::
vkEB & 7::
LControl & 7::
RControl & 7::
LShift & 7::
RShift & 7::{
	mbind_7()
}
*8::
vkFF & 8::
vkEB & 8::
LControl & 8::
RControl & 8::
LShift & 8::
RShift & 8::{
	mbind_8()
}
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
RButton & WheelUp::{
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
