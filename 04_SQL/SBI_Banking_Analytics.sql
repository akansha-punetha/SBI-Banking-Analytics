CREATE DATABASE sbi_banking_analytics;
USE SBI_Banking_Analytics;

-- 1. Distribution of Customers Across Cities

SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

-- 2. Unique Account Types

SELECT DISTINCT account_type
FROM accounts;

-- 3. Distribution of Accounts by Type

SELECT
    account_type,
    COUNT(*) AS total_accounts
FROM accounts
GROUP BY account_type
ORDER BY total_accounts DESC;

-- 4. Total Deposit by Account Type

SELECT
    account_type,
    ROUND(SUM(balance_inr),2) AS total_deposit
FROM accounts
GROUP BY account_type
ORDER BY total_deposit DESC;

-- 5. Average Balance by Account Type

SELECT
    account_type,
    ROUND(AVG(balance_inr),2) AS average_balance
FROM accounts
GROUP BY account_type
ORDER BY average_balance DESC;

-- 6. Top 10 Customers with Highest Balance

SELECT
    customer_id,
    account_type,
    balance_inr
FROM accounts
ORDER BY balance_inr DESC
LIMIT 10;

-- 7. Accounts Having Balance Greater Than 10000

SELECT
    customer_id,
    account_type,
    balance_inr
FROM accounts
WHERE balance_inr > 10000
ORDER BY balance_inr DESC;

-- 8. Monthly Account Opening Trend

SELECT
    YEAR(open_date) AS year,
    MONTH(open_date) AS month,
    COUNT(*) AS accounts_opened
FROM accounts
GROUP BY YEAR(open_date), MONTH(open_date)
ORDER BY year, month;

-- 9. Customers Having More Than One Account

SELECT
    customer_id,
    COUNT(account_id) AS total_accounts
FROM accounts
GROUP BY customer_id
HAVING COUNT(account_id) > 1
ORDER BY total_accounts DESC;

-- 10. Top Cities by Customer Base

SELECT
    city,
    COUNT(customer_id) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

-- 11. City-wise Merchant Distribution

SELECT
    city,
    COUNT(*) AS total_merchants
FROM merchants
GROUP BY city
ORDER BY total_merchants DESC;

-- 12. Top 10 Highest Value Transactions

SELECT
    transaction_id,
    account_id,
    merchant_id,
    amount_inr
FROM transactions
ORDER BY amount_inr DESC
LIMIT 10;

-- 13. Average Transaction Value

SELECT
    ROUND(AVG(amount_inr),2) AS average_transaction_value
FROM transactions;

-- 14. Total Transaction Value by Merchant

SELECT
    merchant_id,
    ROUND(SUM(amount_inr),2) AS total_transaction_value
FROM transactions
GROUP BY merchant_id
ORDER BY total_transaction_value DESC;

-- 15. Merchants with More Than 10 Transactions

SELECT
    merchant_id,
    COUNT(transaction_id) AS total_transactions
FROM transactions
GROUP BY merchant_id
HAVING COUNT(transaction_id) > 10
ORDER BY total_transactions DESC;

-- 16. Top 10 Customers by Loan Amount

SELECT
    customer_id,
    loan_amount
FROM loans
ORDER BY loan_amount DESC
LIMIT 10;

-- 17. Average Loan Amount

SELECT
    ROUND(AVG(loan_amount),2) AS average_loan_amount
FROM loans;

-- 18. Customers with Both Account and Loan

SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    a.account_type,
    l.loan_amount
FROM customers c
INNER JOIN accounts a
ON c.customer_id = a.customer_id
INNER JOIN loans l
ON c.customer_id = l.customer_id
ORDER BY l.loan_amount DESC;

-- 19. Total Account Balance by Customer City

SELECT
    c.city,
    ROUND(SUM(a.balance_inr),2) AS total_balance
FROM customers c
INNER JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.city
ORDER BY total_balance DESC;

-- 20. Customer Account Summary

SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    a.account_type,
    a.balance_inr
FROM customers c
INNER JOIN accounts a
ON c.customer_id = a.customer_id
ORDER BY a.balance_inr DESC
LIMIT 20;