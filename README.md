# Kitchotify
* URL
  * https://kitchotify-app.herokuapp.com/
* 詳細
  * https://qiita.com/kosamega/items/7e3e116ccba5069cdf86

## サービス概要
吉田音楽製作所からリリースされているアルバムをストリーミング配信するサービス。

## 本サービスを開発した背景
会員がそれぞれの曲を一度聴きあってそれっきりになっている。  
→会員が作った曲についてのコミュニケーションを活性化させたい。

オンラインでのサークル活動が主になり、閉じた場所でのコミュニケーションが減っている。  
→閉じた場でのコミュニケーションを活性化させたい。

## 主な機能
* ログイン機能
* 再生プレイヤー
* お気に入り
* プレイリスト
* 検索
* コメント
* イントロクイズ
* アルバム・曲の登録

## 使用技術
バックエンド
* Ruby 3.1.2
* Ruby on Rails 7.0.4

主要gem
* aws-sdk-s3
* gon
* acts_as_list

フロントエンド
* JavaScript
* Bootstrap 5.0.2
* Haml

インフラ
* Heroku
* PostgreSQL
* AmazonS3

## ER図
![kitchotify_erd](https://user-images.githubusercontent.com/104709001/211757592-035f5bac-efa7-4f40-9f18-8200110d0a59.png)