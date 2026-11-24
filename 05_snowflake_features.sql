-- ============================================================
-- 演習5: Snowflake らしさ — Time Travel と Zero-Copy Clone
-- 目的: 過去の状態に戻れることと、一瞬でコピーを作れることを体験する
-- 前提: 01_basics.sql を実行済みで、orders テーブルが存在すること
-- ============================================================

USE WAREHOUSE handson_wh;
USE DATABASE handson_db;
USE SCHEMA lab;

-- まず現在の orders を確認
SELECT * FROM orders ORDER BY order_id;

-- 更新前の時刻を控えておく（Time Travel の基準点）
SET before_update_ts = (SELECT CURRENT_TIMESTAMP());

-- 間違えた想定で、全件の単価を書き換えてしまう
UPDATE orders SET unit_price = 0;

SELECT * FROM orders ORDER BY order_id;  -- 金額が 0 になっている

-- Time Travel: 控えておいた時刻時点の状態を参照する
SELECT * FROM orders AT (TIMESTAMP => $before_update_ts) ORDER BY order_id;

-- 過去の状態から、復旧用テーブルを作る
CREATE OR REPLACE TABLE orders_restored AS
SELECT * FROM orders AT (TIMESTAMP => $before_update_ts);

SELECT * FROM orders_restored ORDER BY order_id;  -- 元の金額に戻っていることを確認

-- 実務ではこの後、内容を確認してから orders と入れ替える運用にします

-- Zero-Copy Clone: ストレージを複製せずにコピーを作る
CREATE OR REPLACE TABLE orders_backup CLONE orders;

SELECT COUNT(*) FROM orders_backup;

-- ============================================================
-- チャレンジ: 消したテーブルを戻す（UNDROP）
-- まず予測してください: DROP したテーブルは戻せると思いますか？
-- ============================================================

DROP TABLE orders_backup;

-- 消えたことを確認
SHOW TABLES LIKE 'orders_backup';

-- 戻してみる
UNDROP TABLE orders_backup;

SELECT COUNT(*) FROM orders_backup;  -- 5件戻っていれば成功

-- ============================================================
-- 考察（ワークシートに書いてください）
-- - Time Travel と UNDROP は、どちらも「間違いからの復旧」ですが、
--   対象がどう違いますか？
-- - CLONE と通常のコピー（CREATE TABLE AS SELECT）の使い分けは
--   docs/04_解説_TimeTravelとClone.md を読んで考えてみてください
-- ============================================================
