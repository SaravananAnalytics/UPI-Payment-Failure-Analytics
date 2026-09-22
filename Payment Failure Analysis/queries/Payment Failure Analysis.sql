CREATE DATABASE payment_failure_analysis
USE payment_failure_analysis
SELECT * FROM dbo.payment_failure

-- 1. What is the overall payment failure rate?

SELECT
	COUNT(*) AS total_transactions,
	SUM(CASE WHEN LOWER(TRIM(transaction_status)) = 'failed' THEN 1 ELSE 0 END) AS failed_transactions,
	ROUND(100.0 * SUM(CASE WHEN LOWER(TRIM(transaction_status)) = 'failed' THEN 1 ELSE 0 END)/COUNT(*),2) AS failure_rate_percent
FROM payment_failure

--2: Which payment methods have the highest failure rate?

SELECT
	transaction_type AS payment_method,
	COUNT(*) AS total_transactions,
	SUM(CASE WHEN LOWER(TRIM(transaction_status)) = 'failed' THEN 1 ELSE 0 END) AS failed_transactions,
	ROUND(100.0 * SUM(CASE WHEN LOWER(TRIM(transaction_status)) = 'failed' THEN 1 ELSE 0 END)/COUNT(*),2) AS failure_rate_percent
FROM payment_failure
GROUP BY transaction_type 
HAVING COUNT(*) > 30
ORDER BY failure_rate_percent DESC

--3. Which banks process the most failed transactions?

SELECT
	sender_bank AS bank,
	COUNT(*) AS failed_transactions
FROM payment_failure
WHERE LOWER(TRIM(transaction_status)) = 'failed'
GROUP BY sender_bank

UNION ALL

SELECT
	receiver_bank AS bank,
	COUNT(*) AS failed_transactions
FROM payment_failure
WHERE LOWER(TRIM(transaction_status)) = 'failed'
GROUP BY receiver_bank
ORDER BY failed_transactions DESC

--4. Which bank has the highest failure rate after applying a minimum transaction-volume threshold?

SELECT
	sender_bank AS bank,
	COUNT(*) AS total_transactions,
	SUM(CASE WHEN LOWER(TRIM(transaction_status)) = 'failed' THEN 1 ELSE 0 END) AS failed_transactions,
	ROUND(100.0 * SUM(CASE WHEN LOWER(TRIM(transaction_status)) = 'failed' THEN 1 ELSE 0 END)/COUNT(*),2) AS failure_rate_percent
FROM payment_failure
GROUP BY sender_bank
HAVING COUNT(*) >= 30 
ORDER BY failure_rate_percent DESC

--5. Does failure rate vary by device type?

SELECT
	device_type,
	COUNT(*) AS total_transactions,
	SUM(CASE WHEN LOWER(TRIM(transaction_status)) = 'failed' THEN 1 ELSE 0 END) AS failed_transactions,
	ROUND(100.0 * SUM(CASE WHEN LOWER(TRIM(transaction_status)) = 'failed' THEN 1 ELSE 0 END)/COUNT(*),2) AS failure_rate_percent
FROM payment_failure
GROUP BY device_type
ORDER BY failure_rate_percent DESC

--6. Does failure rate vary by network type?

SELECT
	network_type,
	COUNT(*) AS total_transactions,
	SUM(CASE WHEN LOWER(TRIM(transaction_status)) = 'failed' THEN 1 ELSE 0 END) AS failed_transactions,
	ROUND(100.0 * SUM(CASE WHEN LOWER(TRIM(transaction_status)) = 'failed' THEN 1 ELSE 0 END)/COUNT(*),2) AS failure_rate_percent
FROM payment_failure
GROUP BY network_type
ORDER BY failure_rate_percent DESC

--7 Which transaction amount bucket has the highest failure rate?

SELECT
    CASE
        WHEN [amount_(inr)] <= 500 THEN 'Low'
        WHEN [amount_(inr)] <= 1500 THEN 'Medium'
        WHEN [amount_(inr)] <= 3505 THEN 'High'
        ELSE 'Extreme'
    END AS amount_bucket,

    COUNT(*) AS total_transactions,

    SUM(
        CASE
            WHEN LOWER(TRIM(transaction_status)) = 'failed' THEN 1
            ELSE 0
        END
    ) AS failed_transactions,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN LOWER(TRIM(transaction_status)) = 'failed' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS failure_rate_percent

FROM payment_failure

GROUP BY
    CASE
        WHEN [amount_(inr)] <= 500 THEN 'Low'
        WHEN [amount_(inr)] <= 1500 THEN 'Medium'
        WHEN [amount_(inr)] <= 3505 THEN 'High'
        ELSE 'Extreme'
    END
ORDER BY failure_rate_percent DESC;

--8. Which hours of the day have unusually high failure rates?

SELECT
    hour_of_day,
    COUNT(*) AS total_transactions,
    SUM(
        CASE
            WHEN LOWER(TRIM(transaction_status)) = 'failed' THEN 1
            ELSE 0
        END
    ) AS failed_transactions,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN LOWER(TRIM(transaction_status)) = 'failed' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS failure_rate_percent
FROM payment_failure
GROUP BY hour_of_day
HAVING COUNT(*) >= 30
ORDER BY failure_rate_percent DESC;

--9. Which bank × device combinations have the highest failure rates?

SELECT
    sender_bank AS bank,
    device_type,
    COUNT(*) AS total_transactions,
    SUM(
        CASE
            WHEN LOWER(TRIM(transaction_status)) = 'failed'
            THEN 1
            ELSE 0
        END
    ) AS failed_transactions,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN LOWER(TRIM(transaction_status)) = 'failed'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS failure_rate_percent
FROM payment_failure
GROUP BY
    sender_bank,
    device_type
HAVING COUNT(*) >= 30
ORDER BY failure_rate_percent DESC;

--10. What share of failed transaction value comes from each bank or payment method?

SELECT
    sender_bank AS bank,
    SUM([amount_(inr)]) AS failed_transaction_value,
    ROUND(
        100.0 * SUM([amount_(inr)]) /
        SUM(SUM([amount_(inr)])) OVER (),
        2
    ) AS value_share_percent
FROM payment_failure
WHERE LOWER(TRIM(transaction_status)) = 'failed'
GROUP BY sender_bank
ORDER BY value_share_percent DESC;