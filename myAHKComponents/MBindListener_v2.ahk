;*Xで修飾キー周り代替：不可能!フック力不足？幾つか漏れる、謎
;Windowsキーのバインド(RWin & *, >#* など)は定義するとWinキー無効が漏れるので行わないこと！GetKeyStateで管理する

*a::{
	mbind_a()
}

*b::{
	mbind_b()
}

*c::{
	mbind_c()
}

*d::{
	mbind_d()
}

*e::{
	mbind_e()
}

*f::{
	mbind_f()
}

*g::{
	mbind_g()
}

*h::{
	mbind_h()
}

*i::{
	mbind_i()
}

*j::{
	mbind_j()
}

*k::{
	mbind_k()
}

*l::{
	mbind_l()
}

*m::{
	mbind_m()
}

*n::{
	mbind_n()
}

*o::{
	mbind_o()
}

*p::{
	mbind_p()
}

*q::{
	mbind_q()
}

*r::{
	mbind_r()
}

*s::{
	mbind_s()
}

*t::{
	mbind_t()
}

*u::{
	mbind_u()
}

*v::{
	mbind_v()
}

*w::{
	mbind_w()
}

*x::{
	mbind_x()
}

*y::{
	mbind_y()
}

*z::{
	mbind_z()
}

*1::{
	mbind_1()
}

*2::{
	mbind_2()
}

*3::{
	mbind_3()
}

*4::{
	mbind_4()
}

*5::{
	mbind_5()
}

*6::{
	mbind_6()
}

*7::{
	mbind_7()
}

*8::{
	mbind_8()
}

*9::{
	mbind_9()
}

*0::{
	mbind_0()
}

*-::{
	mbind_minus()
}

*=::{
	mbind_equal()
}

*\::{
	mbind_backslash()
}

;エスケープシーケンス（`;）使用でのバインド
*;::{
	mbind_semicolon()
}

*'::{
	mbind_quote()
}

*.::{
	mbind_period()
}

*,::{
	mbind_camma()
}

*/::{
	mbind_slash()
}

*[::{
	mbind_bracket_left()
}

*]::{
	mbind_bracket_right()
}

*BackSpace::{
	mbind_backspace()
}

*Enter::{
	mbind_enter()
}

*`::{
	mbind_delete()
}

*Esc::{
	mbind_escape()
}

<!Tab::AltTab
*Tab::
<^Tab::
>^Tab::
>+Tab::
<+Tab::
vkFF & Tab::
LControl & Tab::
vkEB & Tab::
RControl & Tab::
RShift & Tab::
LShift & Tab::
{
	mbind_tab()	
}

;Space機能
*Space::mbind_space_down()
*Space Up::mbind_space_up()

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

RButton::
MButton & RButton::
XButton1 & RButton::
XButton2 & RButton::
F19 & RButton::
F20 & RButton::
^!RButton::
!+RButton::
{
	mbind_mrb()
}

MButton::
RButton & MButton::
;XButton1 & MButton::AHK RELOADで利用
;XButton2 & MButton::AHK SUSPENDで利用
F19 & MButton::
;F20 & MButton::AHK EXITで利用
^!MButton::
!+MButton::
{
	mbind_mmb()
}

WheelUp::
MButton & WheelUp::
RButton & WheelUp::
;XButton1 & WheelUp::ALTTABで利用
XButton2 & WheelUp::
F20 & WheelUp::
F19 & WheelUp::
^!WheelUp::
!+WheelUp::
{
	mbind_wheelup()
}

WheelDown::
MButton & WheelDown::
RButton & WheelDown::
;XButton1 & WheelDown::ALTTABで利用
XButton2 & WheelDown::
F20 & WheelDown::
F19 & WheelDown::
^!WheelDown::
!+WheelDown::
{
	mbind_wheeldown()
}

XButton1::
RButton & XButton1::
MButton & XButton1::
XButton2 & XButton1::
F19 & XButton1::
F20 & XButton1::
^!XButton1::
!+XButton1::
{
	mbind_msblb()
}

XButton2::
RButton & XButton2::
MButton & XButton2::
XButton1 & XButton2::
F19 & XButton2::
F20 & XButton2::
^!XButton2::
!+XButton2::
{
	mbind_msblf()
}

F19::
RButton & F19::
MButton & F19::
XButton1 & F19::
XButton2 & F19::
F20 & F19::
{
	mbind_msbrf()
}

F20::
RButton & F20::
MButton & F20::
XButton1 & F20::
XButton2 & F20::
F19 & F20::
{
	mbind_msbrb()
}


Numpad1::
NumpadEnd::
{
	mbind_key1()
}

Numpad2::
NumpadDown::
{
	mbind_key2()
}

Numpad3::
NumpadPgdn::
{
	mbind_key3()
}

Numpad4::
NumpadLeft::
{
	mbind_key4()
}

Numpad5::
NumpadClear::
{
	mbind_key5()
}

Numpad6::
NumpadRight::
{
	mbind_key6()
}

Numpad7::
NumpadHome::
{
	mbind_key7()
}

Numpad8::
NumpadUp::
{
	mbind_key8()
}


Numpad9::
NumpadPgup::
{
	mbind_key9()
}





