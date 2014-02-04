# 僕のはてブ【Web技術版】

![bokuno_hatebu](http://cdn-ak.f.st-hatena.com/images/fotolife/a/axross/20140201/20140201235220.png)

僕のはてブ【Web技術版】は、[@axross](http://twitter.com/axross_k)が欲しい情報をはてなブックマークをクロールして集めるキュレーションWebアプリケーションです。

> **僕のはてブ【Web技術版】**  
> [http://hatebu.axross.org](http://hatebu.axross.org)

よかったら[ブックマーク](http://b.hatena.ne.jp/entry/s/github.com/axross/bokuno_hatebu)して下さい。

## スマホにも対応

![bokuno_hatebu_sp](http://cdn-ak.f.st-hatena.com/images/fotolife/a/axross/20140202/20140202001627.png)

スマートフォンにも対応しています。  
最適化されたビューで快適に閲覧できます。

## 使い方

1. bundle install
2. データベースファイルの生成
3. クローラーを動かす
4. Webサーバーの起動

### bundle install

```
bundle install
```

必要なGemをインストールします。

### データベースファイルの生成

```
rake init
```

Rakeタスクでデータベースファイルを生成します。

### クローラーを動かす

```
rake crawl[100]
```

Rakeタスクでクロールします。  
数字を変えると取得する件数を変更できます。  
1000件くらいまでは可能なことを確認していますが、あまり大きすぎる値ははてなさんに迷惑なのでやめましょう。

このRakeタスクをcronに登録するなどすれば、一定周期で情報を集め続けることができます。

### Webサーバーの起動

```sh
rackup -p 4567
```

WebサーバーはSinatraで動きます。

### 完了！

上記の動かし方であれば[http://localhost:4567](http://localhost:4567)から閲覧できます。  
have fun!
