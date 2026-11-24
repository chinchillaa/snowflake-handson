-- ============================================================
-- 後片付け（任意）
-- セミナー終了後に実行する。
-- トライアル期間中に自分で続きを試したい場合は実行しなくてよい。
-- ============================================================

USE ROLE ACCOUNTADMIN;

DROP DATABASE IF EXISTS handson_db;
DROP WAREHOUSE IF EXISTS handson_wh;

-- API INTEGRATION（handson_git_api）は再利用できるため、
-- 残しておいて問題ありません。削除する場合のみ以下を実行してください。
-- DROP API INTEGRATION IF EXISTS handson_git_api;
