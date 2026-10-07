# Insurance Cost Analysis using MySQL

A structured SQL analysis of a medical insurance dataset to identify factors associated with higher insurance charges.

## Key Takeaway

Smoking status showed the strongest association with insurance charges, with smokers paying approximately **3.8x more** on average than non-smokers.

## Business Questions

- Which factors are most strongly associated with higher insurance charges?
- How do charges differ between smokers and non-smokers?
- How do age and BMI relate to insurance costs?
- Which customer segments have the highest average charges?
- How concentrated are insurance charges among high-cost customers?

## Dataset

The dataset contains **1,338 customer records** with age, sex, BMI, number of children, smoking status, region and insurance charges billed in US dollars.

**Source:** [Medical Cost Personal Dataset — Kaggle](https://www.kaggle.com/datasets/mirichoi0218/insurance)

## Tools & Skills

- **Database:** MySQL
- **Tool:** MySQL Workbench
- SQL data analysis
- Aggregation and `GROUP BY`
- Conditional logic with `CASE`
- Subqueries
- Common Table Expressions (CTEs)
- Window functions (`NTILE`)
- Customer segmentation
- Comparative analysis
- Insight generation

## Key Findings

- **Smoking:** Smokers pay about **3.8x more** than non-smokers on average (32,050 vs 8,434), and the gap holds across age groups, BMI categories and gender.
- **Age:** Customers aged 60+ pay more than twice as much as customers aged 20–29.
- **BMI:** BMI has its biggest impact together with smoking. Obese smokers have the highest average charges (about 41,558).
- **Gender:** Males pay about **11% more** on average, mainly because more of them smoke.
- **Region and children:** Region and number of children show smaller differences.
- **High-cost customers:** Only about **31%** of customers pay more than the average charge, while the **top 10%** pay over 3x the average.

These are associations observed in this dataset, not proven causal relationships.

## Repository Contents

| File | Description |
|------|-------------|
| `Insurance_Data_Analysis_MySQL_Final.pdf` | Full report with queries, result screenshots and insights |
| `insurance_analysis.sql` | Complete SQL analysis containing 15 queries |
| `README.md` | Project overview, methodology and findings |

## How to Run

1. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/mirichoi0218/insurance).
2. In MySQL Workbench, create a database named `insurance`.
3. Import the CSV into a table named `insurance`.
4. Open `insurance_analysis.sql` and run the queries.

The table should contain the following columns:

`age`, `sex`, `bmi`, `children`, `smoker`, `region`, `charges`

**MySQL 8.0 or later** is required for CTEs and window functions.

## Author

**Nithin Shaju**
