-- ============================================================
-- Git 連携準備: API Integration の作成（最初の1回だけ）
-- 実行場所: 通常のワークシート（Workspaces を作る前に実行する）
-- 対象リポジトリ: chinchillaa/snowflake-handson
-- ============================================================

USE ROLE ACCOUNTADMIN;

CREATE OR REPLACE API INTEGRATION handson_git_api
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/chinchillaa/snowflake-handson')
  ENABLED = TRUE;

-- 作成できたか確認
SHOW API INTEGRATIONS LIKE 'handson_git_api';
