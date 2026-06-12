# NYC Taxi Trip Analysis using SQL & Power BI

## Project Overview

This project analyzes over **2.8 million New York City taxi trips** to uncover ride demand patterns, fare trends, and trip behavior across different days and hours.

The goal was to transform raw trip data into actionable business insights using **MySQL** for data cleaning and analysis and **Power BI** for interactive dashboard creation.

---

## Tools & Technologies

* MySQL | SQL | Power BI | Git & GitHub

---

## Dataset

The dataset contains taxi trip information including pickup date & time, fare amount, trip distance, passenger count, payment type, and trip duration.

---

## Data Cleaning & Feature Engineering

**Outlier Removal** — Records with unrealistic values were removed to improve analysis quality:

```sql
CREATE TABLE trips_del_outliers AS
SELECT *
FROM trips
WHERE fare_amount BETWEEN 0 AND 500
AND trip_distance BETWEEN 0 AND 100;
```

**Feature Engineering** — Additional columns were derived from pickup timestamps (Day Name, Hour of Day) to enable day-wise and hour-wise trend analysis.

---

## Business Questions

1. Which day and hour have the highest ride demand?
2. Which periods have the highest average fare?
3. How do weekdays differ from weekends?
4. What time periods generate the most revenue opportunities?
5. How does trip distance vary across the week?

---

# Dashboard & Key Insights

---

## Dashboard 1: Demand Overview

**Peak Ride Demand:** Thursday evening recorded the highest demand with 28,018 trips at 6PM. Wednesday, Thursday, and Friday evenings consistently show strong ride activity, aligning with post-office commuting hours.

| Day      | Hour | Total Trips |
| -------- | ---- | ----------- |
| Thursday | 18   | 28,018      |
| Thursday | 17   | 27,319      |
| Thursday | 21   | 25,918      |

<img width="800" alt="Dashboard 1 - Demand Overview" src="https://github.com/user-attachments/assets/503e67a4-9cf5-4dd4-8206-3ea82ab0f971" />

---

## Dashboard 2: Distance Analysis

**Weekday vs Weekend:** Weekday demand significantly exceeds weekend demand. Weekday late-night trips have the highest fares and longest average distances. Weekend mornings tend to have longer trips than weekday mornings.

| Category                           | Avg Fare | Avg Distance | Total Trips |
| ---------------------------------- | -------- | ------------ | ----------- |
| Weekday Morning                    | 25.95    | 2.98         | 500,600     |
| Weekday Afternoon                  | 28.00    | 3.09         | 813,473     |
| Weekday Evening / Night            | 27.88    | 3.20         | 715,078     |
| Weekday Late Night / Early Morning | 31.98    | 4.58         | 90,727      |
| Weekend Morning                    | 26.00    | 3.40         | 114,769     |
| Weekend Afternoon                  | 26.44    | 3.12         | 274,279     |
| Weekend Evening / Night            | 27.61    | 3.37         | 213,462     |
| Weekend Late Night / Early Morning | 24.93    | 2.94         | 94,379      |

<img width="800" alt="Dashboard 2 - Distance Analysis" src="https://github.com/user-attachments/assets/7cadce71-dc3f-4017-93c0-a55379c2f373" />

---

## Dashboard 3: Fare Breakdown

**Highest Average Fares:** Peak fares occur during late-night and early-morning hours, likely driven by airport transportation, longer distance rides, and reduced driver availability.

| Day     | Hour | Average Fare |
| ------- | ---- | ------------ |
| Monday  | 04   | 48.16        |
| Sunday  | 05   | 46.73        |
| Tuesday | 04   | 45.58        |

<img width="800" alt="Dashboard 3 - Fare Breakdown" src="https://github.com/user-attachments/assets/1edfcc55-518b-4bdb-97f8-a7d56870efd4" />

---

# Skills Demonstrated

**SQL** — Data Cleaning, Feature Engineering, Aggregations, Grouping & Filtering, Exploratory Data Analysis

**Power BI** — Dashboard Development, KPI Cards, Interactive Visualizations, Data Storytelling

**Analytics** — Trend Analysis, Demand Analysis, Customer Behavior Analysis, Business Insight Generation

---

# Future Enhancements

* Dynamic Pricing Prediction
* Ride Demand Forecasting
* Weather Impact Analysis
* Azure Cloud Deployment
* Real-Time Dashboard Refresh

---

## Author

**Karthik Peddoju**
Aspiring Data AnalystQL | Power BI | Python | Data Visualization
