-- ============================================================
-- Insurance Cost Analysis using MySQL
-- Author: Nithin Shaju
-- Tool: MySQL Workbench (MySQL 8.0+)
-- Table: insurance(age, sex, bmi, children, smoker, region, charges)
--
-- Objective:
-- Analyse medical insurance charges and identify patterns and
-- customer segments associated with higher insurance costs.
-- ============================================================


-- ============================================================
-- DATABASE SETUP
-- ============================================================

CREATE DATABASE insurance;
USE insurance;

-- Preview the source data
SELECT *
FROM insurance;


-- ============================================================
-- 1. OVERALL CHARGE ANALYSIS
-- ============================================================

-- 1. Calculate the overall average insurance charge
SELECT
    ROUND(AVG(charges), 2) AS average_charge
FROM insurance;


-- ============================================================
-- 2. SMOKING ANALYSIS
-- ============================================================

-- 2. Compare the average charge of smokers vs non-smokers
SELECT
    smoker,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS average_charge
FROM insurance
GROUP BY smoker
ORDER BY average_charge DESC;


-- ============================================================
-- 3. DEMOGRAPHIC ANALYSIS
-- ============================================================

-- 3. Find the average charge by region
SELECT
    region,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS average_charge
FROM insurance
GROUP BY region
ORDER BY average_charge DESC;


-- 4. Find the average charge by gender
SELECT
    sex,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS average_charge
FROM insurance
GROUP BY sex
ORDER BY average_charge DESC;


-- 5. Find the average charge by age group
SELECT
    CASE
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS average_charge
FROM insurance
GROUP BY age_group
ORDER BY average_charge DESC;


-- 6. Find the average charge by BMI category
SELECT
    CASE
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi < 25 THEN 'Normal'
        WHEN bmi < 30 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS average_charge
FROM insurance
GROUP BY bmi_category
ORDER BY average_charge DESC;


-- 7. Find the average charge by number of children
SELECT
    children,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS average_charge
FROM insurance
GROUP BY children
ORDER BY children;


-- ============================================================
-- 4. COMBINATION ANALYSIS
-- ============================================================

-- 8. Analyse average charges by gender and smoking status
SELECT
    sex,
    smoker,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS average_charge
FROM insurance
GROUP BY sex, smoker
ORDER BY average_charge DESC;


-- 9. Analyse average charges by age group and smoking status
SELECT
    CASE
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    smoker,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS average_charge
FROM insurance
GROUP BY age_group, smoker
ORDER BY age_group, smoker;


-- 10. Analyse average charges by BMI category and smoking status
SELECT
    CASE
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi < 25 THEN 'Normal'
        WHEN bmi < 30 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category,
    smoker,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS average_charge
FROM insurance
GROUP BY bmi_category, smoker
ORDER BY average_charge DESC;


-- ============================================================
-- 5. CUSTOMER & REGIONAL SEGMENTATION
-- ============================================================

-- 11. Calculate the smoking percentage by region
SELECT
    region,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN smoker = 'yes' THEN 1 ELSE 0 END) AS smokers,
    ROUND(
        SUM(CASE WHEN smoker = 'yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS smoker_percentage
FROM insurance
GROUP BY region
ORDER BY smoker_percentage DESC;


-- 12. Calculate the percentage of smokers and non-smokers
SELECT
    smoker,
    COUNT(*) AS customers,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM insurance),
        2
    ) AS percentage
FROM insurance
GROUP BY smoker;


-- ============================================================
-- 6. HIGH-COST CUSTOMER ANALYSIS
-- ============================================================

-- 13. List the top 10 highest insurance charges
SELECT
    age,
    sex,
    bmi,
    children,
    smoker,
    region,
    ROUND(charges, 2) AS charges
FROM insurance
ORDER BY charges DESC
LIMIT 10;


-- 14. Count customers with charges above the overall average
SELECT
    COUNT(*) AS customers_above_average
FROM insurance
WHERE charges > (
    SELECT AVG(charges)
    FROM insurance
);


-- 15. Profile the top 10% of customers by insurance charge
WITH ranked_customers AS (
    SELECT
        *,
        NTILE(10) OVER (ORDER BY charges DESC) AS charge_group
    FROM insurance
)
SELECT
    COUNT(*) AS customers,
    ROUND(AVG(age), 2) AS average_age,
    ROUND(AVG(bmi), 2) AS average_bmi,
    ROUND(AVG(children), 2) AS average_children,
    ROUND(AVG(charges), 2) AS average_charge,
    SUM(CASE WHEN smoker = 'yes' THEN 1 ELSE 0 END) AS smokers
FROM ranked_customers
WHERE charge_group = 1;


-- ============================================================
-- END OF ANALYSIS
-- ============================================================
