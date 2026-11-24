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

-- ============================================================
-- チャレンジ（自分で書いてみましょう）
-- 解答例は docs/06_クイズと解答.md にあります。
--
-- 課題1: action ごとの件数を表示する
--        （期待値: login / purchase / logout が各1件）
-- 課題2: amount の合計を表示する
--        （期待値: 3,000。amount が無い行はどう扱われるか、
--         実行前に予測してから実行すること）
-- ============================================================

-- 課題1をここに書く


-- 課題2をここに書く

