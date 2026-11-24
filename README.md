# snowflake-handson

Snowflake 初学者ハンズオンセミナー用の演習リポジトリです。
各自の無料トライアルアカウントで、Snowsight の Workspaces からこのリポジトリを取り込み、番号順に SQL ファイルを実行して進めます。

## 進め方

### 0. 事前準備

1. Snowflake の無料トライアルアカウントを発行し、ログインできる状態にしておく
   - Edition: Enterprise / Cloud: AWS / Region: Asia Pacific (Tokyo)
   - 申込: https://signup.snowflake.com/
2. 初回ログイン時に多要素認証（MFA）の設定を求められたら、画面の指示に従って設定する

### 1. Git 連携の準備（最初の1回だけ）

このリポジトリを Workspaces に取り込む前に、通常のワークシートで API Integration を1回だけ作成します。
資料（第3章 手順A）の SQL を実行してください。テンプレートは `git/00_api_integration.sql` にも置いてありますが、**このファイル自体はワークスペースを取り込むまで開けない**ため、当日は資料またはこの README の下記スニペットからコピーして実行してください。

```sql
USE ROLE ACCOUNTADMIN;

CREATE OR REPLACE API INTEGRATION handson_git_api
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/chinchillaa/snowflake-handson')
  ENABLED = TRUE;
```

対象はこのリポジトリ（chinchillaa/snowflake-handson）です。

### 2. ワークスペースの作成

1. Snowsight で **Projects » Workspaces** を開く
2. **From Git repository** を選び、このリポジトリの URL を貼り付ける
3. API Integration に `handson_git_api` を選ぶ
4. ファイル一覧が表示されれば取り込み完了

### 3. 演習ファイル（番号順に実行）

| ファイル | 内容 |
|---|---|
| `00_setup.sql` | ウェアハウス / データベース / スキーマの作成 |
| `01_basics.sql` | テーブル作成、INSERT、SELECT、集計の基本 |
| `02_sample_data.sql` | サンプルデータ（TPC-H）で大きなデータを検索する |
| `03_warehouse.sql` | ウェアハウスのサイズ変更とコストの体感 |
| `04_semistructured.sql` | JSON（VARIANT）の格納と取り出し |
| `05_snowflake_features.sql` | Time Travel と Zero-Copy Clone |
| `99_cleanup.sql` | 後片付け（任意） |

各ファイルは単独で開いて上から順に実行できるよう、冒頭でコンテキスト（ウェアハウス／データベース／スキーマ）を設定しています。

演習は「予測 → 実行 → 観察 → 考察」の流れで進めます。各演習 SQL の末尾には、答えが用意されていない**チャレンジ課題**（自分で SQL を書く課題）があります。

### 解説資料（docs/）

| ファイル | 内容 |
|---|---|
| `docs/00_学び方.md` | 予測→実行→観察→考察の進め方、つまずいたときの確認順序 |
| `docs/01_解説_ウェアハウスとクレジット.md` | ウェアハウス、クレジット計算、Auto Suspend の仕組み |
| `docs/02_解説_SQLの基本.md` | SELECT の処理順序、プルーニング、COUNT が速い理由 |
| `docs/03_解説_半構造化データ.md` | VARIANT と JSON の取り出し方、注意点 |
| `docs/04_解説_TimeTravelとClone.md` | Time Travel / UNDROP / Zero-Copy Clone の仕組みと使い分け |
| `docs/05_ワークシート.md` | 演習ごとの予測・観察・考察を書き込むシート |
| `docs/06_クイズと解答.md` | 確認クイズと、チャレンジ課題の解答例・期待値（講師用／復習用） |

## 注意

- このリポジトリの SQL は学習用です。**実データ（会社の機密データ、顧客データ、個人情報）をトライアルアカウントに入力しないでください**
- 参加者ごとにアカウントは独立しています。他の参加者のデータが見えることはありません
- 本リポジトリへの Push はセミナー中は行いません（読み取り専用で使います）

## 講師向けメモ

- 空リポジトリでは Workspaces の Git 連携ができないため、必ず `main` ブランチに本ファイル群が入った状態で公開してください
- 第1回は公開リポジトリ（読み取りのみ）を推奨します。Private リポジトリにする場合は OAuth2 または Personal Access Token（Secret 登録）の追加手順が必要になります
- リポジトリを更新したら、参加者には Workspaces で **Pull** してもらえば反映されます
