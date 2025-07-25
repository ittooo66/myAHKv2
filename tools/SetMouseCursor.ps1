# このスクリプトは、Windowsのマウスカーソルスキームを切り替えるものです。
# 引数 -Scheme に "black" または "standard" を指定することで、
# それぞれ「Windows Black カーソル」または「標準カーソル」に変更します。
#
# カーソル設定はレジストリ（HKEY_CURRENT_USER\Control Panel\Cursors）に保存され、
# 変更後はSystemParametersInfo APIを呼び出して即時反映されます。
#
# 例：
#   .\SetMouseCursor.ps1 black     → 黒いカーソルに変更
#   .\SetMouseCursor.ps1 standard  → 標準カーソルに変更

param(
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateSet("black", "standard")]
    [string]$Scheme
)

function Set-CursorScheme {
    param([string]$Scheme)

    $RegConnect = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::CurrentUser, "$env:COMPUTERNAME")
    $RegCursors = $RegConnect.OpenSubKey("Control Panel\Cursors", $true)

    switch ($Scheme) {
        "black" {
            $RegCursors.SetValue("", "Windows Black")
            $RegCursors.SetValue("AppStarting", "%SystemRoot%\cursors\wait_r.cur")
            $RegCursors.SetValue("Arrow", "%SystemRoot%\cursors\arrow_r.cur")
            $RegCursors.SetValue("Crosshair", "%SystemRoot%\cursors\cross_r.cur")
            $RegCursors.SetValue("Hand", "")
            $RegCursors.SetValue("Help", "%SystemRoot%\cursors\help_r.cur")
            $RegCursors.SetValue("IBeam", "%SystemRoot%\cursors\beam_r.cur")
            $RegCursors.SetValue("No", "%SystemRoot%\cursors\no_r.cur")
            $RegCursors.SetValue("NWPen", "%SystemRoot%\cursors\pen_r.cur")
            $RegCursors.SetValue("SizeAll", "%SystemRoot%\cursors\move_r.cur")
            $RegCursors.SetValue("SizeNESW", "%SystemRoot%\cursors\size1_r.cur")
            $RegCursors.SetValue("SizeNS", "%SystemRoot%\cursors\size4_r.cur")
            $RegCursors.SetValue("SizeNWSE", "%SystemRoot%\cursors\size2_r.cur")
            $RegCursors.SetValue("SizeWE", "%SystemRoot%\cursors\size3_r.cur")
            $RegCursors.SetValue("UpArrow", "%SystemRoot%\cursors\up_r.cur")
            $RegCursors.SetValue("Wait", "%SystemRoot%\cursors\busy_r.cur")
        }
        "standard" {
            $RegCursors.SetValue("", "Windows Standard")
            $RegCursors.SetValue("AppStarting", "%SystemRoot%\cursors\aero_working.ani")
            $RegCursors.SetValue("Arrow", "%SystemRoot%\cursors\aero_arrow.cur")
            $RegCursors.SetValue("Crosshair", "")
            $RegCursors.SetValue("Hand", "%SystemRoot%\cursors\aero_link.cur")
            $RegCursors.SetValue("Help", "%SystemRoot%\cursors\aero_helpsel.cur")
            $RegCursors.SetValue("IBeam", "")
            $RegCursors.SetValue("No", "%SystemRoot%\cursors\aero_unavail.cur")
            $RegCursors.SetValue("NWPen", "%SystemRoot%\cursors\aero_pen.cur")
            $RegCursors.SetValue("SizeAll", "%SystemRoot%\cursors\aero_move.cur")
            $RegCursors.SetValue("SizeNESW", "%SystemRoot%\cursors\aero_nesw.cur")
            $RegCursors.SetValue("SizeNS", "%SystemRoot%\cursors\aero_ns.cur")
            $RegCursors.SetValue("SizeNWSE", "%SystemRoot%\cursors\aero_nwse.cur")
            $RegCursors.SetValue("SizeWE", "%SystemRoot%\cursors\aero_ew.cur")
            $RegCursors.SetValue("UpArrow", "%SystemRoot%\cursors\aero_up")
            $RegCursors.SetValue("Wait", "%SystemRoot%\cursors\aero_busy.ani")
        }
    }

    $RegCursors.Close()
    $RegConnect.Close()
}

function Update-UserPreferencesMask {
    $Signature = @"
[DllImport("user32.dll", EntryPoint = "SystemParametersInfo")]
public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, uint pvParam, uint fWinIni);

const int SPI_SETCURSORS = 0x0057;
const int SPIF_UPDATEINIFILE = 0x01;
const int SPIF_SENDCHANGE = 0x02;

public static void UpdateUserPreferencesMask() {
    SystemParametersInfo(SPI_SETCURSORS, 0, 0, SPIF_UPDATEINIFILE | SPIF_SENDCHANGE);
}
"@
    Add-Type -MemberDefinition $Signature -Name UserPreferencesMaskSPI -Namespace User32 -ErrorAction SilentlyContinue
    [User32.UserPreferencesMaskSPI]::UpdateUserPreferencesMask()
}

Set-CursorScheme $Scheme
Update-UserPreferencesMask
