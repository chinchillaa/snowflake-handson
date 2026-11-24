-- ============================================================
-- 演習1: SQL の基本
-- 目的: テーブル作成、データ投入、検索と集計の一連の流れを確認する
-- ============================================================

USE WAREHOUSE handson_wh;
USE DATABASE handson_db;
USE SCHEMA lab;

CREATE OR REPLACE TABLE orders (
  order_id     NUMBER,
  customer     VARCHAR,
  product      VARCHAR,
  quantity     NUMBER,
  unit_price   NUMBER,
  ordered_at   DATE
);

INSERT INTO orders VALUES
  (1, '田中', 'ノートPC',     1, 120000, '2026-11-01'),
  (2, '鈴木', 'マウス',       3,   3000, '2026-11-01'),
  (3, '田中', 'モニタ',       2,  35000, '2026-11-02'),
  (4, '佐藤', 'キーボード',   1,   8000, '2026-11-03'),
  (5, '鈴木', 'ノートPC',     1, 120000, '2026-11-03');

-- 全件確認
SELECT * FROM orders ORDER BY order_id;

-- 売上（数量 × 単価）を計算する
SELECT
  order_id,
  customer,
  product,
  quantity * unit_price AS amount
FROM orders
ORDER BY amount DESC;

-- 顧客ごとの売上集計
SELECT
  customer,
  COUNT(*)                   AS order_count,
  SUM(quantity * unit_price) AS total_amount
FROM orders
GROUP BY customer
ORDER BY total_amount DESC;

-- ============================================================
-- チャレンジ（答えのSQLは用意されていません。自分で書いてみましょう）
-- 詰まったら、上のクエリを書き換えるところから始めてください。
-- 解答例は docs/06_クイズと解答.md にあります。
--
-- 課題1: 商品ごとの売上合計を、売上の大きい順に表示する
--        （期待値: 1位はノートPCで 240,000）
-- 課題2: 2026-11-03 の注文件数と売上合計を表示する
--        （期待値: 2件 / 128,000）
-- 課題3: 売上合計が 100,000 以上の顧客だけを表示する
--        （ヒント: 集計「後」の絞り込みは WHERE ではなく HAVING を使う。
--         理由は docs/02_解説_SQLの基本.md を参照）
-- ============================================================

-- 課題1をここに書く


-- 課題2をここに書く


-- 課題3をここに書く

