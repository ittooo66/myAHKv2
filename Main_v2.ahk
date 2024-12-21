#Requires AutoHotkey v2.0

global A_ResDir := A_WorkingDir . "\myAHKComponents\Resources"

;icon settings
TraySetIcon(A_ResDir . "\icon.ico","1")
;MouseCursor Setting
execScripts("mouseCursor_black.ps1")

;super global variable
global A_AppDir := A_ResDir . "\Apps"
global A_SpaceDownTime := 0
global A_SpaceDownFlag := 0
global A_SpaceConsumeFlag := 0
global A_Toggle_AudioDevice := 0
global A_Toggle_Mute := 0

;Majinai
InstallKeybdHook()
A_HotkeyInterval := 100
#UseHook

;Components Root Directory
#Include "%A_ScriptDir%\myAHKComponents"

;Disable CAPSLOCK & VKs & WindowsKey
;他でRWin,>#,LWin,<#の組み合わせ定義を入れると挙動が変わる。
;RWinとLWinの状態はGetKeyState()からのみ取得することとし、
;MBindListener等に関連定義を入れないこと。
sc03a::return
vkFF::return
vkEB::return
RWin::return
LWin::return

;Change Base Bindings
Delete::`
RAlt::RWin

;AltTab
XButton1 & WheelUp::ShiftAltTab
XButton1 & WheelDown::AltTab

;IME
LShift Up::IME_EN()
RShift Up::IME_JP()

;AHK Control
RAlt & ,::
XButton2 & MButton::
{
	;#SuspendExempt
	splash("AHK reloading...",300)
	logger("AHK RELOADED","ahk_ctrl")
	Reload()
}

RAlt & .::
XButton1 & MButton::
{
	#SuspendExempt
	splash("AHK shutting down...",500)
	execScripts("mouseCursor_standard.ps1")
	logger("AHK EXIT", "ahk_ctrl")
	;rm flg file
	;FileDelete(A_ScriptDir "\isActive.flg")
	ExitApp()
}

;MBind
#Include "MBindListener_v2.ahk"
#Include "MBindSetting_v2.ahk"
#Include "MBind_v2.ahk"
;Library
#Include "Library\_STD_v2.ahk"
#Include "Library\Clip_v2.ahk"
#Include "Library\IME_v2.ahk"
#Include "Library\Mouse_v2.ahk"
;HotIf WinActives
#Include "HotIfWinActives\General.ahk"
#Include "HotIfWinActives\MS_Excel.ahk"
#Include "HotIfWinActives\MS_Powerpoint.ahk"
;TempMacro
#Include "Resources\TempMacro\MacroZ_v2.ahk"
#Include "Resources\TempMacro\MacroX_v2.ahk"
#Include "Resources\TempMacro\MacroC_v2.ahk"
#Include "Resources\TempMacro\MacroBRL_v2.ahk"
#Include "Resources\TempMacro\MacroBRR_v2.ahk"
#Include "Resources\TempMacro\MacroSLS_v2.ahk"
#Include "Resources\TempMacro\MacroSMC_v2.ahk"
#Include "Resources\TempMacro\MacroYEN_v2.ahk"

