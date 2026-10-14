# Customer Churn & Revenue Intelligence

An end-to-end data analytics project focused on customer retention, subscription performance, revenue analysis, and machine learning.

## Project Overview

This project analyzes customer subscription data to identify customer churn patterns, understand revenue performance, compare subscription plans, and explore factors associated with customer behavior.

The project combines Python, SQL, Excel, Power BI, and machine learning to turn raw customer data into business insights.

It includes data cleaning, feature engineering, exploratory data analysis (EDA), SQL-based business analysis, interactive Power BI dashboards, customer churn classification, and revenue prediction.

## Business Objectives

- Analyze customer subscription and revenue patterns.
- Measure customer churn and retention.
- Compare churn rates across subscription plans, tenure groups, and age groups.
- Evaluate revenue across marketing channels and cities.
- Identify high-value customers who have churned.
- Explore customer characteristics associated with churn and revenue.
- Build and evaluate machine learning models for churn classification and revenue prediction.
- Develop data-driven recommendations to support customer retention and revenue growth.

## Dataset

The dataset contains customer subscription information, including:

- Customer ID
- Age and gender
- City
- Signup date and last active date
- Subscription plan
- Monthly subscription fee
- Customer tenure
- Support tickets
- Average session time
- Discount percentage
- Marketing channel
- Churn status
- Total revenue

After duplicate removal, the analysis contains **2,500 customer records**.

## Technologies Used

- **Python:** Data analysis and feature engineering
- **Pandas and NumPy:** Data manipulation and numerical analysis
- **Matplotlib and Seaborn:** Data visualization
- **Scikit-learn:** Machine learning and model evaluation
- **MySQL:** SQL queries and business analysis
- **Microsoft Excel:** Tabular data inspection and analysis
- **Microsoft Power BI:** Interactive dashboards and KPI reporting
- **Jupyter Notebook:** Analysis and documentation
- **VS Code:** Development environment

## Project Workflow

1. Data loading and understanding
2. Data cleaning and quality checks
3. Feature engineering and customer segmentation
4. Exploratory data analysis
5. Customer churn and revenue analysis
6. SQL-based business analysis
7. Machine learning model development
8. Model evaluation and feature importance
9. Power BI dashboard development
10. Business insights and recommendations

## Python Analysis

Python was used to inspect the dataset, handle missing values, remove duplicate records, convert date columns, and create additional analytical features.

Feature engineering included customer tenure in years, revenue per month, engagement score, age groups, customer value categories, session usage categories, discount categories, and support intensity.

Exploratory analysis examined relationships between customer attributes, churn, subscription plans, marketing channels, customer tenure, and revenue.

## SQL Analysis

MySQL was used to perform business-focused queries on customer subscription data.

The analysis covers:

- Total customers and overall churn rate
- Customer distribution by subscription plan
- Average monthly fees and recorded revenue
- Churn rates by plan, age group, tenure, city, and marketing channel
- Revenue contribution by subscription plan and marketing channel
- High-value customers who have churned
- Customer rankings and cumulative revenue analysis
- Customer data quality checks, including duplicates, missing values, and invalid date order
- Combined churn and revenue performance analysis

The SQL script contains 50 numbered business analysis queries, along with database setup and KPI verification queries.

## Machine Learning

### 1. Customer Churn Classification

Two classification models were evaluated:

- Logistic Regression
- Random Forest Classifier

The models were assessed using accuracy, precision, recall, F1-score, and ROC-AUC.

| Metric | Logistic Regression | Random Forest |
|---|---:|---:|
| Accuracy | 54.0% | 71.6% |
| Precision | 27.7% | 20.9% |
| Recall | 59.8% | 7.7% |
| F1-score | 37.8% | 11.3% |
| ROC-AUC | 0.543 | 0.528 |

The results show that the churn classification models have limited predictive performance. The Random Forest model achieved higher accuracy but detected very few churned customers at the evaluated classification threshold.

Further model improvement and threshold tuning would be required before using these models for operational customer retention decisions.

### 2. Revenue Prediction

Two regression models were compared:

- Linear Regression
- Random Forest Regressor

| Metric | Linear Regression | Random Forest Regression |
|---|---:|---:|
| R² | 0.9019 | 0.9990 |
| MAE | 2,601.15 | 241.14 |
| RMSE | 3,483.13 | 345.51 |

The Random Forest Regressor achieved lower prediction errors and a higher R² score on the evaluated test data.

However, the very high R² score should be validated further to rule out target leakage or overly direct relationships between the input features and total revenue before treating the model as reliable for real-world forecasting.

## Power BI Dashboard

The Power BI dashboard, **Customer Churn & Revenue Intelligence**, presents customer retention, churn, and revenue performance through KPI cards, charts, and interactive filters.

The dashboard includes:

- Customer and churn KPIs
- Customer churn by subscription plan
- Churn rate by customer tenure
- Churn rate by age group
- Recorded revenue by marketing channel
- Top 10 cities by recorded revenue
- Churned customer counts by plan
- Recorded revenue by subscription plan
- Filters for subscription plan, city, and marketing channel

The dashboard is designed to help users explore customer churn patterns and compare revenue performance across different customer segments.

## Key Findings

The following results are based on the completed Power BI dashboard and notebook analysis.

- **Customer base:** 2,500 customer records.
- **Churn:** 586 churned customers, representing a churn rate of 23.44%.
- **Retention:** 1,914 retained customers.
- **High-value churn:** 282 high-value customers had churned.
- **Recorded revenue:** Approximately 39.77 million in the dataset's reported currency.
- **Average recorded revenue per customer:** Approximately 15.91K.
- **Average monthly fee:** Approximately 902.54.
- **Highest churn by tenure group:** Customers with 0–6 months of tenure had a churn rate of 27.16%.
- **Highest churn by age group:** The Adult group had a churn rate of 24.95%.
- **Revenue by marketing channel:** Email recorded approximately 10.4 million in revenue.
- **Revenue by subscription plan:** The Basic plan recorded approximately 17.1 million, followed by Standard at 15.0 million and Premium at 7.7 million.

These findings highlight customer retention and revenue patterns that can be investigated further by the business.

## Business Recommendations

Based on the observed patterns:

1. **Improve early customer retention:** Investigate onboarding, customer expectations, and service issues among customers in their first six months.
2. **Review customer support experiences:** Examine support-ticket patterns and customer feedback to identify potential retention issues.
3. **Protect high-value customers:** Review the reasons behind churn among high-value customers and consider targeted retention strategies.
4. **Evaluate subscription plans:** Compare plan-level churn, revenue contribution, pricing, and customer satisfaction before making pricing or product changes.
5. **Review marketing performance:** Compare acquisition costs, customer quality, retention, and revenue across marketing channels rather than relying on revenue totals alone.
6. **Improve churn prediction:** Investigate alternative features, classification thresholds, and model evaluation methods to improve churn detection.
7. **Validate revenue prediction:** Test the regression models on independent data and check for target leakage before using predictions for business decisions.

These recommendations are hypotheses for further business investigation, not proof that any single factor causes churn.

## Data Quality Considerations

The project includes checks for missing values, duplicate records, and inconsistent date order.

The notebook identified records where the last active date preceded the signup date. These records were retained, and invalid negative activity durations were set to missing values for the derived activity-duration analysis.

Such records should be investigated further before the dataset is used for production reporting or predictive decision-making.

## Project Files

The repository contains the analysis notebook, SQL queries, data files, dashboard documentation, and Python dependency list.

```text
Customer-Churn-Revenue-Intelligence/
│
├── customer_churn_analysis.ipynb
├── customer_churn_analysis.sql
├── Customer_analysis_data.xlsx
├── requirements.txt
├── README.md
│
├── data/
│   └── cleaned_customer_data.csv
│
└── images/
    └── dashboard screenshots
```

The structure above is illustrative. Keep the filenames and folders in this section aligned with the files actually included in the repository.

## How to Run the Project

### 1. Clone or download the repository

Download the project files to your computer.

### 2. Install dependencies

Open a terminal in the project directory and run:

```bash
pip install -r requirements.txt
```

### 3. Run the Jupyter Notebook

Open the notebook in Jupyter Notebook or VS Code and execute the cells in order.

Make sure the source dataset is available at the file path referenced in the notebook.

### 4. Run the SQL analysis

Open the SQL script in MySQL Workbench or another compatible MySQL client.

Create or select the project database, import the prepared customer table, and execute the analysis queries.

The SQL queries expect a `customers` table containing the columns referenced in the script.

### 5. Explore the Power BI dashboard

Open the Power BI report in Power BI Desktop if the report file is included in the repository.

The exported dashboard PDF can also be used to review the final dashboard layout and reported results.

## Conclusion

This project demonstrates an end-to-end customer analytics workflow combining data preparation, exploratory analysis, SQL business queries, machine learning, and Power BI visualization.

It provides insights into customer churn, subscription performance, customer segmentation, and recorded revenue while identifying areas for further model improvement and business investigation.

