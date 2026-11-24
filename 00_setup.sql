-- ============================================================
-- 演習0: セットアップ
-- 目的: ウェアハウス / データベース / スキーマを作成する
-- 確認ポイント:
--   - AUTO_SUSPEND = 60 がコスト管理の最重要設定であること
--   - ウェアハウスは「動いている間だけ」クレジットを消費すること
-- ============================================================

USE ROLE ACCOUNTADMIN;

-- ウェアハウス: XSMALL、60秒使われなければ自動停止、使うときは自動再開
CREATE OR REPLACE WAREHOUSE handson_wh
  WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

CREATE OR REPLACE DATABASE handson_db;
CREATE OR REPLACE SCHEMA handson_db.lab;

USE WAREHOUSE handson_wh;
USE DATABASE handson_db;
USE SCHEMA lab;

-- 作成されたことを確認
SHOW WAREHOUSES LIKE 'handson_wh';
SHOW DATABASES LIKE 'handson_db';
