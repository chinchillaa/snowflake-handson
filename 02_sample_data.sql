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

-- ============================================================
-- チャレンジ（自分で書いてみましょう）
--
-- 課題1: orders テーブルについて、1998年1月〜12月の「月ごと」の
--        注文件数を表示する（ヒント: 日付から月を取り出すには
--        DATE_TRUNC('MONTH', o_orderdate) が使える）
-- 課題2: 同じ集計を、WHERE で 1998 年に絞った場合と絞らない場合で
--        実行時間を比べ、ワークシートに記録する。
--        「なぜ速さが変わるのか」を docs/02_解説_SQLの基本.md の
--        プルーニングの説明と結びつけて考えてみること
-- ============================================================

-- 課題1をここに書く

