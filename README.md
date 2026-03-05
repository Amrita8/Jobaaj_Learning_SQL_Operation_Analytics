# Jobaaj_Learning_SQL_Operation_Analytics
This README provides a professional and detailed overview of the **Operational Analytics and Investigating Metric Spike** project, based on the provided SQL scripts and presentation materials.

---

# Operational Analytics & Metric Spike Investigation

## 📌 Project Overview

Operational Analytics is the process of analyzing a company's end-to-end operations to identify areas for improvement and efficiency. This project focuses on two core areas: **Job Data Analysis** (operational efficiency) and **Investigating Metric Spikes** (understanding user behavior and product engagement).

The goal is to provide data-driven insights that explain sudden changes in key metrics, such as dips in user engagement or throughput fluctuations.

## 🗂️ Case Studies

### 1. Case Study 1: Job Data Analysis

This phase focuses on auditing the operational performance of a job-reviewing platform.

* **Jobs Reviewed Over Time**: Calculated the number of jobs reviewed per hour for each day in November 2020.
* **Throughput Analysis**: Performed a 7-day rolling average of throughput to identify long-term trends in event processing.
* **Language Share**: Analyzed the distribution of languages used in the dataset over the last 30 days.
* **Data Integrity**: Identified and managed duplicate rows within the dataset.

### 2. Case Study 2: Investigating Metric Spike

This phase mimics a real-world scenario where an analyst must explain why a specific metric (user engagement) changed suddenly.

* **Weekly User Engagement**: Measured the number of active users per week.
* **User Growth Analysis**: Tracked the month-over-month growth of users.
* **Weekly Retention Analysis**: Analyzed the retention rate of a specific cohort (users who signed up in Week 18) to see their long-term engagement.
* **Engagement Per Device**: Investigated engagement levels across different hardware (MacBook Pro, iPhone, etc.) to see if the metric spike was device-specific.
* **Email Engagement**: Analyzed the funnel from "Email Sent" to "Email Opened" and "Email Clicked."

## 🛠️ Tech Stack

* **Database**: MySQL (Workbench 8.0)
* **Concepts**: Advanced SQL, CTEs (Common Table Expressions), Window Functions, Date/Time Manipulation, Aggregations.
* **Reporting**: Microsoft PowerPoint.

## 📊 Key Insights

### Case Study 1 Findings:

* **Throughput**: Less than 0.01 jobs were reviewed per hour on average during November.
* **Language Preference**: **Persian** holds the highest share among the languages in the dataset.
* **Duplicates**: The dataset was relatively clean, with only 2 duplicate entries detected.

### Case Study 2 Findings:

* **Engagement Peak/Drop**: Week 30 saw the highest engagement (1,467 users), while Week 35 saw a significant drop to only 104 users.
* **Device Impact**: **MacBook Pro** users were the most active, particularly in Week 30.
* **Email Metrics**: The overall email open rate stands at **33.58%**, with a click-through rate of **14.79%**.
* **Retention**: Total engaged users remained higher than the total retained users, suggesting a need for better re-engagement strategies for newer cohorts.

## 📖 How to Use

1. **Database Setup**: Run the provided `.sql` script in MySQL Workbench to create the `job_db` and its associated tables.
2. **Analysis**: The script is divided into sections corresponding to Case Study 1 and 2. Execute the queries to see the result sets for throughput, growth, and retention.
3. **Visualization**: Refer to the `Operation Analytics and Investigating Metric Spike.pptx` file for the graphical representation of these findings and final business recommendations.

---

*This project demonstrates the ability to handle large-scale operational data and investigate complex product performance issues using SQL.*
