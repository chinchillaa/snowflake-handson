-- ============================================================
-- 演習4: JSON（半構造化データ）を読む
-- 目的: JSON を VARIANT 列に格納し、SQL で中身を取り出す
-- 確認ポイント:
--   - payload:キー でアクセスし、::型 でキャストするのが基本形
--   - キーがない行は NULL になる（スキーマが固定でなくても扱える）
-- ============================================================

USE WAREHOUSE handson_wh;
USE DATABASE handson_db;
USE SCHEMA lab;

CREATE OR REPLACE TABLE events (payload VARIANT);

INSERT INTO events
SELECT PARSE_JSON(column1)
FROM VALUES
  ('{"user":"tanaka","action":"login","device":"pc"}'),
  ('{"user":"suzuki","action":"purchase","device":"mobile","amount":3000}'),
  ('{"user":"tanaka","action":"logout","device":"pc"}');

-- JSON の中身を取り出す
SELECT
  payload:user::VARCHAR   AS user_name,
  payload:action::VARCHAR AS action,
  payload:device::VARCHAR AS device,
  payload:amount::NUMBER  AS amount
FROM events;
