#Requires AutoHotkey v2.0

;appearance settings
TraySetIcon(A_WorkingDir . "\myAHKComponents" . "\icon.ico","1")
execScripts("mouseCursor_black.ps1")

;(deprecated)super global variable
global A_SpaceDownTime := 0
global A_SpaceDownFlag := 0
global A_SpaceConsumeFlag := 0

; Majinai
InstallKeybdHook
#UseHook

;Disable Keys
;各所にRWin,>#,LWin,<#の定義を入れるとWinキーの無効化がやりきれなくなる。
;RWinとLWinの状態はGetKeyState()からのみ取得することとし、MBindListener等に関連定義を入れないこと。
sc03a::return ; Capslock
vkFF::return ; 変換/無変換(JPキーボード向け)
vkEB::return ; 変換/無変換(JPキーボード向け)
RWin::Send("{RWin Up}") ; Windows(Right)
LWin::return ; Windows(Left)

;Change Base Bindings
Delete::`
RAlt::RWin

;AltTab
XButton1 & WheelUp::ShiftAltTab
XButton1 & WheelDown::AltTab
Alt & Tab::AltTab

;IME
LShift Up::IME_EN()
RShift Up::IME_JP()

;AHK Control
RAlt & ,::AHK_Reload()
XButton2 & MButton::AHK_Reload()
RAlt & .::AHK_Exit()
XButton1 & MButton::AHK_Exit()

;MBind
#Include "%A_ScriptDir%\myAHKComponents\MBindListener.ahk"
#Include "%A_ScriptDir%\myAHKComponents\MBindSetting.ahk"
#Include "%A_ScriptDir%\myAHKComponents\MBind.ahk"
;Library
#Include "%A_ScriptDir%\myAHKComponents\Library\_STD.ahk"
#Include "%A_ScriptDir%\myAHKComponents\Library\Clip.ahk"
#Include "%A_ScriptDir%\myAHKComponents\Library\IME.ahk"
#Include "%A_ScriptDir%\myAHKComponents\Library\Mouse.ahk"
;HotIf WinActives
#Include "%A_ScriptDir%\myAHKComponents\Library\IWA_General.ahk"
#Include "%A_ScriptDir%\myAHKComponents\Library\IWA_MS_Excel.ahk"
#Include "%A_ScriptDir%\myAHKComponents\Library\IWA_MS_Powerpoint.ahk"
;TempMacro
#Include "%A_ScriptDir%\Env\MacroZ.ahk"
#Include "%A_ScriptDir%\Env\MacroX.ahk"
#Include "%A_ScriptDir%\Env\MacroC.ahk"
#Include "%A_ScriptDir%\Env\MacroBRL.ahk"
#Include "%A_ScriptDir%\Env\MacroBRR.ahk"
#Include "%A_ScriptDir%\Env\MacroSLS.ahk"
#Include "%A_ScriptDir%\Env\MacroSMC.ahk"
#Include "%A_ScriptDir%\Env\MacroYEN.ahk"

