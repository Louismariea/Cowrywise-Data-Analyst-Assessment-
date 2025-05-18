-- Calculate average number of transactions per customer per month
-- Categorize frequency levels

WITH monthly_txn AS (
    SELECT 
        owner_id,
        DATE_FORMAT(created_on, '%Y-%m-01') AS txn_month,
        COUNT(*) AS txn_count
    FROM savings_savingsaccount
    GROUP BY owner_id, DATE_FORMAT(created_on, '%Y-%m-01')
),
avg_txn_per_cust AS (
    SELECT 
        owner_id,
        AVG(txn_count) AS avg_txn_per_month
    FROM monthly_txn
    GROUP BY owner_id
),
categorized AS (
    SELECT 
        CASE 
            WHEN avg_txn_per_month >= 10 THEN 'High Frequency'
            WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        COUNT(*) AS customer_count,
        ROUND(AVG(avg_txn_per_month), 1) AS avg_transactions_per_month
    FROM avg_txn_per_cust
    GROUP BY frequency_category
)

SELECT * FROM categorized;
