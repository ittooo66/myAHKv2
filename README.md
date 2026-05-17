# myAHKv2

Windows 作業を HHKB と多ボタンマウスで高速化するための AutoHotkey v2 スクリプト集です。キー入力、IME、マウス、ウィンドウ、クリップボード、Office 操作をまとめて扱います。

このリポジトリは汎用配布ツールというより、個人環境に合わせて育てる常駐型の productivity script です。`env/env.yaml` にローカルのアプリパスや API key を置き、`Main.ahk` から `src/` と `tools/` を読み込んで動かします。

## Features

- HHKB 前提の仮想修飾キー
- 左右 Shift による IME on / off
- Caps / RCMD 系のカーソル移動、F キー、テンキー、行削除
- Space を起点にしたスロット別クリップボード
- Explorer の選択パスを alias として保存 / 起動
- Supabase を使った簡易共有クリップボード
- マウスボタンによるウィンドウ移動、サイズ変更、タブ操作、仮想デスクトップ移動
- Excel / PowerPoint / VS Code / 動画プレイヤー / Explorer などのアプリ別バインド
- 修飾キー stuck 監視とリセット
- 起動、終了、リロード、ログ出力、補助 PowerShell 実行

## Requirements

- Windows
- AutoHotkey v2
- PowerShell 7 (`pwsh.exe`)
- HHKB 配列を前提にしたキーボード環境
- 多ボタンマウスを前提にした一部バインド

任意機能のために、環境によっては以下も必要です。

- Supabase REST endpoint と API key
- yt-dlp キュー用の保存先
- EarTrumpet など、コメントで前提が書かれている外部ツール
- `tools/SetAudioDevice.ps1` が想定する音声デバイス環境

## Quick Start

```powershell
git clone https://github.com/ittooo66/myAHKv2.git
cd myAHKv2
.\Main.ahk
```

`.ahk` の関連付けがない場合は、AutoHotkey v2 の実行ファイルから `Main.ahk` を指定して起動してください。

初回は `env/env.yaml` がなくても起動できます。ただし、アプリ起動、Supabase クリップボード、yt-dlp 連携など、個人設定を読む機能を使う場合は `env/env.yaml` が必要です。

## Startup

Windows 起動時に常駐させたい場合は、`Main.ahk` へのショートカットをスタートアップフォルダに置きます。`Win + R` で以下を実行するとスタートアップフォルダを開けます。

```powershell
shell:startup
```

`Main.ahk` は起動時に以下を行います。

- `#SingleInstance Force` で多重起動を抑止
- `SendMode "Event"` を設定
- DPI aware per monitor を有効化
- トレイアイコンに `icon.ico` を設定
- `tools/SetMouseCursor.ps1 black` を実行
- core / utility / application binding を読み込み
- AutoHotkey エラーを ToolTip に表示

## Hotkey Model

この README では、コード上の仮想修飾キー名をそのまま使います。

| 表記 | 主な意味 |
| --- | --- |
| `LCMD` | HHKB 左ダイヤ / 左 Windows 系 |
| `RCMD` | HHKB 右ダイヤ / 右 Windows 系 |
| `CAPS` | HHKB Control / CapsLock 系 |
| `SPACE` | Space |
| `SHIFT` | 左右 Shift |
| `ALT` | 左右 Alt |
| `MLB` / `MRB` / `MMB` | マウス左 / 右 / 中ボタン |
| `MSBLB` / `MSBLF` | 左側サイドボタン |
| `MSBRB` / `MSBRF` | 右側サイドボタン / `F19` / `F20` 系 |

実際の判定は `src/Core_Mods.ahk` にあります。フックの定義は原則 `src/Core_Hooks.ahk` に集約されています。

## Core Controls

AHK 自体の制御です。

| 操作 | 内容 |
| --- | --- |
| `Alt + .` | Suspend |
| `Alt + ,` | Reload |
| `XButton1 + MButton` | Suspend |
| `XButton2 + MButton` | Reload |
| `F19 + MButton` | Exit |
| `Ctrl + Alt + MButton` | Exit |

IME 操作です。

| 操作 | 内容 |
| --- | --- |
| `LShift Up` | IME off |
| `RShift Up` | IME on / ひらがな |
| `LCMD + Space` / `RCMD + Space` | IME 切り替え |

## Main Bindings

代表的なグローバルバインドです。詳細は `src/Core_Binds.ahk` を参照してください。

| 操作 | 内容 |
| --- | --- |
| `CAPS / RCMD + E/D/S/F` | カーソル上下左右 |
| `CAPS / RCMD + W/R` | Home / End |
| `CAPS / RCMD + Y/B` | PageUp / PageDown |
| `CAPS / RCMD + 2` - `0` | F2 - F10 |
| `CAPS / RCMD + -` / `=` | F11 / F12 |
| `CAPS + I/J/K/L` | Numpad 8/4/5/6 |
| `CAPS + U/M/,/.` | Numpad 7/1/2/3 |
| `CAPS / RCMD + Backspace` | 行頭まで削除 |
| `RCMD + Delete` | 行末まで削除 |
| `LCMD + q` | 連打判定付き Alt+F4 |
| `LCMD + ;` | 日付を直接入力 |
| `LCMD + Shift + ;` | 時刻を直接入力 |
| `CAPS / RCMD + /` | 時計 ToolTip |
| `Esc` | stuck した修飾キーのリセット |

## Clipboard

`src/Util_Clip.ahk` がクリップボード拡張を担当します。

| 操作 | 内容 |
| --- | --- |
| `LCMD + c` | コピーし、`clip.log` に追記 |
| `LCMD + x` | カットし、`clip.log` に追記 |
| `CAPS / RCMD + c` | Supabase へコピー |
| `CAPS / RCMD + v` | Supabase から貼り付け |
| `SPACE + key` | スロットから貼り付け |
| `SPACE + Shift + key` | スロットへコピー |
| `SPACE + CAPS + number` | Explorer alias を開く |
| `SPACE + CAPS + Shift + number` | Explorer の選択パスを alias に保存 |
| `CAPS / RCMD + Backslash` | `clip.log` を開く |

`clip.log` にはコピー / カットした文字列が残ります。秘密情報をコピーした場合は手動で削除してください。

## Mouse And Window Controls

`src/Util_Mouse.ahk` と `Core_Binds.ahk` のマウス系バインドで以下を行います。

- マウス移動とクリック
- ウィンドウ移動
- ウィンドウサイズ変更
- IntelliScroll
- タブ作成、タブ移動、閉じたタブの復元
- ウィンドウ最小化
- 仮想デスクトップ移動
- 音量操作と遅延 mute
- 音声デバイス切り替え

多ボタンマウスの割り当てに強く依存するため、環境が違う場合は `src/Core_Mods.ahk` と `src/Core_Binds.ahk` を調整してください。

## Application Bindings

アプリ別の上書き定義です。

| ファイル | 対象 |
| --- | --- |
| `src/IWA_Excel.ahk` | Excel (`ahk_class XLMAIN`) |
| `src/IWA_PowerPoint.ahk` | PowerPoint (`ahk_class PPTFrameClass`) |
| `src/IWA_Any.ahk` | VS Code, MPC-HC, MPC-BE, VLC, Explorer, League of Legends |

Excel では配置、罫線、塗りつぶし、ウィンドウ枠固定などを `LCMD + CAPS + key` に割り当てています。

PowerPoint ではトリミング、文字配置、図形選択、図形の塗りつぶし、整列、最前面 / 最背面、スライドマスタ、グループ化などを割り当てています。

動画プレイヤーでは戻る / 進む / IntelliScroll、Explorer ではタブ移動や新規タブ作成を補助します。

## Configuration

### env/env.yaml

`env/env.yaml` はローカル専用の設定ファイルです。`.gitignore` で除外されています。

`setEnv()` / `getEnv()` は単純な YAML 風の `key: 'value'` 形式を読み書きします。完全な YAML パーサーではないため、ネストや複雑な構文は使わず、1 行 1 key にしてください。

```yaml
APP_E_PATH: 'notepad.exe'
APP_E_CLASS: 'Notepad'
APP_E_PROCESS: 'notepad.exe'
APP_E_TITLE: ''
ClipExt_Api: 'https://example.supabase.co/rest/v1/clipboard'
ClipExt_ApiKey: 'your-local-api-key'
YTDLP_PATH: 'C:\path\to\queue\'
```

主な key です。

| key | 用途 |
| --- | --- |
| `APP_<ID>_PATH` | `launch()` で起動するアプリのパスまたはコマンド |
| `APP_<ID>_CLASS` | 既存ウィンドウ検索用の window class |
| `APP_<ID>_PROCESS` | 既存ウィンドウ検索用の process name |
| `APP_<ID>_TITLE` | 既存ウィンドウ検索用の window title |
| `CLIPEXT_<SLOT>` | スロット別クリップボードの保存値 |
| `CLIPEXT_ALIAS_<SLOT>` | Explorer alias の保存値 |
| `ClipExt_Api` | Supabase REST endpoint |
| `ClipExt_ApiKey` | Supabase API key |
| `YTDLP_PATH` | yt-dlp キュー用の保存先 |

### tools

| ファイル | 用途 |
| --- | --- |
| `tools/SetMouseCursor.ps1` | カーソルテーマを `black` / `standard` に切り替え |
| `tools/SetAudioDevice.ps1` | 音声デバイス切り替え |
| `tools/TemplatePPTX.potx` | PowerPoint 用テンプレート |
| `tools/TemplateXLSX.xltx` | Excel 用テンプレート |

## Project Structure

```text
myAHKv2/
├── Main.ahk
├── README.md
├── MANUAL.pptx
├── icon.ico
├── src/
│   ├── Core_Hooks.ahk
│   ├── Core_Mods.ahk
│   ├── Core_Binds.ahk
│   ├── IWA_Any.ahk
│   ├── IWA_Excel.ahk
│   ├── IWA_PowerPoint.ahk
│   ├── Util_Clip.ahk
│   ├── Util_General.ahk
│   ├── Util_IME.ahk
│   ├── Util_Macros.ahk
│   ├── Util_ModifierStuckMonitor.ahk
│   └── Util_Mouse.ahk
└── tools/
    ├── SetAudioDevice.ps1
    ├── SetMouseCursor.ps1
    ├── TemplatePPTX.potx
    └── TemplateXLSX.xltx
```

## Troubleshooting

### `pwsh.exe` が見つからない

PowerShell 7 をインストールし、`pwsh.exe` を PATH から実行できる状態にしてください。`execScripts()` は `.ps1` を `pwsh.exe` で起動します。

### 起動直後に ToolTip でエラーが出る

`Main.ahk` の `OnError()` が例外を ToolTip に表示します。`env/env.yaml` が必要な機能を呼び出している場合は、対象 key が存在するか確認してください。

### キーが押しっぱなしになったように見える

`Esc` またはリセット用のマウス操作で `resetMods()` を呼び出してください。`src/Util_ModifierStuckMonitor.ahk` も stuck 状態を ToolTip で通知します。

### Excel / PowerPoint のバインドが効かない

対象アプリがアクティブで、`IWA_Excel.ahk` / `IWA_PowerPoint.ahk` の `#HotIf` 条件に一致しているか確認してください。

### AutoHotkey v1 で起動してしまう

このリポジトリは `#Requires AutoHotkey v2.0` です。v1 と v2 を併用している環境では、`.ahk` の関連付けや起動に使う実行ファイルを確認してください。

## Security And Local Data

- `env/env.yaml` には API key、ローカルパス、アプリ設定が入ります。コミットしないでください。
- `clip.log` にはコピー / カットした文字列が残ります。秘密情報をコピーした場合は削除してください。
- `*.log`, `env/*`, `.vscode/*` は `.gitignore` 済みです。

## Manual

`MANUAL.pptx` に操作マニュアルがあります。最新の詳細はコード側、特に `src/Core_Binds.ahk` と `src/IWA_*.ahk` を確認してください。

## License

このリポジトリには明示的なライセンス表記がありません。
