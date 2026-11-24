-- ============================================================
-- 演習2: サンプルデータで「大きなデータ」を触る
-- 目的: Snowflake が用意するサンプルデータで大きなテーブルへの
--       検索を体験する
-- 確認ポイント:
--   - SNOWFLAKE_SAMPLE_DATA は読み取り専用の共有データで、
--     ストレージ料金はかからない（かかるのは検索時のクレジットだけ）
--   - 必要な列だけを選ぶことが高速化とコスト削減の基本
-- ============================================================

USE WAREHOUSE handson_wh;

-- サンプルデータベースは最初からアカウントに入っている
SELECT COUNT(*) AS cnt
FROM snowflake_sample_data.tpch_sf1.orders;

-- 注文ステータスごとの件数と合計金額
SELECT
  o_orderstatus,
  COUNT(*)          AS order_count,
  SUM(o_totalprice) AS total_price
FROM snowflake_sample_data.tpch_sf1.orders
GROUP BY o_orderstatus
ORDER BY total_price DESC;

-- 日付で絞り込む
SELECT
  o_orderdate,
  COUNT(*) AS order_count
FROM snowflake_sample_data.tpch_sf1.orders
WHERE o_orderdate >= '1998-01-01'
GROUP BY o_orderdate
ORDER BY o_orderdate
LIMIT 20;
