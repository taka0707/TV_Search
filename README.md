# TV_SEARCH

## アプリケーション概要
- 自身のイベントを登録したり、検索したいワードでテレビ番組検索が行え、その結果（直近の10件 or その日から1週間分）をカレンダー(1週間表示)で自身のイベントと一緒に確認出来る

## URL
- https://tv-search27344.herokuapp.com/

## テスト用アカウント
- Basic認証
    - ユーザー名: admin
    - パスワード: 2222
- テストアカウント
    - name: taka
    - email: taka@taka
    - password: taka0707

## 利用方法
- 新規登録（name／email／password）またはログイン
- 画面上部の検索欄に検索ワードを入力し、検索ボタンを押す
- 検索結果（放送時間/放送局名/番組名）がカレンダー上に表示される
- 登録済のイベントがある場合は、検索結果画面に一緒に表示される※「start time」の背景色がユーザーのイベントと番組検索結果で違う仕様
- イベント作成画面より必要事項を入力(memoは未入力可)、saveボタンを押して登録
- カレンダー画面で登録したイベントが表示される
- 上記で表示されているイベントのタイトルのリンクから、イベントの編集画面に移行
- イベント編集画面より内容を編集し、saveボタンを押して更新 or saveボタン下の削除リンクよりイベント削除

## 目指した課題解決
- 普段あまりテレビを見ない人が、自分の興味がある関連の番組を見逃さないようにする為
- 取得したい最低限の情報に絞って、カレンダー上で自身のイベントと一緒に表示させる事により、自分の予定などとの比較のしやすさを実現

## 洗い出した要件
- ユーザー管理機能（新規登録/ログイン/ログアウト）
- カレンダー機能
- 番組検索機能
- イベント登録・表示・編集・削除機能

## 要件定義
[要件定義 .xlsx](https://github.com/taka0707/TV_Search/files/5082858/default.xlsx)

## ER図
![オリジナルアプリER図](https://user-images.githubusercontent.com/66991723/90371911-9b224d00-e0aa-11ea-938a-ea6042824405.png)

## 画面遷移図
![画面遷移図](https://user-images.githubusercontent.com/66991723/90372181-f05e5e80-e0aa-11ea-8423-0f3b5a3abd06.png)

## 実装した機能
- ユーザー管理機能（deviseを導入して実装）
- ユーザーのイベント登録・表示・編集・削除機能
- カレンダーにユーザーが登録したイベントを表示させる機能（simple_calendarを導入して実装）
- 上記の表示に番組検索結果を追加表示させる機能（simple_calendarを導入して実装）
- クローリングとスクレイピングで番組検索サイトから番組情報を取得する機能（nokogiriとmechanizeを導入して実装）

## 実装予定の機能

## 開発環境
- ruby 2.6.5
- Rails 6.0.3.2
- 導入したGem
    - devise
    - pry-rails
    - nokogiri
    - mechanize
    - chronic, ~> 0.10.2
    - simple_calendar, ~> 2.0
    - rails_12factor, productionのみ

## ローカルでの操作方法

#### ターミナル
```
% cd  #ホームディレクトリに移動
% cd 任意のディレクトリ #ディレクトリに移動
% git clone https://github.com/taka0707/TV_Search.git -b for_clone 
% cd TV_Search #TV_Searchディレクトリに移動
% bundle install
% rails db:create #データベースの作成
% rails db:migrate #マイグレーションの実行
```

## DB設計

### usersテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|password|password|null: false|

### Association
- has_many :tv_schedules

### eventsテーブル

|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|memo|string|
|start_time|datetime|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
