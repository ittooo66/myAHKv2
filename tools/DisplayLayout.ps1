Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

if (-not ('DisplayLayout.Native' -as [type])) {
    Add-Type -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace DisplayLayout {
    [StructLayout(LayoutKind.Sequential)]
    public struct PointL {
        public int x;
        public int y;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct Rect {
        public int left;
        public int top;
        public int right;
        public int bottom;
    }

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
    public struct MonitorInfoEx {
        public int cbSize;
        public Rect rcMonitor;
        public Rect rcWork;
        public int dwFlags;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)] public string szDevice;
    }

    public struct ActiveMonitor {
        public string DeviceName;
        public bool Primary;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct Luid {
        public uint LowPart;
        public int HighPart;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct Rational {
        public uint Numerator;
        public uint Denominator;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct PathSourceInfo {
        public Luid adapterId;
        public uint id;
        public uint modeInfoIdx;
        public uint statusFlags;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct PathTargetInfo {
        public Luid adapterId;
        public uint id;
        public uint modeInfoIdx;
        public uint outputTechnology;
        public uint rotation;
        public uint scaling;
        public Rational refreshRate;
        public uint scanLineOrdering;
        public int targetAvailable;
        public uint statusFlags;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct PathInfo {
        public PathSourceInfo sourceInfo;
        public PathTargetInfo targetInfo;
        public uint flags;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct SourceMode {
        public uint width;
        public uint height;
        public uint pixelFormat;
        public PointL position;
    }

    [StructLayout(LayoutKind.Explicit, Size = 48)]
    public struct ModeUnion {
        [FieldOffset(0)] public SourceMode sourceMode;
        [FieldOffset(0)] public ulong raw0;
        [FieldOffset(8)] public ulong raw1;
        [FieldOffset(16)] public ulong raw2;
        [FieldOffset(24)] public ulong raw3;
        [FieldOffset(32)] public ulong raw4;
        [FieldOffset(40)] public ulong raw5;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct ModeInfo {
        public uint infoType;
        public uint id;
        public Luid adapterId;
        public ModeUnion modeInfo;
    }

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
    public struct DevMode {
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)] public string dmDeviceName;
        public short dmSpecVersion;
        public short dmDriverVersion;
        public short dmSize;
        public short dmDriverExtra;
        public int dmFields;
        public PointL dmPosition;
        public int dmDisplayOrientation;
        public int dmDisplayFixedOutput;
        public short dmColor;
        public short dmDuplex;
        public short dmYResolution;
        public short dmTTOption;
        public short dmCollate;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)] public string dmFormName;
        public short dmLogPixels;
        public int dmBitsPerPel;
        public int dmPelsWidth;
        public int dmPelsHeight;
        public int dmDisplayFlags;
        public int dmDisplayFrequency;
        public int dmICMMethod;
        public int dmICMIntent;
        public int dmMediaType;
        public int dmDitherType;
        public int dmReserved1;
        public int dmReserved2;
        public int dmPanningWidth;
        public int dmPanningHeight;
    }

    public static class Native {
        private delegate bool MonitorEnumProc(IntPtr monitor, IntPtr dc, IntPtr rect, IntPtr data);

        [DllImport("user32.dll", SetLastError = true)]
        private static extern bool EnumDisplayMonitors(IntPtr dc, IntPtr clip, MonitorEnumProc callback, IntPtr data);

        [DllImport("user32.dll", EntryPoint = "GetMonitorInfoW", CharSet = CharSet.Unicode, SetLastError = true)]
        private static extern bool GetMonitorInfo(IntPtr monitor, ref MonitorInfoEx info);

        [DllImport("user32.dll")]
        private static extern int GetDisplayConfigBufferSizes(uint flags, out uint pathCount, out uint modeCount);

        [DllImport("user32.dll")]
        private static extern int QueryDisplayConfig(uint flags, ref uint pathCount, [Out] PathInfo[] paths,
            ref uint modeCount, [Out] ModeInfo[] modes, IntPtr topologyId);

        [DllImport("user32.dll")]
        private static extern int SetDisplayConfig(uint pathCount, [In] PathInfo[] paths,
            uint modeCount, [In] ModeInfo[] modes, uint flags);

        public static ActiveMonitor[] GetActiveMonitors() {
            var monitors = new List<ActiveMonitor>();
            bool infoFailed = false;
            MonitorEnumProc callback = (monitor, dc, rect, data) => {
                var info = new MonitorInfoEx();
                info.cbSize = Marshal.SizeOf<MonitorInfoEx>();
                if (!GetMonitorInfo(monitor, ref info)) {
                    infoFailed = true;
                    return false;
                }
                monitors.Add(new ActiveMonitor {
                    DeviceName = info.szDevice,
                    Primary = (info.dwFlags & 1) != 0
                });
                return true;
            };
            if (!EnumDisplayMonitors(IntPtr.Zero, IntPtr.Zero, callback, IntPtr.Zero) || infoFailed) {
                throw new InvalidOperationException("有効なディスプレイを取得できません。");
            }
            return monitors.ToArray();
        }

        public static int SwitchPrimaryDisplay(bool apply) {
            if (Marshal.SizeOf<PathInfo>() != 72 || Marshal.SizeOf<ModeInfo>() != 64) {
                throw new InvalidOperationException("画面構成のデータ形式が一致しません。");
            }
            uint pathCount = 0, modeCount = 0;
            PathInfo[] paths = null;
            ModeInfo[] modes = null;
            int result = 122;
            for (int attempt = 0; attempt < 3; attempt++) {
                result = GetDisplayConfigBufferSizes(2, out pathCount, out modeCount); // QDC_ONLY_ACTIVE_PATHS
                if (result != 0) throw new InvalidOperationException("画面構成を取得できません (コード: " + result + ")");
                paths = new PathInfo[pathCount];
                modes = new ModeInfo[modeCount];
                result = QueryDisplayConfig(2, ref pathCount, paths, ref modeCount, modes, IntPtr.Zero);
                if (result == 0) break;
                if (result != 122) throw new InvalidOperationException("画面構成を取得できません (コード: " + result + ")");
            }
            if (result != 0) throw new InvalidOperationException("画面構成が変化したため取得できませんでした。");

            int sourceCount = 0, primaryCount = 0, otherIndex = -1;
            for (int i = 0; i < modeCount; i++) {
                if (modes[i].infoType != 1) continue; // DISPLAYCONFIG_MODE_INFO_TYPE_SOURCE
                sourceCount++;
                PointL position = modes[i].modeInfo.sourceMode.position;
                if (position.x == 0 && position.y == 0) primaryCount++;
                else otherIndex = i;
            }
            if (sourceCount != 2 || primaryCount != 1 || otherIndex < 0) {
                throw new InvalidOperationException("切り替え先の画面を特定できません。");
            }
            PointL offset = modes[otherIndex].modeInfo.sourceMode.position;
            for (int i = 0; i < modeCount; i++) {
                if (modes[i].infoType != 1) continue;
                ModeInfo mode = modes[i];
                ModeUnion union = mode.modeInfo;
                SourceMode source = union.sourceMode;
                source.position.x -= offset.x;
                source.position.y -= offset.y;
                union.sourceMode = source;
                mode.modeInfo = union;
                modes[i] = mode;
            }
            uint flags = apply ? 0x2A0u : 0x60u; // APPLY/VALIDATE | supplied config | save when applying
            return SetDisplayConfig(pathCount, paths, modeCount, modes, flags);
        }

        [DllImport("user32.dll", CharSet = CharSet.Unicode)]
        public static extern bool EnumDisplaySettingsEx(string device, int mode, ref DevMode settings, int flags);

        [DllImport("user32.dll", CharSet = CharSet.Unicode)]
        public static extern int ChangeDisplaySettingsEx(string device, ref DevMode settings, IntPtr hwnd, int flags, IntPtr parameter);

        [DllImport("user32.dll", CharSet = CharSet.Unicode)]
        public static extern int ChangeDisplaySettingsEx(string device, IntPtr settings, IntPtr hwnd, int flags, IntPtr parameter);
    }
}
'@
}

function Get-DisplayDevices {
    foreach ($screen in [DisplayLayout.Native]::GetActiveMonitors()) {
        [pscustomobject]@{
            DeviceName = $screen.DeviceName
            StateFlags = if ($screen.Primary) { 5 } else { 1 }
        }
    }
}

function Get-DisplayMode([string]$deviceName) {
    $mode = [DisplayLayout.DevMode]::new()
    $mode.dmSize = [Runtime.InteropServices.Marshal]::SizeOf([type][DisplayLayout.DevMode])
    if (-not [DisplayLayout.Native]::EnumDisplaySettingsEx($deviceName, -1, [ref]$mode, 0)) {
        throw "現在の表示設定を取得できません: $deviceName"
    }
    return $mode
}

function Wait-DisplayTopology([int]$expectedCount) {
    $active = @()
    $lastError = $null
    for ($attempt = 0; $attempt -lt 40; $attempt++) {
        try {
            $active = @(Get-DisplayDevices)
            $lastError = $null
            if ($active.Count -eq $expectedCount) { return }
        } catch {
            $lastError = $_.Exception.Message
        }
        Start-Sleep -Milliseconds 250
    }
    if ($lastError) { throw "画面構成を確認できませんでした: $lastError" }
    $names = @($active | ForEach-Object DeviceName) -join ', '
    throw "画面構成が指定どおりになりませんでした。現在の出力先: $names"
}

function Get-OrientationDisplayName {
    $displays = @(Get-DisplayDevices)
    if ($displays.Count -eq 1) { return $displays[0].DeviceName }
    if ($displays.Count -eq 2) {
        # In extended mode D2 is primary, so the other active display is D1.
        $nonPrimary = @($displays | Where-Object { -not ($_.StateFlags -band 4) })
        if ($nonPrimary.Count -eq 1) { return $nonPrimary[0].DeviceName }
    }
    throw '向きを変えるディスプレイ1を特定できません。'
}

function Set-DisplayOrientation([int]$orientation) {
    $deviceName = Get-OrientationDisplayName
    $mode = Get-DisplayMode $deviceName
    if ($mode.dmDisplayOrientation -eq $orientation) { return }
    if (($mode.dmDisplayOrientation % 2) -ne ($orientation % 2)) {
        $width = $mode.dmPelsWidth
        $mode.dmPelsWidth = $mode.dmPelsHeight
        $mode.dmPelsHeight = $width
    }
    $mode.dmDisplayOrientation = $orientation
    $mode.dmFields = 0x180080 # DM_DISPLAYORIENTATION | DM_PELSWIDTH | DM_PELSHEIGHT
    $result = [DisplayLayout.Native]::ChangeDisplaySettingsEx($deviceName, [ref]$mode, [IntPtr]::Zero, 1, [IntPtr]::Zero)
    if ($result -ne 0) { throw "画面の向きを変更できません (コード: $result)" }
}

function Set-DisplayTopology([string]$option, [int]$expectedCount) {
    if (@(Get-DisplayDevices).Count -eq $expectedCount) { return }
    $switch = Join-Path $env:WINDIR 'System32\DisplaySwitch.exe'
    $process = Start-Process -FilePath $switch -ArgumentList $option -Wait -PassThru
    if ($process.ExitCode -ne 0) { throw "画面構成の切り替えに失敗しました (コード: $($process.ExitCode))" }
    Wait-DisplayTopology $expectedCount
}

function Switch-MainDisplay {
    $displays = @(Get-DisplayDevices)
    if ($displays.Count -ne 2) { throw 'メイン切り替えは2画面のときに使用してください。' }
    $result = [DisplayLayout.Native]::SwitchPrimaryDisplay($false)
    if ($result -ne 0) { throw "メイン画面の変更を検証できません (コード: $result)" }
    $result = [DisplayLayout.Native]::SwitchPrimaryDisplay($true)
    if ($result -ne 0) { throw "メイン画面の変更を適用できません (コード: $result)" }
}

$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="Display Layout" SizeToContent="Height" Width="330"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize">
    <Grid Margin="14">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="14"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        <Button Name="OnlyButton" Grid.Row="0" Height="38" Margin="0,0,0,6" Content="D1 Only"/>
        <Button Name="ExtendButton" Grid.Row="1" Height="38" Margin="0,0,0,6" Content="D1 + D2"/>
        <Button Name="MainButton" Grid.Row="2" Height="38" Content="メイン切り替え"/>
        <Button Name="LandscapeButton" Grid.Row="4" Height="38" Margin="0,0,0,6" Content="D1 - W"/>
        <Button Name="PortraitFlippedButton" Grid.Row="5" Height="38" Content="D1 - H"/>
    </Grid>
</Window>
'@

$reader = [System.Xml.XmlNodeReader]::new([xml]$xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)
$window.Topmost = $true

$perform = {
    param([scriptblock]$action)
    try {
        & $action
        $window.Close()
    } catch {
        [System.Windows.MessageBox]::Show($_.Exception.Message, 'Display Layout', 'OK', 'Error') | Out-Null
    }
}

$window.FindName('OnlyButton').Add_Click({
    & $perform { Set-DisplayTopology '/internal' 1 }
})
$window.FindName('ExtendButton').Add_Click({
    & $perform { Set-DisplayTopology '/extend' 2 }
})
$window.FindName('MainButton').Add_Click({
    & $perform { Switch-MainDisplay }
})
$window.FindName('LandscapeButton').Add_Click({
    & $perform { Set-DisplayOrientation 0 }
})
$window.FindName('PortraitFlippedButton').Add_Click({
    & $perform { Set-DisplayOrientation 3 }
})

$window.ShowDialog() | Out-Null
