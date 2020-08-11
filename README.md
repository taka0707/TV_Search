# TV_SEARCH

## アプリケーション概要
- 検索したいワードでテレビ番組検索が行え、その結果（直近の10件 or その日から1週間分）をカレンダー(1週間表示)で確認出来る

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

## 目指した課題解決
- 普段あまりテレビを見ない人が、自分の興味がある関連の番組を見逃さないようにする為
- 取得したい最低限の情報に絞って、カレンダーで表示させる事により、自分の予定などとの比較のしやすさを実現

## 洗い出した要件
- ユーザー管理機能（新規登録/ログイン/ログアウト）
- カレンダー機能
- 番組検索機能

## 実装した機能
- ユーザー管理機能（deviseを導入して実装）
- カレンダーに番組検索結果を表示させる機能（simple_calendarを導入して実装）
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

### tv_schedulesテーブル

|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|channel|string|null: false|
|start_time|datetime|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
