# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# TV_SEARCHER

## アプリケーション概要
- 検索したいワードと、ジャンルを指定してテレビ番組検索が行え、その結果が一週間単位で確認出来る

## URL

## テスト用アカウント

## 利用方法

## 目指した課題解決

## 洗い出した要件

## 実装した機能

## 実装予定の機能

## ローカルでの操作方法

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
