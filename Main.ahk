#Requires AutoHotkey v2.0
#SingleInstance Force

;タッチパッドのスクロールで上限こえるため、ホットキー入力頻度を緩和する(デフォルト70)。
A_MaxHotkeysPerInterval := 140

;DPI Aware Per Monitor設定。ピクセル操作するあらゆる関数がこの設定ないと事故るので必須。
DllCall("SetThreadDpiAwarenessContext", "ptr", -4, "ptr")

;appearance settings
TraySetIcon(A_WorkingDir . "\icon.ico","1")
execScripts("SetMouseCursor.ps1",,"black")

;Majinai
InstallKeybdHook
#UseHook

;Core
#Include "%A_ScriptDir%\src\Core_Hooks.ahk"
#Include "%A_ScriptDir%\src\Core_Mods.ahk"
#Include "%A_ScriptDir%\src\Core_Binds.ahk"
;Library
#Include "%A_ScriptDir%\src\Util_General.ahk"
#Include "%A_ScriptDir%\src\Util_Clip.ahk"
#Include "%A_ScriptDir%\src\Util_IME.ahk"
#Include "%A_ScriptDir%\src\Util_Mouse.ahk"
#Include "%A_ScriptDir%\src\Util_Macros.ahk"
;HotIf WinActives
#Include "%A_ScriptDir%\src\IWA_Any.ahk"
#Include "%A_ScriptDir%\src\IWA_Excel.ahk"
#Include "%A_ScriptDir%\src\IWA_Powerpoint.ahk"
