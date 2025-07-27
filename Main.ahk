#Requires AutoHotkey v2.0
#SingleInstance Force

;DPI Aware Per Monitor設定。ピクセル操作するあらゆる関数がこの設定ないと事故るので必須。
DllCall("SetThreadDpiAwarenessContext", "ptr", -4, "ptr")

;appearance settings
TraySetIcon(A_WorkingDir . "\icon.ico","1")
execScripts("SetMouseCursor.ps1",,"black")

;Majinai
InstallKeybdHook
#UseHook

;Core
#Include "%A_ScriptDir%\src\Core_Hook.ahk"
#Include "%A_ScriptDir%\src\Core_Setting.ahk"
#Include "%A_ScriptDir%\src\Core_Bind.ahk"
;Library
#Include "%A_ScriptDir%\src\Util_Core.ahk"
#Include "%A_ScriptDir%\src\Util_Clip.ahk"
#Include "%A_ScriptDir%\src\Util_IME.ahk"
#Include "%A_ScriptDir%\src\Util_Mouse.ahk"
#Include "%A_ScriptDir%\src\Util_Macros.ahk"
;HotIf WinActives
#Include "%A_ScriptDir%\src\IWA_Any.ahk"
#Include "%A_ScriptDir%\src\IWA_Excel.ahk"
#Include "%A_ScriptDir%\src\IWA_Powerpoint.ahk"
