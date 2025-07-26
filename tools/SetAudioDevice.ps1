# https://github.com/frgnca/AudioDeviceCmdlets
# 必須モジュール
# Install-Module -Name AudioDeviceCmdlets -Scope CurrentUser

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Windows.Forms

# XAML（WPF UI定義）
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="Select Audio Device"
        Height="300" Width="400"
        WindowStartupLocation="CenterScreen"
        ResizeMode="NoResize">
    <Grid Margin="10">
        <Grid.RowDefinitions>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <ListBox Name="DeviceList" FontSize="14" Grid.Row="0" Margin="0,0,0,10"/>

        <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Right" >
            <Button Name="CancelButton" Width="80" Margin="5" Content="Cancel"/>
            <Button Name="OkButton" Width="80" Margin="5" Content="OK"/>
        </StackPanel>
    </Grid>
</Window>
"@

# XAMLを読み込む
[xml]$xamlReader = $xaml
$reader = (New-Object System.Xml.XmlNodeReader $xamlReader)
$window = [Windows.Markup.XamlReader]::Load($reader)
$window.Topmost = $true

# コントロール参照を取得
$deviceList = $window.FindName("DeviceList")
$okButton   = $window.FindName("OkButton")
$cancelButton = $window.FindName("CancelButton")

# オーディオデバイス取得（AudioDeviceCmdlets 必須）
$devices = Get-AudioDevice -List | Where-Object { $_.Type -eq "Playback" }
$devices | ForEach-Object { $deviceList.Items.Add($_.Name) }

# OKボタン処理
$okButton.Add_Click({
    if ($deviceList.SelectedIndex -ge 0) {
        $selected = $devices[$deviceList.SelectedIndex]
        Set-AudioDevice -Index $selected.Index
        $window.Close()
    }
})

# Cancelボタン処理
$cancelButton.Add_Click({ $window.Close() })

# ウィンドウ表示（ShowDialog()は同期的）
$window.ShowDialog() | Out-Null
