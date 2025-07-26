#Requires AutoHotkey v2.0
#SingleInstance Force

; DPI Aware Per Monitor設定。ピクセル操作するあらゆる関数がこの設定ないと事故るので必須。
DllCall("SetThreadDpiAwarenessContext", "ptr", -4, "ptr")

;appearance settings
TraySetIcon(A_WorkingDir . "\icon.ico","1")
execScripts("SetMouseCursor.ps1",,"black")

; Majinai
InstallKeybdHook
#UseHook

;MBind
#Include "%A_ScriptDir%\src\Core_Hook.ahk"
#Include "%A_ScriptDir%\src\Core_Setting.ahk"
#Include "%A_ScriptDir%\src\Core_Binds.ahk"
;Library
#Include "%A_ScriptDir%\src\Util_Core.ahk"
#Include "%A_ScriptDir%\src\Util_Clip.ahk"
#Include "%A_ScriptDir%\src\Util_IME.ahk"
#Include "%A_ScriptDir%\src\Util_Mouse.ahk"
;HotIf WinActives
#Include "%A_ScriptDir%\src\IWA_General.ahk"
#Include "%A_ScriptDir%\src\IWA_Excel.ahk"
#Include "%A_ScriptDir%\src\IWA_Powerpoint.ahk"
;TempMacro
#Include "%A_ScriptDir%\env\MacroZ.ahk"
#Include "%A_ScriptDir%\env\MacroX.ahk"
#Include "%A_ScriptDir%\env\MacroBRL.ahk"
#Include "%A_ScriptDir%\env\MacroBRR.ahk"
#Include "%A_ScriptDir%\env\MacroSLS.ahk"
#Include "%A_ScriptDir%\env\MacroSMC.ahk"
