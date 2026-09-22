# 💳 Payment Failure Analysis

## 📌 Overview

An end-to-end **Fintech Operations Analytics** project analyzing UPI payment transactions to identify concentrated payment failure patterns across banks, payment methods, devices, networks, transaction amounts, and time.

## 🎯 Business Objective

The primary objective of this project is to analyze UPI payment transactions and identify where, when, and under which conditions payment failures are concentrated. For a fintech organization, understanding payment failures is important because frequent or concentrated failures can affect customer experience, transaction completion, merchant operations, and the workload handled by payment support and operations teams.

Rather than looking only at the overall payment failure rate, this project performs a detailed segmentation of transaction failures across payment methods, banks, device types, network types, transaction amount ranges, hours of the day, and bank-device combinations.

The analysis focuses on answering the following business needs:

Measure overall payment reliability by calculating total transactions, failed transactions, and the overall failure rate.
Identify high-failure payment methods by comparing transaction volume and failure rates across different payment modes.
Understand bank-level failure concentration by identifying banks responsible for the largest number of failed transactions.
Compare bank performance fairly by applying minimum transaction-volume thresholds before interpreting failure rates.
Identify device-related patterns by analyzing whether certain device types experience higher payment failure rates.
Analyze network-related patterns to determine whether failure rates vary across different network types.
Understand transaction-value patterns by identifying amount ranges associated with higher failure rates.
Identify time-based patterns by analyzing failure rates across different hours of the day.
Detect interaction effects by analyzing bank × device combinations that may have elevated failure rates.
Measure financial impact by calculating the share of failed transaction value contributed by each bank or payment method.

A key objective is to distinguish between failure volume and failure rate. A bank may have the largest number of failed transactions simply because it processes a large transaction volume, while another bank may have a higher failure rate despite processing fewer transactions. Therefore, both metrics are analyzed together to provide a more meaningful operational view.

The project also applies minimum-volume thresholds when comparing segments. This reduces the risk of drawing conclusions from very small groups where a few failed transactions can produce an unusually high percentage.

Ultimately, the project aims to transform raw payment transaction data into clear, measurable, and business-oriented insights that can help a fintech operations team identify areas for deeper investigation and monitor payment reliability through an interactive Power BI dashboard.

Business flow:
Raw Transaction Data → Data Quality → Failure Analysis → Segment Comparison → Operational Insights → Dashboard

## 🛠️ Tools

* 🐍 **Python / Pandas** — Data cleaning & analysis
* 🗄️ **MySQL / PostgreSQL** — SQL business analysis
* 📊 **Power BI** — Dashboard & visualization
* 📁 **Excel / CSV** — Data handling

## 📊 Key Analysis

The project answers 10 business questions covering:

* Overall payment failure rate
* Failure rate by payment method
* Failed transactions by bank
* Bank failure rates with minimum-volume thresholds
* Device and network failure patterns
* Failure rate by transaction amount
* Hourly failure patterns
* Bank × device combinations
* Failed transaction value by bank/payment method

## 🔄 Workflow

```text
CSV / Excel
    ↓
Python + Pandas
    ↓
Data Cleaning & Feature Engineering
    ↓
MySQL / PostgreSQL
    ↓
Business Analysis
    ↓
Power BI
    ↓
Interactive Dashboard
```

## 📈 Dashboard

The Power BI dashboard includes:

* Executive KPI page
* Failure rate analysis
* Bank and payment-method analysis
* Device and network analysis
* Hourly and amount-bucket analysis
* Bank × device diagnostic analysis
* Failed transaction value analysis

## 📁 Project Structure

```text
├── data/
├── python/
├── sql/
├── powerbi/
├── screenshots/
├── documentation/
└── README.md
```

## 📌 Dataset

Public practice/project dataset: **UPI Payment Failure Analysis**

The exact dataset filename, source, and version used are documented separately in the project documentation.

## ⚠️ Note

This project is created for **educational and portfolio purposes**. The analysis identifies patterns within the dataset and does not establish production-level root causes.

## 👨‍💻 Skills Demonstrated

**Python • Pandas • SQL • MySQL/PostgreSQL • Power BI • DAX • Data Cleaning • Business Analysis • Data Visualization • Fintech Analytics**

