use dynamic_pricing_db;

SELECT COUNT(*) FROM trips; #total rows 3M

/*
SELECT COUNT(*) FROM trips WHERE trip_distance <= 0; #90893

SELECT COUNT(*) FROM trips WHERE fare_amount <= 0; #145516

select count(*) from trips where passenger_count <= 0; #24656
select count(*) from trips where passenger_count is NULL; #540149
*/

SELECT
    passenger_count,
    payment_type
FROM trips
WHERE passenger_count <= 0
   OR passenger_count IS NULL;

SET SESSION net_read_timeout = 600;
SET SESSION net_write_timeout = 600;
SET SESSION wait_timeout = 600;

/* clean table
CREATE TABLE trips_clean AS

SELECT
    pickup_datetime,
    dropoff_datetime,
    passenger_count,
    trip_distance,
    pickup_location_id,
    dropoff_location_id,
    payment_type,
    fare_amount,
    tip_amount,
    total_amount

FROM trips

WHERE passenger_count > 0
AND fare_amount > 0
AND trip_distance > 0
AND total_amount > 0;

*/

SELECT
    HOUR(pickup_datetime) AS hour_of_day,
    COUNT(*) AS total_rides
FROM trips_clean
GROUP BY hour_of_day
ORDER BY total_rides DESC; #peak houes

WITH dayvshour AS (
SELECT
    DAYNAME(pickup_datetime) AS day_name,
    HOUR(pickup_datetime) AS hour_of_day,
	COUNT(*) AS total_rides,
	ROUND(AVG(total_amount), 2) AS avg_trip_price,
	ROUND(AVG(trip_distance), 2) AS avg_distance,
	ROUND(AVG(total_amount/trip_distance), 2) AS price_per_distance
FROM trips_clean
WHERE trip_distance > 1
GROUP BY day_name, hour_of_day
)

SELECT *
FROM dayvshour
ORDER BY price_per_distance DESC;
-- monday 12 is sus

SELECT
    pickup_datetime,
    trip_distance,
    total_amount,
    total_amount/trip_distance AS price_per_distance
FROM trips_clean
WHERE DAYNAME(pickup_datetime) = 'Monday'
AND HOUR(pickup_datetime) = 12
ORDER BY price_per_distance DESC;

select date(pickup_datetime), payment_type, total_amount, trip_distance, avg(total_amount/trip_distance) as avg_price_mon from trips_clean
where dayname(pickup_datetime) = 'monday'
and hour(pickup_datetime)= 12
group by total_amount, trip_distance, date(pickup_datetime), payment_type
order by avg_price_mon desc;

select *, (total_amount/trip_distance) from trips_clean
where dayname(pickup_datetime) = 'monday'
and hour(pickup_datetime)= 12
order by total_amount desc;

/* days hour avg amonut */
SELECT
    DAYNAME(pickup_datetime) AS day_name,
    EXTRACT(HOUR FROM pickup_datetime) AS trip_hour,
    AVG(total_amount) AS avg_amount,
    COUNT(*) AS total_rides
FROM trips_clean
GROUP BY
    DAYNAME(pickup_datetime),
    EXTRACT(HOUR FROM pickup_datetime)
ORDER BY
    trip_hour,
    avg_amount DESC;
    
/* trying to remove outliner */
SELECT
    fare_amount
FROM trips_clean
WHERE DAYNAME(pickup_datetime)='Monday'
AND HOUR(pickup_datetime)=12
ORDER BY fare_amount DESC
LIMIT 20;

/* treating outliner by creating a table*/
CREATE TABLE trips_del_outliners AS
SELECT *
FROM trips_clean
WHERE
    fare_amount BETWEEN 0 AND 500
    AND trip_distance > 0
    AND trip_distance < 100; #2816767
    
select dayname(pickup_datetime) as day,hour(pickup_datetime)AS HOUR_DAY,  trip_distance, fare_amount, total_amount, (fare_amount/trip_distance) AS PER_MILE
from trips_del_outliners
where dayname(pickup_datetime)='Monday' AND hour(pickup_datetime)=12
order by fare_amount desc;

select max(TRIP_DISTANCE) FROM TRIPS_DEL_OUTLINERS;

/* AFTER OUTLINERS QUERIES */
WITH dayvshour AS (
SELECT
    DAYNAME(pickup_datetime) AS day_name,
    HOUR(pickup_datetime) AS hour_of_day,
	COUNT(*) AS total_rides,
	ROUND(AVG(total_amount), 2) AS avg_trip_price,
	ROUND(AVG(trip_distance), 2) AS avg_distance,
	ROUND(AVG(total_amount/trip_distance), 2) AS price_per_distance
FROM trips_del_outliners
WHERE trip_distance > 1
GROUP BY day_name, hour_of_day
)

SELECT day_name, hour_of_day, total_rides,avg_trip_price
FROM dayvshour
ORDER BY total_rides DESC;
 # change order by to get required output
 /* insights
  1. thursday 18 has the highest rides (28018) 
Thursday	18	28018
Thursday	17	27319
Thursday	21	25918  top three rows and all during evening to night hours 17-21(5-9)
						in more depth wed, thu, fri evenings are more peak than weekends
                        PR: office hours
 2. moday 4 has highest avg trip price (48.16)
Monday	4	842		48.16
Sunday	5	1315	46.73
Tuesday	4	609		45.58   highest avg trip price are mostly during late night to morning hour
						    PR: high price may be due to airport rides, less drivers high demand 
 3. price during peak hours
31.95		48.16
33.81   vs	46.73
31.06       45.58  
 4. weekdays vs weekends
Weekday	Afternoon					28		3.09	813473
Weekday	Evening / Night				27.88	3.2		715078
Weekday	Late Night / Early Morning	31.98	4.58	90727
Weekday	Morning						25.95	2.98	500600
Weekend	Afternoon					26.44	3.12	274279
Weekend	Evening / Night				27.61	3.37	213462
Weekend	Late Night / Early Morning	24.93	2.94	94379
Weekend	Morning						26		3.4		114769  weekday has more days though than weekends 
															weekend late night low demand than weekday late night could be
*/
 
 SELECT
    CASE
        WHEN DAYNAME(pickup_datetime) IN ('Saturday','Sunday')
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    CASE
        WHEN HOUR(pickup_datetime) BETWEEN 0 AND 5
            THEN 'Late Night / Early Morning'
        WHEN HOUR(pickup_datetime) BETWEEN 6 AND 11
            THEN 'Morning'
        WHEN HOUR(pickup_datetime) BETWEEN 12 AND 17
            THEN 'Afternoon'
        ELSE 'Evening / Night'
    END AS time_category,
	ROUND(AVG(total_amount),2) AS avg_total_amount,
    ROUND(AVG(trip_distance),2) AS avg_distance,
    COUNT(*) AS total_rides
FROM trips_del_outliners
GROUP BY day_type, time_category
ORDER BY
    avg_total_amount desc;
    
select * from trips_del_outliners;

/* adding colummns */
-- SET SQL_SAFE_UPDATES = 1;

alter table trips_del_outliners
add column hour_of_day int;
UPDATE trips_del_outliners
SET hour_of_day = HOUR(pickup_datetime);

ALTER TABLE trips_del_outliners
ADD COLUMN day_name VARCHAR(20);
UPDATE trips_del_outliners
SET day_name = DAYNAME(pickup_datetime);

ALTER TABLE trips_del_outliners
ADD COLUMN day_type VARCHAR(10);
UPDATE trips_del_outliners
SET day_type =
CASE
    WHEN day_name IN ('Saturday','Sunday')
    THEN 'Weekend'
    ELSE 'Weekday'
END;

ALTER TABLE trips_del_outliners
ADD COLUMN time_category VARCHAR(30);
UPDATE trips_del_outliners
SET time_category =
CASE
    WHEN hour_of_day >= 6 AND hour_of_day < 12
        THEN 'Morning'

    WHEN hour_of_day >= 12 AND hour_of_day < 18
        THEN 'Afternoon'

    WHEN hour_of_day >= 18 AND hour_of_day < 24
        THEN 'Evening / Night'

    ELSE 'Late Night / Early Morning'
END;
/* added columns */
select * from trips_del_outliners;

/* verifying visuals */
select day_type, day_name, hour_of_day, count(*) as rides from trips_del_outliners
group by day_type, day_name, hour_of_day
order by rides desc;