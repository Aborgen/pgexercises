-- Working With Timestamps
-- https://pgexercises.com/questions/date/

-- Produce a timestamp for 1 a.m. on the 31st of August 2012
-- Produce a timestamp for 1 a.m. on the 31st of August 2012.
SELECT '2012-08-31 01:00:00'::TIMESTAMP;

/*
+---------------------+
| timestamp           |
+---------------------+
| 2012-08-31 01:00:00 |
+---------------------+
*/

-- Subtract timestamps from each other
-- Find the result of subtracting the timestamp '2012-07-30 01:00:00' from the timestamp '2012-08-31 01:00:00'
SELECT '2012-08-31 01:00:00'::TIMESTAMP - '2012-07-30 01:00:00'::TIMESTAMP AS interval;

/*
+----------+
| interval |
+----------+
| 32 days  |
+----------+
 */

-- Generate a list of all the dates in October 2012
-- Produce a list of all the dates in October 2012. They can be output as a timestamp (with time set to midnight) or a date.
SELECT timestamp
FROM GENERATE_SERIES('2012-10-01'::TIMESTAMP, '2012-10-31'::TIMESTAMP, '1 DAYS') AS timestamp;

/*
+---------------------+
| timestamp           |
+---------------------+
| 2012-10-01 00:00:00 |
| 2012-10-02 00:00:00 |
| 2012-10-03 00:00:00 |
| 2012-10-04 00:00:00 |
| 2012-10-05 00:00:00 |
| 2012-10-06 00:00:00 |
| 2012-10-07 00:00:00 |
| 2012-10-08 00:00:00 |
| 2012-10-09 00:00:00 |
| 2012-10-10 00:00:00 |
| 2012-10-11 00:00:00 |
| 2012-10-12 00:00:00 |
| 2012-10-13 00:00:00 |
| 2012-10-14 00:00:00 |
| 2012-10-15 00:00:00 |
| 2012-10-16 00:00:00 |
| 2012-10-17 00:00:00 |
| 2012-10-18 00:00:00 |
| 2012-10-19 00:00:00 |
| 2012-10-20 00:00:00 |
| 2012-10-21 00:00:00 |
| 2012-10-22 00:00:00 |
| 2012-10-23 00:00:00 |
| 2012-10-24 00:00:00 |
| 2012-10-25 00:00:00 |
| 2012-10-26 00:00:00 |
| 2012-10-27 00:00:00 |
| 2012-10-28 00:00:00 |
| 2012-10-29 00:00:00 |
| 2012-10-30 00:00:00 |
| 2012-10-31 00:00:00 |
+---------------------+
*/

-- Get the day of the month from a timestamp
-- Get the day of the month from the timestamp '2012-08-31' as an integer.
SELECT EXTRACT(DAY FROM '2012-08-31'::TIMESTAMP)::INT AS dayOfMonth;

/*
+------------+
| dayofmonth |
+------------+
| 31         |
+------------+
*/

-- Work out the number of seconds between timestamps
-- Work out the number of seconds between the timestamps '2012-08-31 01:00:00' and '2012-09-02 00:00:00'
SELECT EXTRACT(EPOCH FROM '2012-09-02 00:00:00'::TIMESTAMP - '2012-08-31 01:00:00'::TIMESTAMP) AS seconds;

/*
+---------+
| seconds |
+---------+
| 169200  |
+---------+
*/

-- Work out the number of days in each month of 2012
-- For each month of the year in 2012, output the number of days in that month. Format the output as
-- an integer column containing the month of the year, and a second column containing an interval data type.
SELECT EXTRACT(MONTH FROM days)::INT AS month, CONCAT(COUNT(*), ' days')::INTERVAL AS days
FROM GENERATE_SERIES('2012-01-01'::TIMESTAMP, '2012-12-31'::TIMESTAMP, '1 DAY') AS days
GROUP BY month
ORDER BY month;

/*
+-------+---------+
| month | days    |
+-------+---------+
| 1     | 31 days |
| 2     | 29 days |
| 3     | 31 days |
| 4     | 30 days |
| 5     | 31 days |
| 6     | 30 days |
| 7     | 31 days |
| 8     | 31 days |
| 9     | 30 days |
| 10    | 31 days |
| 11    | 30 days |
| 12    | 31 days |
+-------+---------+
*/

-- Work out the number of days remaining in the month
-- For any given timestamp, work out the number of days remaining in the month. The current day should count as
-- a whole day, regardless of the time. Use '2012-02-11 01:00:00' as an example timestamp for the purposes of
-- making the answer. Format the output as a single interval value.
SELECT (DATE_TRUNC('MONTH', timestamp) + '1 MONTH'::INTERVAL) - DATE_TRUNC('DAY', timestamp) AS daysRemaining
FROM (SELECT '2012-02-11 01:00:00'::TIMESTAMP AS timestamp) AS date;

/*
+---------------+
| daysremaining |
+---------------+
| 19 days       |
+---------------+
*/

-- Work out the end time of bookings
-- Return a list of the start and end time of the last 10 bookings (ordered by the time at
-- which they end, followed by the time at which they start) in the system.
SELECT starttime, starttime + '30 MINUTE'::INTERVAL * slots AS endtime
FROM cd.bookings
ORDER BY endtime DESC, starttime DESC
LIMIT 10;

/*
+---------------------+---------------------+
| starttime           | endtime             |
+---------------------+---------------------+
| 2013-01-01 15:30:00 | 2013-01-01 16:00:00 |
| 2012-09-30 19:30:00 | 2012-09-30 20:30:00 |
| 2012-09-30 19:00:00 | 2012-09-30 20:30:00 |
| 2012-09-30 19:30:00 | 2012-09-30 20:00:00 |
| 2012-09-30 19:00:00 | 2012-09-30 20:00:00 |
| 2012-09-30 19:00:00 | 2012-09-30 20:00:00 |
| 2012-09-30 18:30:00 | 2012-09-30 20:00:00 |
| 2012-09-30 18:30:00 | 2012-09-30 20:00:00 |
| 2012-09-30 19:00:00 | 2012-09-30 19:30:00 |
| 2012-09-30 18:30:00 | 2012-09-30 19:30:00 |
+---------------------+---------------------+
*/

-- Return a count of bookings for each month
-- Return a count of bookings for each month, sorted by month
SELECT DATE_TRUNC('MONTH', starttime) AS month, COUNT(*) AS bookings
FROM cd.bookings
GROUP BY month
ORDER BY month;

/*
+---------------------+----------+
| month               | bookings |
+---------------------+----------+
| 2012-07-01 00:00:00 | 658      |
| 2012-08-01 00:00:00 | 1472     |
| 2012-09-01 00:00:00 | 1913     |
| 2013-01-01 00:00:00 | 1        |
+---------------------+----------+
*/

-- Work out the utilisation percentage for each facility by month
-- Work out the utilisation percentage for each facility by month, sorted by name and month, rounded to 
-- 1 decimal place. Opening time is 8am, closing time is 8.30pm. You can treat every month as a full month,
-- regardless of if there were some dates the club was not open.
SELECT name, month, ROUND(slotsUsed / SUM(
  (
    SELECT (COUNT(days) - 1) * 25 /*half hour slots in shift*/ AS slotsAvailable
    FROM GENERATE_SERIES(month, month + '1 MONTH'::INTERVAL, '1 DAY') AS days
  )
)::NUMERIC * 100, 1) AS utilization 
FROM (
  SELECT f.name, DATE_TRUNC('MONTH', starttime) AS month, SUM(slots) AS slotsUsed
  FROM cd.bookings AS b
  JOIN cd.facilities AS f
  ON b.facid = f.facid
  GROUP BY f.name, month
) AS x
GROUP BY name, month, slotsUsed
ORDER BY name, month;

/*
+-----------------+---------------------+-------------+
| name            | month               | utilization |
+-----------------+---------------------+-------------+
| Badminton Court | 2012-07-01 00:00:00 | 23.2        |
| Badminton Court | 2012-08-01 00:00:00 | 59.2        |
| Badminton Court | 2012-09-01 00:00:00 | 76.0        |
| Massage Room 1  | 2012-07-01 00:00:00 | 34.1        |
| Massage Room 1  | 2012-08-01 00:00:00 | 63.5        |
| Massage Room 1  | 2012-09-01 00:00:00 | 86.4        |
| Massage Room 2  | 2012-07-01 00:00:00 | 3.1         |
| Massage Room 2  | 2012-08-01 00:00:00 | 10.6        |
| Massage Room 2  | 2012-09-01 00:00:00 | 16.3        |
| Pool Table      | 2012-07-01 00:00:00 | 15.1        |
| Pool Table      | 2012-08-01 00:00:00 | 41.5        |
| Pool Table      | 2012-09-01 00:00:00 | 62.8        |
| Pool Table      | 2013-01-01 00:00:00 | 0.1         |
| Snooker Table   | 2012-07-01 00:00:00 | 20.1        |
| Snooker Table   | 2012-08-01 00:00:00 | 42.1        |
| Snooker Table   | 2012-09-01 00:00:00 | 56.8        |
| Squash Court    | 2012-07-01 00:00:00 | 21.2        |
| Squash Court    | 2012-08-01 00:00:00 | 51.6        |
| Squash Court    | 2012-09-01 00:00:00 | 72.0        |
| Table Tennis    | 2012-07-01 00:00:00 | 13.4        |
| Table Tennis    | 2012-08-01 00:00:00 | 39.2        |
| Table Tennis    | 2012-09-01 00:00:00 | 56.3        |
| Tennis Court 1  | 2012-07-01 00:00:00 | 34.8        |
| Tennis Court 1  | 2012-08-01 00:00:00 | 59.2        |
| Tennis Court 1  | 2012-09-01 00:00:00 | 78.8        |
| Tennis Court 2  | 2012-07-01 00:00:00 | 26.7        |
| Tennis Court 2  | 2012-08-01 00:00:00 | 62.3        |
| Tennis Court 2  | 2012-09-01 00:00:00 | 78.4        |
+-----------------+---------------------+-------------+
*/

