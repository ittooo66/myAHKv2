#Requires AutoHotkey v2.0
#SingleInstance Force

;appearance settings
TraySetIcon(A_WorkingDir . "\icon.ico","1")
execScripts("mouseCursor_black.ps1")

; Majinai
InstallKeybdHook
#UseHook

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
#Include "%A_ScriptDir%\myAHKComponents\Library\IWA_Excel.ahk"
#Include "%A_ScriptDir%\myAHKComponents\Library\IWA_Powerpoint.ahk"
;TempMacro
#Include "%A_ScriptDir%\Env\MacroZ.ahk"
#Include "%A_ScriptDir%\Env\MacroX.ahk"
#Include "%A_ScriptDir%\Env\MacroBRL.ahk"
#Include "%A_ScriptDir%\Env\MacroBRR.ahk"
#Include "%A_ScriptDir%\Env\MacroSLS.ahk"
#Include "%A_ScriptDir%\Env\MacroSMC.ahk"
