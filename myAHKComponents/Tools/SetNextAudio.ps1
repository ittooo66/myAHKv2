# Need https://github.com/frgnca/AudioDeviceCmdlets

# 現在設定中のPlaybackデバイスIDを取得
$nowPlaybackId = (Get-AudioDevice -Playback).Index

# 名称出力先パス
$path = "C:\Users\ittoo\OneDrive\Backups\SRC\ahkv2\Env\AUDIO_DEVICE.txt"

# デバイス分ループ
for ($index = $nowPlaybackId + 1 ; $index -le (Get-AudioDevice -List).length; $index++) {
  if( (Get-AudioDevice -Index $index).Type -eq "Playback" ){
		# 設定
		Set-AudioDevice -Index $index

		# 設定したオーディオデバイス名称を出力
		Set-Content -Path $path -Value (Get-AudioDevice -Index $index).Name
        
    # 終了
    exit
	}
}

# デバイス分ループ(後半IDで見つけられなかった場合)
for ($index = 1 ; $index -lt $nowPlaybackId ; $index++) {
	if( (Get-AudioDevice -Index $index).Type -eq "Playback" ){
		# 設定
		Set-AudioDevice -Index $index

		# 設定したオーディオデバイス名称を出力
		Set-Content -Path $path -Value (Get-AudioDevice -Index $index).Name
        
        # 終了
        exit
	}
}
