-- Identify customers with both savings and investment plans that are funded
-- Count how many of each and sum their deposits

SELECT 
    users.id AS owner_id,
    users.name,
    COUNT(DISTINCT usersavings.id) AS savings_count,
    COUNT(DISTINCT userplan.id) AS investment_count,
    ROUND(SUM(usersavings.amount) / 100.0, 2) AS total_deposits
FROM users_customuser users
JOIN savings_savingsaccount usersavings ON users.id = usersavings.owner_id
JOIN plans_plan userplan ON users.id = userplan.owner_id
WHERE usersavings.amount > 0
  AND userplan.is_a_fund = 1
  AND userplan.amount > 0
GROUP BY users.id, users.name
HAVING COUNT(DISTINCT usersavings.id) >= 1 AND COUNT(DISTINCT userplan.id) >= 1
ORDER BY total_deposits DESC;
