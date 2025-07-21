# Need `pip3 install hidapi co2meter`
# https://qiita.com/akeome/items/997d2f2bd9aea538857e

import co2meter as co2
import os

# 現在のスクリプトのパスを基準にする
script_dir = os.path.dirname(os.path.abspath(__file__))

# Env/CO2.txt への相対パスを結合
file_path = os.path.abspath(os.path.join(script_dir, '..', '..', 'Env', 'CO2.txt'))

# CO2データを読み取る
mon = co2.CO2monitor()
data = mon.read_data()

# CO2値（データの2番目の値）を取得
co2_value = data[1]

# CO2値をファイルに出力する
with open(file_path, "w", encoding="utf-8") as file:
    file.write(str(co2_value))
