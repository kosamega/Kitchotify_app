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
![スクリーンショット 2023-01-27 162010](https://user-images.githubusercontent.com/104709001/221803659-cbca124a-69aa-4414-a485-ff86840d0d35.png)

## Kitchotify Search API
### アクセストークン
Kitchotifyが発行したSearch API TokenをAuthorizationリクエストヘッダに付与してください。

```
Authorization: Bearer xxxxxxxxxxxxxx
```

### ステータスコード
下記のコードを返却します
| ステータスコード | 説明 |
| ---- | ---- |
|200|リクエスト成功|
|400|不正なリクエストパラメータを指定している|
|401|API Tokenが不正|
|500|不明なエラー|

### 曲検索API
HTTPリクエスト
```
GET https://kitchotify-app.herokuapp.com/api/musics?name=(検索したい曲名）
```
リクエストパラメータ

| パラメータ | 内容 |
| ---- | ---- |
|name|検索したい曲名|

レスポンス例
```
GET https://kitchotify-app.herokuapp.com/api/musics?name=kamogawa
```
```
{
  "musics":[
    {
      "name":"Kamogawa Hallucination",
      "album":"月吉174号",
      "track":9,
      "artist":"kosamega",
      "url":"https://kitchotify-app.herokuapp.com/albums/4/musics/52"
    },
    {
      "name":"Kamogawa Somato",
      "album":"月吉177号",
      "track":4,
      "artist":"kosamega",
      "url":"https://kitchotify-app.herokuapp.com/albums/7/musics/119"
    }
  ]
}
```

### アルバム検索API
HTTPリクエスト
```
GET https://kitchotify-app.herokuapp.com/api/albums?name=(検索したいアルバム名）
```
リクエストパラメータ

| パラメータ | 内容 |
| ---- | ---- |
|name|検索したいアルバム名|

レスポンス例
```
GET https://kitchotify-app.herokuapp.com/api/albums?name=party
```
```
{
  "albums":[
    {
      "name":"kitchon party! vol.2",
      "kiki_taikai_date":"2022-09-24",
      "url":"https://kitchotify-app.herokuapp.com/albums/18",
      "musics":[
        {
          "name":"FAQ",
          "album":"kitchon party! vol.2",
          "track":1,
          "artist":"ボカロック部",
          "url":"https://kitchotify-app.herokuapp.com/albums/18/musics/273"
        },
        {
          "name":"一陽来復",
          "album":"kitchon party! vol.2",
          "track":2,"artist":"ベイビージャック",
          "url":"https://kitchotify-app.herokuapp.com/albums/18/musics/274"
        },
        {
          ……
        }
      ]
    },
    {
      "name":"kitchon party! ～combination​-​compilation～",
      "kiki_taikai_date":"2021-09-26",
      "url":"https://kitchotify-app.herokuapp.com/albums/11",
      "musics":[
        {
          "name":"消えたポラリス",
          "album":"kitchon party! ～combination​-​compilation～",
          "track":1,
          "artist":"ソニオル+一葉+なずしろ",
          "url":"https://kitchotify-app.herokuapp.com/albums/11/musics/110"
        },
        {
          ……
        }
      ]
    }
  ]
}
```

### アーティスト検索API
HTTPリクエスト
```
GET https://kitchotify-app.herokuapp.com/api/artists?name=(検索したいアーティスト名）
```
リクエストパラメータ

| パラメータ | 内容 |
| ---- | ---- |
|name|検索したいアーティスト名|

レスポンス例
```
GET https://kitchotify-app.herokuapp.com/api/artists?name=same
```
```
{
  "artists":[
    {
      "name":"kosamega",
      "bio":"make光のmusic",
      "url":"https://kitchotify-app.herokuapp.com/artists/17",
      "musics":[
        {
          "name":"急げ！！！",
          "album":"月吉186号",
          "track":17,
          "artist":"kosamega",
          "url":"https://kitchotify-app.herokuapp.com/albums/36/musics/328"
        },
        {
          "name":"Hikari_to_Kaze",
          "album":"月吉182号",
          "track":1,
          "artist":"kosamega",
          "url":"https://kitchotify-app.herokuapp.com/albums/14/musics/225"
        },
        {
          "name":"No going through",
          "album":"月吉180号",
          "track":24,
          "artist":"kosamega",
          "url":"https://kitchotify-app.herokuapp.com/albums/10/musics/213"
        },
        {
          ……
        }
      ]
    }
  ]
}
```

## Kitchotify Create API
### アクセストークン
Kitchotifyが発行したCreate API TokenをAuthorizationリクエストヘッダに付与してください。

```
Authorization: Bearer xxxxxxxxxxxxxx
```

### ステータスコード
下記のコードを返却します
| ステータスコード | 説明 |
| ---- | ---- |
|200|リクエスト成功|
|400|不正なリクエストパラメータを指定している|
|401|API Tokenが不正|
|409|作成に失敗|
|500|不明なエラー|

### アルバム作成API
HTTPリクエスト
```
POST https://kitchotify-app.herokuapp.com/api/albums?name=(作成したいアルバム名)&kiki_taikai_date=(聴き大会開催日)
```
リクエストパラメータ

| パラメータ | 内容 |
| ---- | ---- |
|name|作成したいアルバム名|
|kiki_taikai_date|聴き大会開催日|

レスポンス例
```
POST https://kitchotify-app.herokuapp.com/api/albums?name=test_album&kiki_taikai_date=2099-01-01
```
```
{
  "album":{
    "name": "test_album",
    "kiki_taikai_date": "2099-01-01",
    "form_url": "https://kitchotify-app.herokuapp.com/albums/38/musics/new"
  }
}
```
## ライセンス
このソフトウェアはMITライセンスのもとで公開されています。詳しくはLICENSE.txtをご覧ください。
