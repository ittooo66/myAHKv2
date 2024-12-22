#Requires AutoHotkey v2.0

;super global variable
global A_SpaceDownTime := 0
global A_SpaceDownFlag := 0
global A_SpaceConsumeFlag := 0

;icon settings
TraySetIcon(A_WorkingDir . "\myAHKComponents\Resources" . "\icon.ico","1")
;MouseCursor Setting
execScripts("mouseCursor_black.ps1")

;Majinai
InstallKeybdHook
A_HotkeyInterval := 100
#UseHook

;Disable CAPSLOCK & VKs & WindowsKey
;各所にRWin,>#,LWin,<#の定義を入れるとWinキーの無効化がやりきれなくなる。
;RWinとLWinの状態はGetKeyState()からのみ取得することとし、MBindListener等に関連定義を入れないこと。
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
<!Tab::AltTab

;IME
LShift Up::IME_EN()
RShift Up::IME_JP()

;AHK Control
RAlt & ,::AHK_Reload()
XButton2 & MButton::AHK_Reload()
RAlt & .::AHK_Exit()
XButton1 & MButton::AHK_Exit()


;Components Root Directory
#Include "%A_ScriptDir%\myAHKComponents"
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
