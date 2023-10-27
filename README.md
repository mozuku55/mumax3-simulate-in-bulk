# mumax3の一括実行
## 機能
- 単体または複数のPbitにおける磁気シミュレーションを複数ディレクトリ単位で実行してくれます
- また、一時停止後に再度実行する等の場合には計算済の条件をスキップもしてくれるので放置しやすくかつ効率的にシミュレートできます

## How to Use ?
### 初期設定
- Docker上で動かすための用意
- 前提
    - docker daemonが使える状況にある

- docker serviceを開始して当階層でimageをbuildしてください
- 下記コードでは`mumax3v3`がimage名であり、任意に設定可能です
~~~sh
service docker start
docker build image -t mumax3 .
~~~
### 計算実行方法
- シミュレートしたいフォルダたちをまとめたディレクトリを指定して以下を実行してください
- 計算結果はoutputに指定したディレクトリ内の各フォルダに格納されます
~~~sh
docker run -d  --gpus all --rm -v /path/to/input:/mumax_input -v /path/to/output:/mumax_output mumax3:latest /bin/bash -c "cd /mumax3 && ./run_mumax.sh"
~~~

## その他仕様
- 計算実行中にinputディレクトリに新規ディレクトリを追加しても計算してくれます
- ディレクトリ中に計算済のmx3ファイルが存在する場合(正確には***.outディレクトリが存在する場合)には対象ファイルの計算はスキップされます
    - 計算を中断した場合、計算中だったmx3ファイルに対応する***.outフォルダに計算途中のデータが残ってしまっていますので、再開する際に当条件での計算を再び行うために該当する.outフォルダを削除してください
