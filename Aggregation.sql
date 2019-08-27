-- Aggregation
-- https://pgexercises.com/questions/aggregates/

-- Count the number of facilities
-- For our first foray into aggregates, we're going to stick to something simple.
-- We want to know how many facilities exist - simply produce a total count.
SELECT COUNT(*)
FROM cd.facilities;

/*
+-------+
| count |
+-------+
| 9     |
+-------+
*/

-- Count the number of expensive facilities
-- Produce a count of the number of facilities that have a cost to guests of 10 or more.
SELECT COUNT(*)
FROM cd.facilities
WHERE guestcost >= 10;

/*
+-------+
| count |
+-------+
| 6     |
+-------+
*/

-- Count the number of recommendations each member makes.
-- Produce a count of the number of recommendations each member has made. Order by member ID.
SELECT recommendedby AS memid, COUNT(*)
FROM cd.members
WHERE recommendedby IS NOT NULL
GROUP BY recommendedby
ORDER BY memid;

/*
+-------+-------+
| memid | count |
+-------+-------+
| 1     | 5     |
| 2     | 3     |
| 3     | 1     |
| 4     | 2     |
| 5     | 1     |
| 6     | 1     |
| 9     | 2     |
| 11    | 1     |
| 13    | 2     |
| 15    | 1     |
| 16    | 1     |
| 20    | 1     |
| 30    | 1     |
+-------+-------+
*/

-- List the total slots booked per facility
-- Produce a list of the total number of slots booked per facility. For now, just produce
-- an output table consisting of facility id and slots, sorted by facility id.
SELECT facid, SUM(slots) AS totalSlots
FROM cd.bookings AS b
GROUP BY facid
ORDER BY facid;

/*
+-------+------------+
| facid | totalslots |
+-------+------------+
| 0     | 1320       |
| 1     | 1278       |
| 2     | 1209       |
| 3     | 830        |
| 4     | 1404       |
| 5     | 228        |
| 6     | 1104       |
| 7     | 908        |
| 8     | 911        |
+-------+------------+
*/

-- List the total slots booked per facility in a given month
-- Produce a list of the total number of slots booked per facility in the month of September 2012.
-- Produce an output table consisting of facility id and slots, sorted by the number of slots.
SELECT facid, SUM(slots) AS totalSlots
FROM cd.bookings
WHERE starttime BETWEEN '2012-09-01 00:00:00' AND
                        '2012-09-30 23:59:59'
GROUP BY facid
ORDER BY totalSlots;

/*
+-------+------------+
| facid | totalslots |
+-------+------------+
| 5     | 122        |
| 3     | 422        |
| 7     | 426        |
| 8     | 471        |
| 6     | 540        |
| 2     | 570        |
| 1     | 588        |
| 0     | 591        |
| 4     | 648        |
+-------+------------+
*/

-- List the total slots booked per facility per month
-- Produce a list of the total number of slots booked per facility per month in the year of 2012.
-- Produce an output table consisting of facility id and slots, sorted by the id and month.
SELECT facid, EXTRACT(MONTH FROM starttime) AS month, SUM(slots) AS totalSlots
FROM cd.bookings
WHERE EXTRACT(YEAR FROM starttime) = 2012
GROUP BY facid, month
ORDER BY facid, month;

/*
+-------+-------+------------+
| facid | month | totalslots |
+-------+-------+------------+
| 0     | 7     | 270        |
| 0     | 8     | 459        |
| 0     | 9     | 591        |
| 1     | 7     | 207        |
| 1     | 8     | 483        |
| 1     | 9     | 588        |
| 2     | 7     | 180        |
| 2     | 8     | 459        |
| 2     | 9     | 570        |
| 3     | 7     | 104        |
| 3     | 8     | 304        |
| 3     | 9     | 422        |
| 4     | 7     | 264        |
| 4     | 8     | 492        |
| 4     | 9     | 648        |
| 5     | 7     | 24         |
| 5     | 8     | 82         |
| 5     | 9     | 122        |
| 6     | 7     | 164        |
| 6     | 8     | 400        |
| 6     | 9     | 540        |
| 7     | 7     | 156        |
| 7     | 8     | 326        |
| 7     | 9     | 426        |
| 8     | 7     | 117        |
| 8     | 8     | 322        |
| 8     | 9     | 471        |
+-------+-------+------------+
*/

-- Find the count of members who have made at least one booking
-- Find the total number of members who have made at least one booking.
SELECT COUNT(DISTINCT memid)
FROM cd.bookings;

/*
+-------+
| count |
+-------+
| 30    |
+-------+
*/

-- List facilities with more than 1000 slots booked
-- Produce a list of facilities with more than 1000 slots booked.
-- Produce an output table consisting of facility id and hours, sorted by facility id.
SELECT facid, SUM(slots) AS totalSlots
FROM cd.bookings
GROUP BY facid
HAVING SUM(slots) > 1000
ORDER BY facid;

/*
+-------+------------+
| facid | totalslots |
+-------+------------+
| 0     | 1320       |
| 1     | 1278       |
| 2     | 1209       |
| 4     | 1404       |
| 6     | 1104       |
+-------+------------+
*/

-- Find the total revenue of each facility
-- Produce a list of facilities along with their total revenue. The output table should consist of
-- facility name and revenue, sorted by revenue. Remember that there's a different cost for guests and members!
SELECT f.name, SUM(cost) AS revenue
FROM cd.facilities AS f
JOIN (
  SELECT f.facid,
  CASE WHEN memid = 0
    THEN guestcost * slots
    ELSE membercost * slots
  END AS cost
  FROM cd.bookings AS b
  JOIN cd.facilities AS f
  ON b.facid = f.facid
) AS x
ON f.facid = x.facid
GROUP BY f.name
ORDER BY revenue;

/*
+-----------------+---------+
| name            | revenue |
+-----------------+---------+
| Table Tennis    | 180     |
| Snooker Table   | 240     |
| Pool Table      | 270     |
| Badminton Court | 1906.5  |
| Squash Court    | 13468.0 |
| Tennis Court 1  | 13860   |
| Tennis Court 2  | 14310   |
| Massage Room 2  | 15810   |
| Massage Room 1  | 72540   |
+-----------------+---------+
*/

-- Find facilities with a total revenue less than 1000
-- Produce a list of facilities with a total revenue less than 1000. Produce an output table consisting of
-- facility name and revenue, sorted by revenue. Remember that there's a different cost for guests and members!
SELECT f.name, SUM(cost) AS revenue
FROM cd.facilities AS f
JOIN (
  SELECT f.facid,
  CASE WHEN memid = 0
    THEN guestcost * slots
    ELSE membercost * slots
  END AS cost
  FROM cd.bookings AS b
  JOIN cd.facilities AS f
  ON b.facid = f.facid
) AS x
ON f.facid = x.facid
GROUP BY f.name
HAVING SUM(cost) < 1000
ORDER BY revenue;

/*
+---------------+---------+
| name          | revenue |
+---------------+---------+
| Table Tennis  | 180     |
| Snooker Table | 240     |
| Pool Table    | 270     |
+---------------+---------+
*/

-- Output the facility id that has the highest number of slots booked
-- Output the facility id that has the highest number of slots booked.
-- For bonus points, try a version without a LIMIT clause. This version will probably look messy!
WITH slots_per_booking (facid, totalSlots) AS
(
  SELECT facid, SUM(slots)
  FROM cd.bookings
  GROUP BY facid
)

SELECT facid, totalSlots
FROM slots_per_booking
WHERE totalSlots = (
  SELECT MAX(totalSlots)
  FROM slots_per_booking
);

/*
+--------+-------------+
| facid  | Total Slots |
+--------+-------------+
| 4      | 1404        |
+--------+-------------+
*/

-- List the total slots booked per facility per month, part 2
-- Produce a list of the total number of slots booked per facility per month in the year of 2012.
-- In this version, include output rows containing totals for all months per facility, and a total for
-- all months for all facilities. The output table should consist of facility id, month and slots, sorted by
-- the id and month. When calculating the aggregated values for all months and all facids, return null values in
-- the month and facid columns.
SELECT facid, EXTRACT(MONTH FROM starttime) AS month, SUM(slots) AS totalSlots
FROM cd.bookings
WHERE EXTRACT(YEAR FROM starttime) = 2012
GROUP BY ROLLUP(facid, month)
ORDER BY facid, month;

/*
+-------+-------+------------+
| facid | month | totalslots |
+-------+-------+------------+
| 0     | 7     | 270        |
| 0     | 8     | 459        |
| 0     | 9     | 591        |
| 0     |       | 1320       |
| 1     | 7     | 207        |
| 1     | 8     | 483        |
| 1     | 9     | 588        |
| 1     |       | 1278       |
| 2     | 7     | 180        |
| 2     | 8     | 459        |
| 2     | 9     | 570        |
| 2     |       | 1209       |
| 3     | 7     | 104        |
| 3     | 8     | 304        |
| 3     | 9     | 422        |
| 3     |       | 830        |
| 4     | 7     | 264        |
| 4     | 8     | 492        |
| 4     | 9     | 648        |
| 4     |       | 1404       |
| 5     | 7     | 24         |
| 5     | 8     | 82         |
| 5     | 9     | 122        |
| 5     |       | 228        |
| 6     | 7     | 164        |
| 6     | 8     | 400        |
| 6     | 9     | 540        |
| 6     |       | 1104       |
| 7     | 7     | 156        |
| 7     | 8     | 326        |
| 7     | 9     | 426        |
| 7     |       | 908        |
| 8     | 7     | 117        |
| 8     | 8     | 322        |
| 8     | 9     | 471        |
| 8     |       | 910        |
|       |       | 9191       |
+-------+-------+------------+
*/

-- List the total hours booked per named facility
-- Produce a list of the total number of hours booked per facility, remembering that a slot lasts half an hour.
-- The output table should consist of the facility id, name, and hours booked, sorted by facility id. Try formatting
-- the hours to two decimal places.
SELECT f.facid, name, ROUND(SUM(slots) / 2.0, 2) AS hours
FROM cd.bookings AS b
JOIN cd.facilities AS f
ON b.facid = f.facid
GROUP BY f.facid, name
ORDER BY f.facid;

/*
+-------+-----------------+--------+
| facid | name            | hours  |
+-------+-----------------+--------+
| 0     | Tennis Court 1  | 660.00 |
| 1     | Tennis Court 2  | 639.00 |
| 2     | Badminton Court | 604.50 |
| 3     | Table Tennis    | 415.00 |
| 4     | Massage Room 1  | 702.00 |
| 5     | Massage Room 2  | 114.00 |
| 6     | Squash Court    | 552.00 |
| 7     | Snooker Table   | 454.00 |
| 8     | Pool Table      | 455.50 |
+-------+-----------------+--------+
*/

-- List each member's first booking after September 1st 2012
-- Produce a list of each member name, id, and their first booking after September 1st 2012. Order by member ID.
-- NOTE: This query works! However, the application fails without giving me an error message.
SELECT firstname, surname, memid, (
  SELECT MIN(starttime)
  FROM cd.bookings AS b
  WHERE m.memid = b.memid AND
        starttime > '2012-09-01 23:59:59'
) AS starttime
FROM cd.members AS m
ORDER BY memid;

/*
+--------------------+------------+--------+---------------------+
| surname            | firstname  | memid  | starttime           |
+--------------------+------------+--------+---------------------+
| GUEST              | GUEST      | 0      | 2012-09-01 08:00:00 |
| Smith              | Darren     | 1      | 2012-09-01 09:00:00 |
| Smith              | Tracy      | 2      | 2012-09-01 11:30:00 |
| Rownam             | Tim        | 3      | 2012-09-01 16:00:00 |
| Joplette           | Janice     | 4      | 2012-09-01 15:00:00 |
| Butters            | Gerald     | 5      | 2012-09-02 12:30:00 |
| Tracy              | Burton     | 6      | 2012-09-01 15:00:00 |
| Dare               | Nancy      | 7      | 2012-09-01 12:30:00 |
| Boothe             | Tim        | 8      | 2012-09-01 08:30:00 |
| Stibbons           | Ponder     | 9      | 2012-09-01 11:00:00 |
| Owen               | Charles    | 10     | 2012-09-01 11:00:00 |
| Jones              | David      | 11     | 2012-09-01 09:30:00 |
| Baker              | Anne       | 12     | 2012-09-01 14:30:00 |
| Farrell            | Jemima     | 13     | 2012-09-01 09:30:00 |
| Smith              | Jack       | 14     | 2012-09-01 11:00:00 |
| Bader              | Florence   | 15     | 2012-09-01 10:30:00 |
| Baker              | Timothy    | 16     | 2012-09-01 15:00:00 |
| Pinker             | David      | 17     | 2012-09-01 08:30:00 |
| Genting            | Matthew    | 20     | 2012-09-01 18:00:00 |
| Mackenzie          | Anna       | 21     | 2012-09-01 08:30:00 |
| Coplin             | Joan       | 22     | 2012-09-02 11:30:00 |
| Sarwin             | Ramnaresh  | 24     | 2012-09-04 11:00:00 |
| Jones              | Douglas    | 26     | 2012-09-08 13:00:00 |
| Rumney             | Henrietta  | 27     | 2012-09-16 13:30:00 |
| Farrell            | David      | 28     | 2012-09-18 09:00:00 |
| Worthington-Smyth  | Henry      | 29     | 2012-09-19 09:30:00 |
| Purview            | Millicent  | 30     | 2012-09-19 11:30:00 |
| Tupperware         | Hyacinth   | 33     | 2012-09-20 08:00:00 |
| Hunt               | John       | 35     | 2012-09-23 14:00:00 |
| Crumpet            | Erica      | 36     | 2012-09-27 11:30:00 |
+--------------------+------------+--------+---------------------+
*/

-- Produce a list of member names, with each row containing the total member count
-- Produce a list of member names, with each row containing the total member count. Order by join date.
SELECT (
  SELECT COUNT(*)
  FROM cd.members
) AS count, firstname, surname
FROM cd.members

/*
+-------+-----------+-------------------+
| count | firstname | surname           |
+-------+-----------+-------------------+
| 31    | GUEST     | GUEST             |
| 31    | Darren    | Smith             |
| 31    | Tracy     | Smith             |
| 31    | Tim       | Rownam            |
| 31    | Janice    | Joplette          |
| 31    | Gerald    | Butters           |
| 31    | Burton    | Tracy             |
| 31    | Nancy     | Dare              |
| 31    | Tim       | Boothe            |
| 31    | Ponder    | Stibbons          |
| 31    | Charles   | Owen              |
| 31    | David     | Jones             |
| 31    | Anne      | Baker             |
| 31    | Jemima    | Farrell           |
| 31    | Jack      | Smith             |
| 31    | Florence  | Bader             |
| 31    | Timothy   | Baker             |
| 31    | David     | Pinker            |
| 31    | Matthew   | Genting           |
| 31    | Anna      | Mackenzie         |
| 31    | Joan      | Coplin            |
| 31    | Ramnaresh | Sarwin            |
| 31    | Douglas   | Jones             |
| 31    | Henrietta | Rumney            |
| 31    | David     | Farrell           |
| 31    | Henry     | Worthington-Smyth |
| 31    | Millicent | Purview           |
| 31    | Hyacinth  | Tupperware        |
| 31    | John      | Hunt              |
| 31    | Erica     | Crumpet           |
| 31    | Darren    | Smith             |
+-------+-----------+-------------------+
*/

-- Produce a numbered list of members
-- Produce a monotonically increasing numbered list of members, ordered by their date of joining.
-- Remember that member IDs are not guaranteed to be sequential.
SELECT ROW_NUMBER() OVER(ORDER BY joindate), firstname, surname
FROM cd.members
ORDER BY joindate;

/*
+------------+-----------+-------------------+
| row_number | firstname | surname           |
+------------+-----------+-------------------+
| 1          | GUEST     | GUEST             |
| 2          | Darren    | Smith             |
| 3          | Tracy     | Smith             |
| 4          | Tim       | Rownam            |
| 5          | Janice    | Joplette          |
| 6          | Gerald    | Butters           |
| 7          | Burton    | Tracy             |
| 8          | Nancy     | Dare              |
| 9          | Tim       | Boothe            |
| 10         | Ponder    | Stibbons          |
| 11         | Charles   | Owen              |
| 12         | David     | Jones             |
| 13         | Anne      | Baker             |
| 14         | Jemima    | Farrell           |
| 15         | Jack      | Smith             |
| 16         | Florence  | Bader             |
| 17         | Timothy   | Baker             |
| 18         | David     | Pinker            |
| 19         | Matthew   | Genting           |
| 20         | Anna      | Mackenzie         |
| 21         | Joan      | Coplin            |
| 22         | Ramnaresh | Sarwin            |
| 23         | Douglas   | Jones             |
| 24         | Henrietta | Rumney            |
| 25         | David     | Farrell           |
| 26         | Henry     | Worthington-Smyth |
| 27         | Millicent | Purview           |
| 28         | Hyacinth  | Tupperware        |
| 29         | John      | Hunt              |
| 30         | Erica     | Crumpet           |
| 31         | Darren    | Smith             |
+------------+-----------+-------------------+
*/

-- Output the facility id that has the highest number of slots booked, again
-- Output the facility id that has the highest number of slots booked.
-- Ensure that in the event of a tie, all tieing results get output.
-- NOTE: The point of this exercise--we are told after getting the correct result set--is to use
--       the RANK function over the sum of slots, descending. The author argues that this method
--       of doing things makes semantically more sense. I am not currently in a position where I
--       would have come up with the listed solution. Window functions are still very new to me.
WITH slots_per_booking (facid, totalSlots) AS
(
  SELECT facid, SUM(slots)
  FROM cd.bookings
  GROUP BY facid
)

SELECT facid, totalSlots
FROM slots_per_booking
WHERE totalSlots = (
  SELECT MAX(totalSlots)
  FROM slots_per_booking
);

/*
Intended solution:
SELECT facid, total
FROM (
  SELECT facid, SUM(slots) AS total, RANK() OVER (ORDER by SUM(slots) DESC) AS rank
  FROM cd.bookings
  GROUP BY facid
) AS ranked
WHERE rank = 1

+--------+-------+
| facid  | total |
+--------+-------+
| 4      | 1404  |
+--------+-------+
*/

-- Rank members by (rounded) hours used
-- Produce a list of members, along with the number of hours they've booked in facilities, rounded to
-- the nearest ten hours. Rank them by this rounded figure, producing output of first name, surname,
-- rounded hours, rank. Sort by rank, surname, and first name.
SELECT firstname, surname, ROUND(SUM(slots) / 2, -1) AS hours,
       RANK() OVER(ORDER BY ROUND(SUM(slots) / 2, -1) DESC) AS rank
FROM cd.bookings AS b
JOIN cd.members AS m
ON b.memid = m.memid
GROUP BY firstname, surname
ORDER BY rank, surname, firstname;

/*
+-----------+-------------------+-------+------+
| firstname | surname           | hours | rank |
+-----------+-------------------+-------+------+
| GUEST     | GUEST             | 1200  | 1    |
| Darren    | Smith             | 340   | 2    |
| Tim       | Rownam            | 330   | 3    |
| Tim       | Boothe            | 220   | 4    |
| Tracy     | Smith             | 220   | 4    |
| Gerald    | Butters           | 210   | 6    |
| Burton    | Tracy             | 180   | 7    |
| Charles   | Owen              | 170   | 8    |
| Janice    | Joplette          | 160   | 9    |
| Anne      | Baker             | 150   | 10   |
| Timothy   | Baker             | 150   | 10   |
| David     | Jones             | 150   | 10   |
| Nancy     | Dare              | 130   | 13   |
| Florence  | Bader             | 120   | 14   |
| Anna      | Mackenzie         | 120   | 14   |
| Ponder    | Stibbons          | 120   | 14   |
| Jack      | Smith             | 110   | 17   |
| Jemima    | Farrell           | 90    | 18   |
| David     | Pinker            | 80    | 19   |
| Ramnaresh | Sarwin            | 80    | 19   |
| Matthew   | Genting           | 70    | 21   |
| Joan      | Coplin            | 50    | 22   |
| David     | Farrell           | 30    | 23   |
| Henry     | Worthington-Smyth | 30    | 23   |
| John      | Hunt              | 20    | 25   |
| Douglas   | Jones             | 20    | 25   |
| Millicent | Purview           | 20    | 25   |
| Henrietta | Rumney            | 20    | 25   |
| Erica     | Crumpet           | 10    | 29   |
| Hyacinth  | Tupperware        | 10    | 29   |
+-----------+-------------------+-------+------+
*/

-- Find the top three revenue generating facilities
-- Produce a list of the top three revenue generating facilities (including ties).
-- Output facility name and rank, sorted by rank and facility name.
SELECT name, rank 
FROM (
  SELECT f.name,
    DENSE_RANK() OVER(ORDER BY SUM(
      CASE WHEN memid = 0
        THEN guestcost * slots
        ELSE membercost * slots
      END
    ) DESC) AS rank
  FROM cd.bookings AS b
  JOIN cd.facilities AS f
  ON b.facid = f.facid
  GROUP BY f.name) AS x
WHERE rank BETWEEN 1 AND 3
ORDER BY rank, name;

/*
+----------------+------+
| name           | rank |
+----------------+------+
| Massage Room 1 | 1    |
| Massage Room 2 | 2    |
| Tennis Court 2 | 3    |
+----------------+------+
*/

-- Classify facilities by value
-- Classify facilities into equally sized groups of high, average, and low based on their revenue. Order by classification and facility name.
SELECT name,
  CASE bucket
    WHEN 1 THEN 'high'
    WHEN 2 THEN 'average'
    WHEN 3 THEN 'low'
  END AS revenue
FROM (
  SELECT f.name,
    NTILE(3) OVER(ORDER BY SUM(
      CASE WHEN memid = 0
        THEN guestcost * slots
        ELSE membercost * slots
      END
    ) DESC) AS bucket
  FROM cd.bookings AS b
  JOIN cd.facilities AS f
  ON b.facid = b.facid
  GROUP BY f.name) AS x
ORDER BY bucket, name;

/*
+-----------------+---------+
| name            | revenue |
+-----------------+---------+
| Massage Room 1  | high    |
| Massage Room 2  | high    |
| Tennis Court 2  | high    |
| Badminton Court | average |
| Squash Court    | average |
| Tennis Court 1  | average |
| Pool Table      | low     |
| Snooker Table   | low     |
| Table Tennis    | low     |
+-----------------+---------+
*/

-- Calculate the payback time for each facility
-- Based on the 3 complete months of data so far, calculate the amount of time each facility will take to repay its cost of ownership.
-- Remember to take into account ongoing monthly maintenance. Output facility name and payback time in months, order by facility name.
-- Don't worry about differences in month lengths, we're only looking for a rough value here!
SELECT f.name, initialoutlay / (monthlyRevenue - monthlymaintenance) AS months
FROM cd.facilities AS f
JOIN (
  SELECT f.name, initialoutlay, monthlymaintenance, SUM(
    CASE WHEN memid = 0
      THEN guestcost * slots
      ELSE membercost * slots
    END) / 3 AS monthlyRevenue
  FROM cd.bookings AS b
  JOIN cd.facilities AS f
  ON b.facid = f.facid
  GROUP BY f.facid) AS facilityStats
ON f.facid = facilityStats.facid
ORDER BY f.name;

/*
+-----------------+------------------------+
| name            | months                 |
+-----------------+------------------------+
| Badminton Court | 6.8317677198975235     |
| Massage Room 1  | 0.18885741265344664778 |
| Massage Room 2  | 1.7621145374449339     |
| Pool Table      | 5.3333333333333333     |
| Snooker Table   | 6.9230769230769231     |
| Squash Court    | 1.1339582703356516     |
| Table Tennis    | 6.4000000000000000     |
| Tennis Court 1  | 2.2624434389140271     |
| Tennis Court 2  | 1.7505470459518600     |
+-----------------+------------------------+
*/

-- Calculate a rolling average of total revenue
-- For each day in August 2012, calculate a rolling average of total revenue over the previous 15 days.
-- Output should contain date and revenue columns, sorted by the date. Remember to account for the possibility 
-- of a day having zero revenue. This one's a bit tough, so don't be afraid to check out the hint!
WITH daily_revenue (day, revenue) AS
(
  SELECT DATE_TRUNC('day', starttime) AS day, SUM(cost)
  FROM (
    SELECT starttime,
     CASE WHEN memid = 0
       THEN guestcost * slots
       ELSE membercost * slots
     END AS cost
    FROM cd.bookings AS b
    JOIN cd.facilities AS f
    ON b.facid = f.facid) AS x
  GROUP BY day
)

SELECT TO_CHAR(day, 'yyyy-mm-dd') AS date,
(
  SELECT SUM(dr_inner.revenue)
  FROM daily_revenue AS dr_inner
  WHERE dr_inner.day > dr_outer.day - '15 DAYS'::INTERVAL AND
        dr_inner.day <= dr_outer.day
) / 15 AS revenue
FROM daily_revenue AS dr_outer
WHERE day BETWEEN '2012-08-01' AND
                  '2012-08-31'
ORDER BY date;

/*
+------------+-----------------------+
| date       | revenue               |
+------------+-----------------------+
| 2012-08-01 | 1126.8333333333333333 |
| 2012-08-02 | 1153.0000000000000000 |
| 2012-08-03 | 1162.9000000000000000 |
| 2012-08-04 | 1177.3666666666666667 |
| 2012-08-05 | 1160.9333333333333333 |
| 2012-08-06 | 1185.4000000000000000 |
| 2012-08-07 | 1182.8666666666666667 |
| 2012-08-08 | 1172.6000000000000000 |
| 2012-08-09 | 1152.4666666666666667 |
| 2012-08-10 | 1175.0333333333333333 |
| 2012-08-11 | 1176.6333333333333333 |
| 2012-08-12 | 1195.6666666666666667 |
| 2012-08-13 | 1218.0000000000000000 |
| 2012-08-14 | 1247.4666666666666667 |
| 2012-08-15 | 1274.1000000000000000 |
| 2012-08-16 | 1281.2333333333333333 |
| 2012-08-17 | 1324.4666666666666667 |
| 2012-08-18 | 1373.7333333333333333 |
| 2012-08-19 | 1406.0666666666666667 |
| 2012-08-20 | 1427.0666666666666667 |
| 2012-08-21 | 1450.3333333333333333 |
| 2012-08-22 | 1539.7000000000000000 |
| 2012-08-23 | 1567.3000000000000000 |
| 2012-08-24 | 1592.3333333333333333 |
| 2012-08-25 | 1615.0333333333333333 |
| 2012-08-26 | 1631.2000000000000000 |
| 2012-08-27 | 1659.4333333333333333 |
| 2012-08-28 | 1687.0000000000000000 |
| 2012-08-29 | 1684.6333333333333333 |
| 2012-08-30 | 1657.9333333333333333 |
| 2012-08-31 | 1703.4000000000000000 |
+------------+-----------------------+
*/

