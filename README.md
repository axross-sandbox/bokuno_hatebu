# 僕のはてブ【Web技術版】

![bokuno_hatebu](http://cdn-ak.f.st-hatena.com/images/fotolife/a/axross/20140201/20140201235220.png)

僕のはてブ【Web技術版】は、[@axross](http://twitter.com/axross_k)が欲しい情報をはてなブックマークをクロールして集めるキュレーションWebアプリケーションです。

> **僕のはてブ【Web技術版】**
> [http://hatebu.axross.org](http://hatebu.axross.org)

よかったら[ブックマーク](javascript:(function(){var%20d=(new%20Date);var%20s=document.createElement('script');s.charset='UTF-8';s.src='http://b.hatena.ne.jp/js/Hatena/Bookmark/let.js?'+d.getFullYear()+d.getMonth()+d.getDate();(document.getElementsByTagName('head')[0]||document.body).appendChild(s);})();)して下さい。

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

```sh
bundle install
```

必要なGemをインストールします。

### データベースファイルの生成

```sh
rake init
```

Rakeタスクでデータベースファイルを生成します。

### クローラーを動かす

```sh
rake crawl[100]
```

Rakeタスクでクロールします。
数字を変えると取得する件数を変更できます。
1000件くらいまでは可能なことを確認していますが、あまり大きすぎる値ははてなさんに迷惑なのでやめましょう。

このRakeタスクをcronに登録するなどすれば、一定周期で情報を集め続けることができます。

### Webサーバーの起動

```sh
ruby app.rb
```

WebサーバーはSinatraで動きます。

### 完了！

have fun!
