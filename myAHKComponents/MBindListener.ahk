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

*a::
<^a::
>^a::
>+a::
<+a::
vkFF & a::
vkEB & a::
LControl & a::
RControl & a::
LShift & a::
RShift & a::{
	mbind_a()
}

*b::
<^b::
>^b::
>+b::
<+b::
vkFF & b::
vkEB & b::
LControl & b::
RControl & b::
LShift & b::
RShift & b::{
    mbind_b()
}

*c::
<^c::
>^c::
>+c::
<+c::
vkFF & c::
vkEB & c::
LControl & c::
RControl & c::
LShift & c::
RShift & c::{
    mbind_c()
}

*d::
<^d::
>^d::
>+d::
<+d::
vkFF & d::
vkEB & d::
LControl & d::
RControl & d::
LShift & d::
RShift & d::{
    mbind_d()
}

*e::
<^e::
>^e::
>+e::
<+e::
vkFF & e::
vkEB & e::
LControl & e::
RControl & e::
LShift & e::
RShift & e::{
    mbind_e()
}

*f::
<^f::
>^f::
>+f::
<+f::
vkFF & f::
vkEB & f::
LControl & f::
RControl & f::
LShift & f::
RShift & f::{
    mbind_f()
}

*g::
<^g::
>^g::
>+g::
<+g::
vkFF & g::
vkEB & g::
LControl & g::
RControl & g::
LShift & g::
RShift & g::{
    mbind_g()
}

*h::
<^h::
>^h::
>+h::
<+h::
vkFF & h::
vkEB & h::
LControl & h::
RControl & h::
LShift & h::
RShift & h::{
    mbind_h()
}

*i::
<^i::
>^i::
>+i::
<+i::
vkFF & i::
vkEB & i::
LControl & i::
RControl & i::
LShift & i::
RShift & i::{
    mbind_i()
}

*j::
<^j::
>^j::
>+j::
<+j::
vkFF & j::
vkEB & j::
LControl & j::
RControl & j::
LShift & j::
RShift & j::{
    mbind_j()
}

*k::
<^k::
>^k::
>+k::
<+k::
vkFF & k::
vkEB & k::
LControl & k::
RControl & k::
LShift & k::
RShift & k::{
    mbind_k()
}

*l::
<^l::
>^l::
>+l::
<+l::
vkFF & l::
vkEB & l::
LControl & l::
RControl & l::
LShift & l::
RShift & l::{
    mbind_l()
}

*m::
<^m::
>^m::
>+m::
<+m::
vkFF & m::
vkEB & m::
LControl & m::
RControl & m::
LShift & m::
RShift & m::{
    mbind_m()
}

*n::
<^n::
>^n::
>+n::
<+n::
vkFF & n::
vkEB & n::
LControl & n::
RControl & n::
LShift & n::
RShift & n::{
    mbind_n()
}

*o::
<^o::
>^o::
>+o::
<+o::
vkFF & o::
vkEB & o::
LControl & o::
RControl & o::
LShift & o::
RShift & o::{
    mbind_o()
}

*p::
<^p::
>^p::
>+p::
<+p::
vkFF & p::
vkEB & p::
LControl & p::
RControl & p::
LShift & p::
RShift & p::{
    mbind_p()
}

*q::
<^q::
>^q::
>+q::
<+q::
vkFF & q::
vkEB & q::
LControl & q::
RControl & q::
LShift & q::
RShift & q::{
    mbind_q()
}

*r::
<^r::
>^r::
>+r::
<+r::
vkFF & r::
vkEB & r::
LControl & r::
RControl & r::
LShift & r::
RShift & r::{
    mbind_r()
}

*s::
<^s::
>^s::
>+s::
<+s::
vkFF & s::
vkEB & s::
LControl & s::
RControl & s::
LShift & s::
RShift & s::{
    mbind_s()
}

*t::
<^t::
>^t::
>+t::
<+t::
vkFF & t::
vkEB & t::
LControl & t::
RControl & t::
LShift & t::
RShift & t::{
    mbind_t()
}

*u::
<^u::
>^u::
>+u::
<+u::
vkFF & u::
vkEB & u::
LControl & u::
RControl & u::
LShift & u::
RShift & u::{
    mbind_u()
}

*v::
<^v::
>^v::
>+v::
<+v::
vkFF & v::
vkEB & v::
LControl & v::
RControl & v::
LShift & v::
RShift & v::{
    mbind_v()
}

*w::
<^w::
>^w::
>+w::
<+w::
vkFF & w::
vkEB & w::
LControl & w::
RControl & w::
LShift & w::
RShift & w::{
    mbind_w()
}

*x::
<^x::
>^x::
>+x::
<+x::
vkFF & x::
vkEB & x::
LControl & x::
RControl & x::
LShift & x::
RShift & x::{
    mbind_x()
}

*y::
<^y::
>^y::
>+y::
<+y::
vkFF & y::
vkEB & y::
LControl & y::
RControl & y::
LShift & y::
RShift & y::{
    mbind_y()
}

*z::
<^z::
>^z::
>+z::
<+z::
vkFF & z::
vkEB & z::
LControl & z::
RControl & z::
LShift & z::
RShift & z::{
    mbind_z()
}

*1::
<^1::
>^1::
>+1::
<+1::
vkFF & 1::
vkEB & 1::
LControl & 1::
RControl & 1::
LShift & 1::
RShift & 1::{
    mbind_1()
}

*2::
<^2::
>^2::
>+2::
<+2::
vkFF & 2::
vkEB & 2::
LControl & 2::
RControl & 2::
LShift & 2::
RShift & 2::{
    mbind_2()
}

*3::
<^3::
>^3::
>+3::
<+3::
vkFF & 3::
vkEB & 3::
LControl & 3::
RControl & 3::
LShift & 3::
RShift & 3::{
    mbind_3()
}

*4::
<^4::
>^4::
>+4::
<+4::
vkFF & 4::
vkEB & 4::
LControl & 4::
RControl & 4::
LShift & 4::
RShift & 4::{
    mbind_4()
}

*5::
<^5::
>^5::
>+5::
<+5::
vkFF & 5::
vkEB & 5::
LControl & 5::
RControl & 5::
LShift & 5::
RShift & 5::{
    mbind_5()
}

*6::
<^6::
>^6::
>+6::
<+6::
vkFF & 6::
vkEB & 6::
LControl & 6::
RControl & 6::
LShift & 6::
RShift & 6::{
    mbind_6()
}

*7::
<^7::
>^7::
>+7::
<+7::
vkFF & 7::
vkEB & 7::
LControl & 7::
RControl & 7::
LShift & 7::
RShift & 7::{
    mbind_7()
}

*8::
<^8::
>^8::
>+8::
<+8::
vkFF & 8::
vkEB & 8::
LControl & 8::
RControl & 8::
LShift & 8::
RShift & 8::{
    mbind_8()
}

*9::
<^9::
>^9::
>+9::
<+9::
vkFF & 9::
vkEB & 9::
LControl & 9::
RControl & 9::
LShift & 9::
RShift & 9::{
    mbind_9()
}

*0::
<^0::
>^0::
>+0::
<+0::
vkFF & 0::
vkEB & 0::
LControl & 0::
RControl & 0::
LShift & 0::
RShift & 0::{
    mbind_0()
}

*-::
<^-::
>^-::
>+-::
<+-::
vkFF & -::
vkEB & -::
LControl & -::
RControl & -::
LShift & -::
RShift & -::{
    mbind_minus()
}

*=::
<^=::
>^=::
>+=::
<+=::
vkFF & =::
vkEB & =::
LControl & =::
RControl & =::
LShift & =::
RShift & =::{
    mbind_equal()
}

*\::
<^\::
>^\::
>+\::
<+\::
vkFF & \::
vkEB & \::
LControl & \::
RControl & \::
LShift & \::
RShift & \::{
    mbind_backslash()
}

*;::
<^;::
>^;::
>+;::
<+;::
vkFF & `;::
vkEB & `;::
LControl & `;::
RControl & `;::
LShift & `;::
RShift & `;::{
    mbind_semicolon()
}

*'::
<^'::
>^'::
>+'::
<+'::
vkFF & '::
vkEB & '::
LControl & '::
RControl & '::
LShift & '::
RShift & '::{
    mbind_quote()
}

*.::
<^.::
>^.::
>+.::
<+.::
vkFF & .::
vkEB & .::
LControl & .::
RControl & .::
LShift & .::
RShift & .::{
    mbind_period()
}

*,::
<^,::
>^,::
>+,::
<+,::
vkFF & ,::
vkEB & ,::
LControl & ,::
RControl & ,::
LShift & ,::
RShift & ,::{
    mbind_camma()
}

*/::
<^/::
>^/::
>+/::
<+/::
vkFF & /::
vkEB & /::
LControl & /::
RControl & /::
LShift & /::
RShift & /::{
    mbind_slash()
}

*[::
<^[::
>^[::
>+[::
<+[::
vkFF & [::
vkEB & [::
LControl & [::
RControl & [::
LShift & [::
RShift & [::{
	mbind_bracket_left()
}

*]::
<^]::
>^]::
>+]::
<+]::
vkFF & ]::
vkEB & ]::
LControl & ]::
RControl & ]::
LShift & ]::
RShift & ]::{
    mbind_bracket_right()
}

*BackSpace::
<^BackSpace::
>^BackSpace::
>+BackSpace::
<+BackSpace::
vkFF & BackSpace::
vkEB & BackSpace::
LControl & BackSpace::
RControl & BackSpace::
LShift & BackSpace::
RShift & BackSpace::{
    mbind_backspace()
}

*Enter::
<^Enter::
>^Enter::
>+Enter::
<+Enter::
vkFF & Enter::
vkEB & Enter::
LControl & Enter::
RControl & Enter::
LShift & Enter::
RShift & Enter::{
    mbind_enter()
}

*`::
<^`::
>^`::
>+`::
<+`::
vkFF & `::
vkEB & `::
LControl & `::
RControl & `::
LShift & `::
RShift & `::{
    mbind_delete()
}

*Esc::
<^Esc::
>^Esc::
>+Esc::
<+Esc::
vkFF & Esc::
vkEB & Esc::
LControl & Esc::
RControl & Esc::
LShift & Esc::
RShift & Esc::{
    mbind_escape()
}

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

