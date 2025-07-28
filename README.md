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

## src フォルダの関数一覧

各スクリプトで定義されている主な関数をまとめました。詳細な動作は各ファイルを参照してください。

### Core_Binds.ahk
`mbind_a`, `mbind_b`, `mbind_c`, `mbind_d`, `mbind_e`, `mbind_f`, `mbind_g`, `mbind_h`, `mbind_i`, `mbind_j`, `mbind_k`, `mbind_l`, `mbind_m`, `mbind_n`, `mbind_o`, `mbind_p`, `mbind_q`, `mbind_r`, `mbind_s`, `mbind_t`, `mbind_u`, `mbind_v`, `mbind_w`, `mbind_x`, `mbind_y`, `mbind_z`, `mbind_1`, `mbind_2`, `mbind_3`, `mbind_4`, `mbind_5`, `mbind_6`, `mbind_7`, `mbind_8`, `mbind_9`, `mbind_0`, `mbind_minus`, `mbind_equal`, `mbind_bracket_left`, `mbind_bracket_right`, `mbind_backslash`, `mbind_semicolon`, `mbind_quote`, `mbind_period`, `mbind_camma`, `mbind_slash`, `mbind_backspace`, `mbind_enter`, `mbind_delete`, `mbind_escape`, `mbind_tab`, `mbind_mlb`, `mbind_mrb`, `mbind_mmb`, `mbind_msblb`, `mbind_msblf`, `mbind_msbrb`, `mbind_msbrf`, `mbind_wheelup`, `mbind_wheeldown`, `mbind_space`

### Core_Mods.ahk
`LCMD`, `RCMD`, `CAPS`, `SHIFT`, `LSHIFT`, `RSHIFT`, `SPACE`, `ALT`, `RALT`, `LALT`, `MLB`, `MRB`, `MMB`, `MSBLB`, `MSBLF`, `MSBRF`, `MSBRB`

### IWA_Any.ahk
`MPC_intelliScroll`

### IWA_Excel.ahk
`iwa_xlsx_1`, `iwa_xlsx_2`, `iwa_xlsx_3`, `iwa_xlsx_4`, `iwa_xlsx_5`, `iwa_xlsx_tab`, `iwa_xlsx_q`, `iwa_xlsx_w`, `iwa_xlsx_e`, `iwa_xlsx_r`, `iwa_xlsx_t`, `iwa_xlsx_a`, `iwa_xlsx_d`, `iwa_xlsx_g`, `iwa_xlsx_z`, `iwa_xlsx_x`, `iwa_xlsx_c`, `iwa_xlsx_v`, `iwa_xlsx_b`, `iwa_xlsx_u`, `iwa_xlsx_h`, `iwa_xlsx_i`, `iwa_xlsx_j`, `iwa_xlsx_k`, `iwa_xlsx_l`, `iwa_xlsx_o`

### IWA_PowerPoint.ahk
`iwa_pptx_1`, `iwa_pptx_2`, `iwa_pptx_3`, `iwa_pptx_4`, `iwa_pptx_5`, `iwa_pptx_tab`, `iwa_pptx_q`, `iwa_pptx_w`, `iwa_pptx_e`, `iwa_pptx_r`, `iwa_pptx_t`, `iwa_pptx_a`, `iwa_pptx_s`, `iwa_pptx_d`, `iwa_pptx_f`, `iwa_pptx_g`, `iwa_pptx_z`, `iwa_pptx_x`, `iwa_pptx_c`, `iwa_pptx_v`, `iwa_pptx_b`

### Util_General.ahk
`activateWindow`, `press`, `directInput`, `setEnv`, `getEnv`, `execScripts`, `launch`, `splash`, `AHK_Reload`, `AHK_Exit`, `AHK_Suspend`, `AHK_Dashboard`, `resetMods`, `logger`, `philipsHue`, `philipsHueControlCT`, `philipsHueControlBRI`

### Util_Clip.ahk
`ClipExt_copy`, `ClipExt_cut`, `xorCrypt`, `ClipExt_Tcopy`, `UriEncode`, `ClipExt_Tpaste`, `JSONExtract`, `ClipExt_copyTo`, `ClipExt_pasteFrom`, `ClipExt_addAlias`, `ClipExt_openAlias`, `ClipExt_openLog`, `ClipLogGarbage`

### Util_IME.ahk
`IME_JP`, `IME_EN`, `IME_GET`, `IME_SET`, `IME_GetConvMode`, `IME_SetConvMode`, `IME_GetSentenceMode`, `IME_SetSentenceMode`, `IME_GetConverting`, `Get_Keyboard_Layout`, `Get_languege_id`, `Get_primary_language_identifier`, `Get_sublanguage_identifier`, `Get_languege_name`, `Get_ime_file`, `Get_Layout_Text`, `Get_reg_Keyboard_Layouts`

### Util_Macros.ahk
`MacroZ`, `MacroX`, `MacroBRL`, `MacroBRR`, `MacroSLS`, `MacroSMC`

### Util_Mouse.ahk
`ControlMouse`, `ControlMouseFast`, `mouseCursorResetToCenter`, `mousePress`, `intelliScroll`, `moveWindow`, `changeWindowSize`, `MouseMove_NWSE`

## ライセンス

本リポジトリには明示的なライセンス表記がありません。利用の際は作者に確認してください。

