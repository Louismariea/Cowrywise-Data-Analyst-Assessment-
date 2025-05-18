-- Calculate tenure, total transactions, and estimated CLV per customer in MySQL

WITH total_txns AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        SUM(amount) / 100.0 AS total_amount -- assuming 'amount' is the deposit column
    FROM savings_savingsaccount
    GROUP BY owner_id
),
tenure AS (
    SELECT 
        id AS customer_id,
        name,
        TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months
    FROM users_customuser
),
clv_data AS (
    SELECT 
        usertenure.customer_id,
        usertenure.name,
        usertenure.tenure_months,
        COALESCE(tx.total_transactions, 0) AS total_transactions,
        COALESCE(tx.total_amount * 0.001, 0) AS total_profit,
        CASE 
            WHEN usertenure.tenure_months > 0 THEN 
                ROUND((tx.total_transactions / usertenure.tenure_months) * 12 * (tx.total_amount * 0.001 / tx.total_transactions), 2)
            ELSE 0
        END AS estimated_clv
    FROM tenure usertenure
    LEFT JOIN total_txns tx ON usertenure.customer_id = tx.owner_id
)

SELECT customer_id, name, tenure_months, total_transactions, estimated_clv
FROM clv_data
ORDER BY estimated_clv DESC;
