# Need `pip3 install hidapi co2meter`
# https://qiita.com/akeome/items/997d2f2bd9aea538857e

import co2meter as co2
import os
import yaml

# 現在のスクリプトのパスを基準にする
script_dir = os.path.dirname(os.path.abspath(__file__))

# env.yaml へのパスを構築
yaml_path = os.path.abspath(os.path.join(script_dir, '..', 'env', 'env.yaml'))

# CO2データを取得
mon = co2.CO2monitor()
data = mon.read_data()
co2_value = data[1]

# YAMLファイルを読み込む
with open(yaml_path, 'r', encoding='shift-jis') as file:
    yaml_data = yaml.safe_load(file)

# CO2の値を更新
yaml_data['CO2'] = co2_value

# YAMLファイルを書き戻す
with open(yaml_path, 'w', encoding='shift-jis') as file:
    yaml.safe_dump(yaml_data, file, allow_unicode=True)