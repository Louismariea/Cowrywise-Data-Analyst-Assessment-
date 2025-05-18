# Cowrywise-Data-Analyst-Assessment-

# Data Analytics SQL Assessment

This repository contains SQL solutions to a four-question assessment that evaluates SQL proficiency, business logic understanding, and ability to derive insights from relational data.

## ✅ Assessment Overview

Tables involved:
- `users_customuser`: Customer demographics and signup data
- `savings_savingsaccount`: Deposit transactions
- `plans_plan`: Investment and savings plans
- `withdrawals_withdrawal`: Withdrawal records (not used in this round)

Each SQL script corresponds to a question, stored in its respective file.
---

### Q1: High-Value Customers with Multiple Products

**Objective**: Identify customers with both a savings and an investment plan and rank them by total deposit value.

**Approach**:
- Join `users_customuser`, `savings_savingsaccount`, and `plans_plan`
- Filter for users with confirmed savings and investment plans
- Group and aggregate data
- Sort by total deposits (converted from kobo to naira)

---

### Q2: Transaction Frequency Analysis

**Objective**: Categorize customers into frequency tiers based on average monthly transactions.

**Approach**:
- Aggregate monthly transaction counts per user
- Calculate the average across months
- Use `CASE` logic to categorize
- Final result shows frequency category, count of customers, and average

---

### Q3: Account Inactivity Alert

**Objective**: Identify active accounts with no inflow in the last 365 days.

**Approach**:
- Join `plans_plan` and `savings_savingsaccount`
- Filter out deleted or inactive accounts
- Use `MAX(transaction_date)` to find last inflow
- Calculate inactivity days and filter based on the 365-day threshold

---

### Q4: Customer Lifetime Value (CLV)

**Objective**: Estimate customer CLV based on tenure and transaction history.
- Calculate Customer Tenure
- Aggregate Transaction Data
- Estimate Profit
- Calculate Estimated CLV
- Compile Final Results
