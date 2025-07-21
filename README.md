# myAHKv2

このリポジトリは、AutoHotkey v2 を用いたキーバインド・マクロ環境です。メインスクリプト `Main.ahk` から各種ライブラリおよびツールを読み込み、Windows 操作を効率化します。

## 構成

- **Main.ahk** - エントリースクリプト。DPI 設定やトレイアイコンの設定後、`myAHKComponents` 以下の各ファイルを読み込みます。
- **myAHKComponents/**
  - `MBindListener.ahk` / `MBind.ahk` / `MBindSetting.ahk` … キー入力のフックおよび複雑なバインドを定義。
  - `Library/` … クリップボード拡張やウィンドウ操作、IME 制御など汎用関数群を格納。
  - `Tools/` … 音声デバイス切替（WPF UI）、Philips Hue 制御、YouTube ダウンロード補助などのスクリプトを配置。
- **icon.ico** - AHK 実行時に使用するトレイアイコン。
- **MANUAL.pptx** - 利用手順をまとめた PowerPoint 資料（参考用）。

`Env/` ディレクトリはユーザー毎の設定・マクロ用で `.gitignore` により追跡対象外です。必要に応じて各種テキストを配置してください。

## 必要環境

- Windows 10 以降
- [AutoHotkey v2](https://www.autohotkey.com/) がインストールされていること
- 付属スクリプトを利用する場合は PowerShell 7 や Python などの実行環境が必要となる場合があります

## 使い方

1. `Main.ahk` を AutoHotkey v2 で実行します。
2. キーバインドやマクロは `MBind.ahk` で定義されています。必要に応じて `Env/` 以下へ個別設定を追加してください。
3. 付属のツール類は `myAHKComponents/Tools` にあります。単体で実行することも、AHK から呼び出すことも可能です。

## ライセンス

本リポジトリには明示的なライセンス表記がありません。利用・改変は自己責任でお願いいたします。

