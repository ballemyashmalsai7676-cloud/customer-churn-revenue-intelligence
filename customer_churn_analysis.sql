CREATE DATABASE customer_churn_db;

USE customer_churn_db;



-- Confirm the active database.
SELECT DATABASE();

-- Check the number of customer records.
SELECT COUNT(*) AS total_rows
FROM customers;

-- Check the customer ID and churn columns.
SELECT
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(churned = 'Yes') AS churned_customers,
    SUM(churned = 'No') AS retained_customers
FROM customers;


DESCRIBE customers;

-- Q1: Count the total number of customers in the dataset.
-- Business purpose: Understand the size of the customer base.

SELECT COUNT(*) AS total_customers
FROM customers;

-- Q2: List all unique subscription plans.
-- DISTINCT removes duplicate plan names from the results.

SELECT DISTINCT plan_type
FROM customers
ORDER BY plan_type;

-- Q3: Count customers in each subscription plan.
-- GROUP BY creates one result row for each plan.

SELECT
    plan_type,
    COUNT(*) AS total_customers
FROM customers
GROUP BY plan_type
ORDER BY total_customers DESC;

-- Q4: Count customers by churn status.
-- GROUP BY separates the results into churn categories.

SELECT
    churned,
    COUNT(*) AS customer_count
FROM customers
GROUP BY churned
ORDER BY customer_count DESC;

-- Q5: Calculate the overall customer churn rate as a percentage.

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_percentage
FROM customers;


-- Q6: Calculate the average monthly subscription fee.
-- ROUND displays the result to two decimal places.

SELECT
    ROUND(AVG(monthly_fee), 2) AS average_monthly_fee
FROM customers;



-- Q7: Calculate the total recorded customer revenue.
-- SUM adds the total_revenue value for every customer.

SELECT
    ROUND(SUM(total_revenue), 2) AS total_recorded_revenue
FROM customers;

-- Q8: Display the top 10 customers ranked by total revenue.
-- ORDER BY sorts customers from highest to lowest revenue.
-- LIMIT returns only the first 10 rows.

SELECT
    customer_id,
    plan_type,
    monthly_fee,
    tenure_months,
    total_revenue
FROM customers
ORDER BY total_revenue DESC
LIMIT 10;


-- Q9: Find customers with five or more support tickets.
-- WHERE filters the dataset to customers meeting this condition.

SELECT
    customer_id,
    plan_type,
    support_tickets,
    churned,
    total_revenue
FROM customers
WHERE support_tickets >= 5
ORDER BY support_tickets DESC, total_revenue DESC;

-- Q10: Calculate customer count and average revenue for each plan.
-- GROUP BY summarizes the data at the subscription-plan level.

SELECT
    plan_type,
    COUNT(*) AS total_customers,
    ROUND(AVG(total_revenue), 2) AS average_customer_revenue,
    ROUND(SUM(total_revenue), 2) AS total_plan_revenue
FROM customers
GROUP BY plan_type
ORDER BY average_customer_revenue DESC;

-- Q11: Compare churn rates across subscription plans.
SELECT
    plan_type,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM customers
GROUP BY plan_type
ORDER BY churn_rate_pct DESC;

-- Q12: Analyze churn across customer age groups.
SELECT
    age_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM customers
GROUP BY age_group
ORDER BY churn_rate_pct DESC;


-- Q13: Compare churn rates across tenure groups.
SELECT
    CASE
        WHEN tenure_group LIKE '0%' THEN '0-6 months'
        WHEN tenure_group LIKE '7%' THEN '7-12 months'
        WHEN tenure_group LIKE '13%' THEN '13-24 months'
        WHEN tenure_group LIKE '25%' THEN '25+ months'
        ELSE tenure_group
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM customers
GROUP BY tenure_group
ORDER BY MIN(tenure_months);



-- Q14: Compare customer churn across cities.
SELECT
    city,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM customers
GROUP BY city
HAVING COUNT(*) >= 20
ORDER BY churn_rate_pct DESC;

-- Q15: Evaluate churn by customer acquisition channel.
SELECT
    marketing_channel,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM customers
GROUP BY marketing_channel
ORDER BY churn_rate_pct DESC;

-- Q16: Compare churn rates by support-ticket group.
SELECT
    CASE
        WHEN support_tickets BETWEEN 0 AND 1 THEN '0-1 tickets'
        WHEN support_tickets BETWEEN 2 AND 3 THEN '2-3 tickets'
        WHEN support_tickets BETWEEN 4 AND 5 THEN '4-5 tickets'
        ELSE '6+ tickets'
    END AS support_ticket_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM customers
GROUP BY
    CASE
        WHEN support_tickets BETWEEN 0 AND 1 THEN '0-1 tickets'
        WHEN support_tickets BETWEEN 2 AND 3 THEN '2-3 tickets'
        WHEN support_tickets BETWEEN 4 AND 5 THEN '4-5 tickets'
        ELSE '6+ tickets'
    END
ORDER BY MIN(support_tickets);




-- Q17: Compare churn across engagement categories.
SELECT
    session_usage_category,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM customers
GROUP BY session_usage_category
ORDER BY churn_rate_pct DESC;

-- Q18: Compare revenue across customer segments.
SELECT
    revenue_category,
    COUNT(*) AS total_customers,
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(AVG(total_revenue), 2) AS avg_customer_revenue
FROM customers
GROUP BY revenue_category
ORDER BY total_revenue DESC;


-- Q19: Compare recorded revenue by churn status.
SELECT
    churned,
    COUNT(*) AS total_customers,
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(AVG(total_revenue), 2) AS avg_customer_revenue
FROM customers
GROUP BY churned
ORDER BY total_revenue DESC;

-- Q20: Identify high-value customers who have churned.
SELECT
    customer_id,
    plan_type,
    monthly_fee,
    tenure_months,
    support_tickets,
    total_revenue
FROM customers
WHERE churned = 'Yes'
  AND high_value_customer = 'Yes'
ORDER BY total_revenue DESC;


-- Q21: Rank customers by total revenue.
SELECT
    customer_id,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM customers;


-- Q22: Rank customers within each subscription plan.
WITH ranked_customers AS (
    SELECT
        customer_id,
        plan_type,
        total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY plan_type
            ORDER BY total_revenue DESC
        ) AS customer_rank
    FROM customers
)
SELECT *
FROM ranked_customers
WHERE customer_rank <= 5
ORDER BY plan_type, customer_rank;


-- Q23: Calculate each plan's percentage contribution to revenue.
SELECT
    plan_type,
    ROUND(SUM(total_revenue), 2) AS plan_revenue,
    ROUND(
        100.0 * SUM(total_revenue)
        / NULLIF(SUM(SUM(total_revenue)) OVER (), 0),
        2
    ) AS revenue_share_pct
FROM customers
GROUP BY plan_type
ORDER BY plan_revenue DESC;

-- Q24: Compare customer revenue with the overall average.
SELECT
    customer_id,
    total_revenue,
    ROUND(AVG(total_revenue) OVER (), 2) AS average_revenue,
    ROUND(
        total_revenue - AVG(total_revenue) OVER (),
        2
    ) AS difference_from_average
FROM customers
ORDER BY difference_from_average DESC;

-- Q25: Calculate cumulative revenue by descending customer revenue.
SELECT
    customer_id,
    total_revenue,
    SUM(total_revenue) OVER (
        ORDER BY total_revenue DESC, customer_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM customers;


-- Q26: Find the point where cumulative revenue reaches 80%.
WITH customer_revenue AS (
    SELECT
        customer_id,
        total_revenue,
        SUM(total_revenue) OVER (
            ORDER BY total_revenue DESC, customer_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_revenue,
        SUM(total_revenue) OVER () AS overall_revenue
    FROM customers
)
SELECT
    customer_id,
    total_revenue,
    cumulative_revenue,
    ROUND(
        100.0 * cumulative_revenue
        / NULLIF(overall_revenue, 0),
        2
    ) AS cumulative_revenue_pct
FROM customer_revenue
WHERE cumulative_revenue - total_revenue < overall_revenue * 0.80
ORDER BY total_revenue DESC;



-- Q27: Compare plan churn rates with the overall rate.
WITH plan_churn AS (
    SELECT
        plan_type,
        COUNT(*) AS total_customers,
        SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
            AS churned_customers
    FROM customers
    GROUP BY plan_type
)
SELECT
    plan_type,
    total_customers,
    churned_customers,
    ROUND(
        100.0 * churned_customers
        / NULLIF(total_customers, 0),
        2
    ) AS plan_churn_pct,
    ROUND(
        100.0 * SUM(churned_customers) OVER ()
        / NULLIF(SUM(total_customers) OVER (), 0),
        2
    ) AS overall_churn_pct
FROM plan_churn
ORDER BY plan_churn_pct DESC;


-- Q28: Compare support-ticket levels between churned and retained customers.
SELECT
    churned,
    COUNT(*) AS total_customers,
    ROUND(AVG(support_tickets), 2) AS avg_support_tickets,
    ROUND(AVG(total_revenue), 2) AS avg_customer_revenue
FROM customers
GROUP BY churned;

-- Q29: Identify customers with more support tickets than average.
WITH support_average AS (
    SELECT AVG(support_tickets) AS avg_tickets
    FROM customers
)
SELECT
    c.customer_id,
    c.support_tickets,
    c.churned,
    c.plan_type,
    c.total_revenue
FROM customers AS c
CROSS JOIN support_average AS s
WHERE c.support_tickets > s.avg_tickets
ORDER BY c.support_tickets DESC;

-- Q30: Summarize revenue and churn performance by plan.
SELECT
    plan_type,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(AVG(monthly_fee), 2) AS avg_monthly_fee,
    ROUND(AVG(total_revenue), 2) AS avg_customer_revenue,
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM customers
GROUP BY plan_type
ORDER BY total_revenue DESC;

-- Q31: Count high-value customers by subscription plan.
SELECT
    plan_type,
    COUNT(*) AS high_value_customers
FROM customers
WHERE high_value_customer = 'Yes'
GROUP BY plan_type
ORDER BY high_value_customers DESC;

-- Q32: Calculate the high-value customer percentage by plan.
SELECT
    plan_type,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN high_value_customer = 'Yes' THEN 1 ELSE 0 END)
        AS high_value_customers,
    ROUND(
        100.0 * SUM(CASE WHEN high_value_customer = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS high_value_pct
FROM customers
GROUP BY plan_type
ORDER BY high_value_pct DESC;

-- Q33: Compare recorded revenue across marketing channels.
SELECT
    marketing_channel,
    COUNT(*) AS total_customers,
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(AVG(total_revenue), 2) AS avg_customer_revenue
FROM customers
GROUP BY marketing_channel
ORDER BY total_revenue DESC;

-- Q34: Compare average monthly fees by subscription plan.
SELECT
    plan_type,
    COUNT(*) AS total_customers,
    ROUND(AVG(monthly_fee), 2) AS avg_monthly_fee,
    ROUND(SUM(monthly_fee), 2) AS total_monthly_fees
FROM customers
GROUP BY plan_type
ORDER BY avg_monthly_fee DESC;

-- Q35: Analyze churn rates by discount category.
SELECT
    discount_category,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM customers
GROUP BY discount_category
ORDER BY churn_rate_pct DESC;

-- Q36: Compare recorded revenue across discount categories.
SELECT
    discount_category,
    COUNT(*) AS total_customers,
    ROUND(AVG(discount_percent), 2) AS avg_discount_pct,
    ROUND(AVG(total_revenue), 2) AS avg_customer_revenue,
    ROUND(SUM(total_revenue), 2) AS total_revenue
FROM customers
GROUP BY discount_category
ORDER BY avg_customer_revenue DESC;


-- Q37: Rank cities by recorded customer revenue.
SELECT
    city,
    COUNT(*) AS total_customers,
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(AVG(total_revenue), 2) AS avg_customer_revenue
FROM customers
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 10;

-- Q38: Identify cities with the highest churned-customer counts.
SELECT
    city,
    COUNT(*) AS churned_customers
FROM customers
WHERE churned = 'Yes'
GROUP BY city
ORDER BY churned_customers DESC
LIMIT 10;

-- Q39: Compare average customer tenure by subscription plan.
SELECT
    plan_type,
    COUNT(*) AS total_customers,
    ROUND(AVG(tenure_months), 2) AS avg_tenure_months,
    ROUND(AVG(cus_tenure_years), 2) AS avg_tenure_years
FROM customers
GROUP BY plan_type
ORDER BY avg_tenure_months DESC;


-- Q40: Summarize churn and revenue by tenure and plan.
SELECT
    tenure_group,
    plan_type,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct,
    ROUND(AVG(total_revenue), 2) AS avg_customer_revenue
FROM customers
GROUP BY tenure_group, plan_type
HAVING COUNT(*) >= 10
ORDER BY churn_rate_pct DESC;

-- Q41: Identify duplicate customer IDs.
SELECT
    customer_id,
    COUNT(*) AS record_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- Q42: Count missing values in key customer fields.
SELECT
    SUM(customer_id IS NULL) AS missing_customer_ids,
    SUM(plan_type IS NULL) AS missing_plans,
    SUM(churned IS NULL) AS missing_churn_status,
    SUM(total_revenue IS NULL) AS missing_revenue
FROM customers;


-- Q43: Identify negative or missing revenue values.
SELECT
    customer_id,
    total_revenue
FROM customers
WHERE total_revenue IS NULL
   OR total_revenue < 0
ORDER BY total_revenue;

-- Q44: Find records with invalid date order.
SELECT
    customer_id,
    signup_date,
    last_active_date,
    date_valid
FROM customers
WHERE date_valid = FALSE
   OR last_active_date < signup_date;
   
   
   
   
   -- Q45: Summarize recorded revenue against baseline revenue.
SELECT
    plan_type,
    ROUND(SUM(base_revenue), 2) AS total_base_revenue,
    ROUND(SUM(total_revenue), 2) AS total_recorded_revenue,
    ROUND(SUM(revenue_difference), 2) AS total_revenue_difference
FROM customers
GROUP BY plan_type
ORDER BY total_revenue_difference DESC;


-- Q46: Measure churn among high-value customers.
SELECT
    COUNT(*) AS high_value_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_high_value_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS high_value_churn_rate_pct
FROM customers
WHERE high_value_customer = 'Yes';

-- Q47: Compare churn across plans and marketing channels.
SELECT
    plan_type,
    marketing_channel,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct
FROM customers
GROUP BY plan_type, marketing_channel
HAVING COUNT(*) >= 10
ORDER BY churn_rate_pct DESC;



-- Q48: Summarize overall customer, churn, and revenue metrics.
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct,
    ROUND(AVG(monthly_fee), 2) AS avg_monthly_fee,
    ROUND(AVG(total_revenue), 2) AS avg_customer_revenue,
    ROUND(SUM(total_revenue), 2) AS total_recorded_revenue
FROM customers;



-- Q49: Find retained customers with high support-ticket counts.
SELECT
    customer_id,
    plan_type,
    support_tickets,
    monthly_fee,
    total_revenue
FROM customers
WHERE churned = 'No'
  AND support_tickets >= 5
ORDER BY support_tickets DESC, total_revenue DESC;

-- Q50: Summarize customer, churn, and revenue performance by plan.
SELECT
    plan_type,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct,
    ROUND(AVG(monthly_fee), 2) AS avg_monthly_fee,
    ROUND(AVG(total_revenue), 2) AS avg_customer_revenue,
    ROUND(SUM(total_revenue), 2) AS total_recorded_revenue
FROM customers
GROUP BY plan_type
ORDER BY churn_rate_pct DESC;



-- Verify the main project KPIs.
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_pct,
    ROUND(SUM(total_revenue), 2) AS total_recorded_revenue,
    SUM(
        CASE
            WHEN churned = 'Yes'
             AND high_value_customer = 'Yes'
            THEN 1 ELSE 0
        END
    ) AS high_value_churned
FROM customers;

-- Verify customer counts and churn totals by plan.
SELECT
    plan_type,
    COUNT(*) AS total_customers,
    SUM(churned = 'Yes') AS churned_customers,
    SUM(churned = 'No') AS retained_customers
FROM customers
GROUP BY plan_type
WITH ROLLUP;

