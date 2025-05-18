-- Identify plans with no savings activity in the last 365 days

SELECT 
    userplan.id AS plan_id,
    userplan.owner_id,
    CASE 
        WHEN userplan.is_a_fund = 1 THEN 'Investment'
        ELSE 'Savings'
    END AS type,
    (
        SELECT MAX(usersavings.created_on)
        FROM savings_savingsaccount usersavings
        WHERE usersavings.owner_id = userplan.owner_id
    ) AS last_transaction_date,
    DATEDIFF(
        CURRENT_DATE,
        (
            SELECT MAX(usersavings.created_on)
            FROM savings_savingsaccount usersavings
            WHERE usersavings.owner_id = userplan.owner_id
        )
    ) AS inactivity_days
FROM plans_plan userplan
WHERE userplan.amount > 0
  AND (
      SELECT MAX(usersavings.created_on)
      FROM savings_savingsaccount usersavings
      WHERE usersavings.owner_id = userplan.owner_id
  ) < DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY);
