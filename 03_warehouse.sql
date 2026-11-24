-- ============================================================
-- 演習3: ウェアハウスのサイズとコスト
-- 目的: サイズを変えると実行時間と消費クレジットがどう変わるか体感する
-- 確認ポイント:
--   - サイズ2倍 ≒ 消費クレジット/時もおおむね2倍
--     （目安: XSMALL = 1クレジット/時、SMALL = 2クレジット/時）
--   - サイズを上げたら必ず元に戻すこと
-- ============================================================

USE DATABASE handson_db;
USE SCHEMA lab;

-- 現在のウェアハウス設定を確認
SHOW WAREHOUSES LIKE 'handson_wh';

-- 重めの集計（サンプルデータ全体の集計）
USE WAREHOUSE handson_wh;
SELECT
  l_returnflag,
  l_linestatus,
  COUNT(*)             AS cnt,
  SUM(l_extendedprice) AS total_price
FROM snowflake_sample_data.tpch_sf1.lineitem
GROUP BY l_returnflag, l_linestatus
ORDER BY l_returnflag, l_linestatus;

-- サイズを SMALL に上げて、同じクエリをもう一度実行する
ALTER WAREHOUSE handson_wh SET WAREHOUSE_SIZE = 'SMALL';

SELECT
  l_returnflag,
  l_linestatus,
  COUNT(*)             AS cnt,
  SUM(l_extendedprice) AS total_price
FROM snowflake_sample_data.tpch_sf1.lineitem
GROUP BY l_returnflag, l_linestatus
ORDER BY l_returnflag, l_linestatus;

-- 終わったら必ず XSMALL に戻す
ALTER WAREHOUSE handson_wh SET WAREHOUSE_SIZE = 'XSMALL';

-- ============================================================
-- 考察（SQLではありません。ワークシートに書いてください）
--
-- 1. XSMALL と SMALL で実行時間はどれくらい変わりましたか？
-- 2. SMALL はクレジット単価が XSMALL の2倍です。「2倍払って、
--    どれくらい速くなれば割に合う」と思いますか？
-- 3. 2回目の実行が思ったより速かった場合、結果キャッシュ
--    （同じクエリの結果を再利用する仕組み）の影響も考えられます。
--    キャッシュを疑うには、クエリを少し変えて実行すると
--    どうなるでしょうか？
-- 背景知識: docs/01_解説_ウェアハウスとクレジット.md
-- ============================================================
