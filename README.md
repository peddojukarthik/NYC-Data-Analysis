# NYC Taxi Trip Analysis using SQL & Power BI

<img width="326" height="187" alt="Screenshot 2026-06-05 132111" src="https://github.com/user-attachments/assets/503e67a4-9cf5-4dd4-8206-3ea82ab0f971" />
<img width="328" height="189" alt="Screenshot 2026-06-05 132130" src="https://github.com/user-attachments/assets/7cadce71-dc3f-4017-93c0-a55379c2f373" />
<img width="326" height="186" alt="Screenshot 2026-06-05 132148" src="https://github.com/user-attachments/assets/1edfcc55-518b-4bdb-97f8-a7d56870efd4" />

## Project Overview

This project analyzes over **2.8 million New York City taxi trips** to uncover ride demand patterns, fare trends, and trip behavior across different days and hours.

The goal was to transform raw trip data into actionable business insights using **MySQL** for data cleaning and analysis and **Power BI** for interactive dashboard creation.

---

## Tools & Technologies

* MySQL
* SQL
* Power BI
* Git & GitHub

---

## Dataset

The dataset contains taxi trip information including:

* Pickup Date & Time
* Fare Amount
* Trip Distance
* Passenger Count
* Payment Type
* Trip Duration

---

## Data Cleaning

### Outlier Removal

To improve analysis quality, records with unrealistic values were removed:

* Fare Amount < 0 or > 500
* Trip Distance < 0 or > 100

```sql
CREATE TABLE trips_del_outliers AS
SELECT *
FROM trips
WHERE fare_amount BETWEEN 0 AND 500
AND trip_distance BETWEEN 0 AND 100;
```

### Feature Engineering

Additional columns were created from pickup timestamps:

* Day Name
* Hour of Day

These features enabled day-wise and hour-wise trend analysis.

---

## Business Questions

1. Which day and hour have the highest ride demand?
2. Which periods have the highest average fare?
3. How do weekdays differ from weekends?
4. What time periods generate the most revenue opportunities?
5. How does trip distance vary across the week?

---

# Key Insights

## 1. Peak Ride Demand

Top ride-volume periods:

| Day      | Hour | Total Trips |
| -------- | ---- | ----------- |
| Thursday | 18   | 28,018      |
| Thursday | 17   | 27,319      |
| Thursday | 21   | 25,918      |

### Observation

* Thursday evening recorded the highest demand.
* Wednesday, Thursday, and Friday evenings consistently show strong ride activity.
* Demand is highest during post-office commuting hours.

---

## 2. Highest Average Fare Amount

| Day     | Hour | Average Fare |
| ------- | ---- | ------------ |
| Monday  | 04   | 48.16        |
| Sunday  | 05   | 46.73        |
| Tuesday | 04   | 45.58        |

### Observation

* Highest average fares occur during late-night and early-morning hours.
* Possible reasons:

  * Airport transportation
  * Longer distance rides
  * Reduced driver availability

---

## 3. Weekday vs Weekend Analysis

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

### Findings

* Weekday demand significantly exceeds weekend demand.
* Weekday late-night trips have the highest fares and longest average distances.
* Weekend mornings tend to have longer trips than weekday mornings.

---

# Dashboard Pages

## Dashboard 1: Demand Overview

This dashboard focuses on ride demand patterns across days and hours.

### Key Metrics

* Ride Count by Day
* Ride Count by Hour
* Peak Demand Periods
* Weekday vs Weekend Demand

### Dashboard Preview

<img width="326" height="187" alt="Screenshot 2026-06-05 132111" src="https://github.com/user-attachments/assets/503e67a4-9cf5-4dd4-8206-3ea82ab0f971" />

---

## Dashboard 2: Distance Analysis

This dashboard explores trip distance behavior and travel patterns.

### Key Metrics

* Average Trip Distance
* Distance Trends by Day
* Distance Trends by Hour
* Weekday vs Weekend Comparison

### Dashboard Preview

<img width="328" height="189" alt="Screenshot 2026-06-05 132130" src="https://github.com/user-attachments/assets/fe7afb2d-ca8e-4156-b6e9-0be75f2e62f9" />


---

## Dashboard 3: Fare Breakdown

This dashboard focuses on fare trends and pricing behavior.

### Key Metrics

* Average Fare by Day
* Average Fare by Hour
* Peak Fare Periods
* Fare Distribution Analysis

### Dashboard Preview

<img width="326" height="186" alt="Screenshot 2026-06-05 132148" src="https://github.com/user-attachments/assets/3165ee7e-f94a-4281-b587-8bb6849df307" />

---

# Skills Demonstrated

### SQL

* Data Cleaning
* Feature Engineering
* Aggregations
* Grouping & Filtering
* Exploratory Data Analysis

### Power BI

* Dashboard Development
* KPI Cards
* Interactive Visualizations
* Data Storytelling

### Analytics

* Trend Analysis
* Demand Analysis
* Customer Behavior Analysis
* Business Insight Generation

---

# Future Enhancements

* Dynamic Pricing Prediction
* Ride Demand Forecasting
* Weather Impact Analysis
* Azure Cloud Deployment
* Real-Time Dashboard Refresh

---

---

## Author

**Karthik Peddoju**

Aspiring Data Analyst | SQL | Power BI | Python | Data Visualization
