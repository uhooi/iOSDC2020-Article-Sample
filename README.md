# iOSDC2020-Article-Sample

[![CI](https://github.com/uhooi/iOSDC2020-Article-Sample/workflows/CI/badge.svg)](https://github.com/uhooi/iOSDC2020-Article-Sample/actions?query=workflow%3ACI)

## 概要

iOSDC 2020「GitHub ActionsでiOSアプリをCIする個人的ベストプラクティス」パンフレット記事のサンプルリポジトリです。

## CI

本リポジトリはGitHub ActionsでCIを実行しています。
READMEの上部にバッジを表示しているので、そこでCIの結果がわかり、クリックすることで詳細に飛べます。

フォークしても動作するので、フォーク後に `master` ブランチへプッシュして試してみてください。
GitHubにログインし、「Actions」タブからフォークしたリポジトリのアクション実行を許可する必要があります。

## 開発

誰でもこのプロジェクトの開発環境を構築してデバッグできます。

### 環境

このリポジトリの環境です。
多少バージョンが異なっても同様の動作になると思います。

- Xcode: 11.6
- Swift: 5.2.4
- rbenv: 1.1.2
- Bundler: 2.1.4
- Mint: 0.14.2

### 開発環境の構築

1. 以下をインストールします。

- [Xcode](https://apps.apple.com/jp/app/xcode/id497799835?mt=12)
- [rbenv](https://github.com/rbenv/rbenv)
- [Bundler](https://github.com/rubygems/bundler)
- [Mint](https://github.com/yonaskolb/Mint)

2. このプロジェクトをクローンします。

```
$ git clone https://github.com/uhooi/iOSDC2020-Article-Sample.git
$ cd iOSDC2020-Article-Sample
```

3. `make setup` を実行します。  
開発環境の構築が完了すると、自動でXcodeが起動してワークスペースを開きます。

### ヘルプ

`make help` を実行すると、ヘルプを出力します。

```
$ make help
setup                      開発環境の構築
install-bundler            Bundlerで管理しているライブラリのインストール
install-mint               Mintで管理しているライブラリのインストール
install-cocoapods          CocoaPodsで管理しているライブラリのインストールとワークスペースの生成
install-carthage           Carthageで管理しているライブラリのインストール
generate-xcodeproj         プロジェクトの生成
open                       ワークスペースをXcodeで開く
build-debug                デバッグビルド
test                       単体テスト
```

## おわりに

かなり頑張ってサンプルリポジトリを作ったので、スターください！
