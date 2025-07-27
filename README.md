# myAHKv2

myAHKv2 は Windows 環境で利用する AutoHotkey v2 用のマクロ集です。HHKB キーボードを前提とした独自の修飾キーや、Excel・PowerPoint などアプリケーション別のショートカットを提供します。各種ユーティリティやテンプレートファイルも同梱されており、作業効率化を目的としたスクリプト群となっています。

## 特徴

- **AutoHotkey v2 スクリプト**: `Main.ahk` から各種ライブラリを読み込みます。`src` 以下にキーバインドやユーティリティ関数を配置しています。
- **アプリケーション個別バインド**: `IWA_Excel.ahk` や `IWA_PowerPoint.ahk` では、アプリケーション固有の操作をワンキーで実行できるように設定しています。
- **拡張クリップボード機能**: `Util_Clip.ahk` には、クリップボード履歴管理や暗号化したテキストを Trello に送受信する仕組みが含まれています。
- **環境設定ファイル**: `env/env.yaml` を利用して API キーなどの値を保存します。`Util_Core.ahk` の `setEnv`/`getEnv` 関数から読み書きします。
- **Discord へのログ通知**: `logger` 関数を用いて Discord Webhook にログを送信できます。
- **補助スクリプト**: `tools` フォルダにはオーディオデバイス切り替え (`SetAudioDevice.ps1`) やマウスカーソル変更 (`SetMouseCursor.ps1`) などの PowerShell スクリプト、CO2 センサー値を `env.yaml` に書き込む Python スクリプト (`read_co2.py`) を収録しています。

## 使い方

1. Windows に [AutoHotkey v2](https://www.autohotkey.com/) をインストールします。
2. `env/env.yaml` を作成し、必要な設定値 (Discord の Webhook URL など) を記入します。
3. `Main.ahk` を実行するとトレイアイコンが表示されます。停止やリロードは以下のキーで操作できます。
   - **Alt + .** : スクリプトの一時停止
   - **Alt + ,** : スクリプトの再読み込み
   - **Alt + /** : スクリプトの終了
4. 詳細なキーバインドは `src` 配下の各ファイルを参照してください。`MANUAL.pptx` には操作マニュアルが含まれています。

## ディレクトリ構成

```
myAHKv2/
├── Main.ahk                # メインスクリプト
├── src/                    # 各種ライブラリ・バインド定義
├── tools/                  # 補助ツール (PowerShell / Python)
├── icon.ico                # トレイアイコン
└── MANUAL.pptx             # マニュアル資料
```

## ライセンス

本リポジトリには明示的なライセンス表記がありません。利用の際は作者に確認してください。

