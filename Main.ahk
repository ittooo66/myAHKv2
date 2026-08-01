#Requires AutoHotkey v2.0
#SingleInstance Force

;押しっぱなし現象への対処案。一旦試してみる
SendMode "Event"

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
#Include "src\Core_Hooks.ahk"
#Include "src\Core_Mods.ahk"
#Include "src\Core_Binds.ahk"
;Library
#Include "src\Util_General.ahk"
#Include "src\Util_Clip.ahk"
#Include "src\Util_IME.ahk"
#Include "src\Util_Mouse.ahk"
#Include "src\Util_Macros.ahk"
#Include "src\Util_ModifierStuckMonitor.ahk"
;HotIf WinActives
#Include "src\IWA_Any.ahk"
#Include "src\IWA_Excel.ahk"
#Include "src\IWA_Powerpoint.ahk"

; エラーのポップアップをtooltipで表示する
OnError(MyErrorHandler)
MyErrorHandler(e, mode) {
    ToolTip "エラー: " e.Message "`nファイル: " e.File "`n行: " e.Line
    SetTimer () => ToolTip(), -5000  ; 5秒後に消す
    return true  ; true を返すとデフォルトのエラー表示を抑止
}