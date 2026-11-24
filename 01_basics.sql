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
