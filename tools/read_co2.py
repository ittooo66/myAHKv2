# Need `pip3 install hidapi co2meter`
# https://qiita.com/akeome/items/997d2f2bd9aea538857e

import co2meter as co2
import os
import re

# 現在のスクリプトのパスを基準にする
script_dir = os.path.dirname(os.path.abspath(__file__))

# env.yaml へのパスを構築
yaml_path = os.path.abspath(os.path.join(script_dir, '..', 'env', 'env.yaml'))

# CO2データを取得
mon = co2.CO2monitor()
data = mon.read_data()
co2_value = data[1]

# YAMLファイルの内容を読み込む
with open(yaml_path, 'r', encoding='utf-8') as file:
    content = file.read()

# CO2 の行を正規表現で置き換える
new_content = re.sub(r"^(CO2:\s*)['\"]?\d+['\"]?", f"\\1'{co2_value}'", content, flags=re.MULTILINE)

# 変更後の内容を書き戻す
with open(yaml_path, 'w', encoding='utf-8') as file:
    file.write(new_content)