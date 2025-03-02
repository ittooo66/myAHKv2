# Need `pip3 install hidapi co2meter`
# https://qiita.com/akeome/items/997d2f2bd9aea538857e

import co2meter as co2
import os

# CO2.txtの出力先ディレクトリを指定
file_path = r"C:\Users\ittoo\OneDrive\Backups\SRC\ahkv2\Env\CO2.txt"

# CO2データを読み取る
mon = co2.CO2monitor()
data = mon.read_data()

# CO2値（データの2番目の値）を取得
co2_value = data[1]

# CO2値をファイルに出力する
with open(file_path, "w", encoding="utf-8") as file:
    file.write(str(co2_value))
