## Dockerコンテナへの反映方法
SSH Agentにソケット通信使うことで、本レポジトリがprivateでもコンテナからセキュアにクローンできるようにする。
1. Dockerコンテナを立ち上げる。
わざわざDockerボリュームを作る必要ないので、バインドマウントでOK
- SSH Agentのソケットをマウント、環境変数に設定する
- setupスクリプトをマウントする
```
docker run -it --rm \
  -v $SSH_AUTH_SOCK:/ssh-agent \
  -e SSH_AUTH_SOCK=/ssh-agent \
  -v $HOME/setup:/setup \
  ubuntu:22.04 bash
```

2. コンテナ内で最低限必要なツールをインストール
```
apt-get update && apt-get install -y curl sudo openssh-client
```

3. ssh接続を確かめる
飛ばして4でもいいが、途中のfingerprintの質問でyesと答えなければならない
```
ssh -T git@github.com
```

4. setupファイルに実行権限与えて実行する
```
chmod +x /setup
/setup
```

5. zshコマンドで立ち上げる

## chezmoiフォルダ変更のやり方
ローカルに今の環境を反映させたら、あまりchezmoiと同期することを意識しすぎるのではなく、ある程度まとまった時間が取れたときにdotfileのchezmoi管理をまとめていくスタイル。  
chezmoi editコマンドはtmplを使っている場合は、tmplとは別にdotfileがchezmoiフォルダ内に作成されてしまうので使用しない。

- ローカル固有の設定
~/.zshrc.localを編集  
ローカル環境特有の環境変数など  
たまにchezmoi diffコマンドで、ローカルに移したほうがよい設定を移していく  

- 軽い修正
chezmoiフォルダ内のdotfileを変更して、chezmoi applyを実行  
chezmoi diffでローカルとぶつからないか確認

- ローカルで実験などのために修正→chezmoi
chezmoi diffで差分を確認して、chezmoiフォルダ内のファイルも手動で変更して、chezmoi diffの差分をなくしていく

## 本レポジトリの使用ツール
"chezmoi + mise"
外部パッケージの管理方法はchezmoiexternal.tomlを用いる方法とmiseを用いる方法の２つがあるが、miseのほうが簡潔でgithubのversion非依存  
miseで管理できないものについてchezmoiexternal.tomlで管理する方針  
Python等のコンテナごとにversionを変更したいものはmiseに登録しない

### chezmoi
- 複数マシンでの一貫した環境管理が可能。
シェルスクリプトだと、ローカルとの差分を見ながら開発することが難しい。
- 設定ファイルの一元管理
- 設定ファイルの継続的な同期
- 差分確認

### mise
外部パッケージを楽に管理できる
- クロスプラットフォーム対応
- versionをmise outdated, upgradeで管理可能

## 各ファイル
- run_onchange_after_install_packages.sh.tmpl  
miseのtrustを実行 + config.tomlの更新(ハッシュ値変更)を検知することでスクリプトを再実行させる

- binフォルダ内のexecutableファイル  
自分特性シェルスクリプト関数を保存

- lazyvim(options.lua)、lazygit  
lazyvimはローカルでファイルの中身を見たりするときに便利なので導入
lazygitは過剰であまり役に立たないので入れない
lazygitは初回の起動でインストールに時間かかるので、コンテナでは使用しない

- dot_tmux.conf  
tmux設定ファイル作成したから入っているけど、tmux使用しない
