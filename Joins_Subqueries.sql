-- Joins and Subqueries
-- https://pgexercises.com/questions/joins/

-- Retrieve the start times of members' bookings
-- How can you produce a list of the start times for bookings by members named 'David Farrell'?
SELECT starttime
FROM cd.bookings AS b
JOIN cd.members AS m
ON b.memid = m.memid
WHERE firstname = 'David' AND
      surname = 'Farrell';

/*
+---------------------+
| starttime           |
+---------------------+
| 2012-09-18 09:00:00 |
| 2012-09-18 17:30:00 |
| 2012-09-18 13:30:00 |
| 2012-09-18 20:00:00 |
| 2012-09-19 09:30:00 |
| 2012-09-19 15:00:00 |
| 2012-09-19 12:00:00 |
| 2012-09-20 15:30:00 |
| 2012-09-20 11:30:00 |
| 2012-09-20 14:00:00 |
| 2012-09-21 10:30:00 |
| 2012-09-21 14:00:00 |
| 2012-09-22 08:30:00 |
| 2012-09-22 17:00:00 |
| 2012-09-23 08:30:00 |
| 2012-09-23 17:30:00 |
| 2012-09-23 19:00:00 |
| 2012-09-24 08:00:00 |
| 2012-09-24 16:30:00 |
| 2012-09-24 12:30:00 |
| 2012-09-25 15:30:00 |
| 2012-09-25 17:00:00 |
| 2012-09-26 13:00:00 |
| 2012-09-26 17:00:00 |
| 2012-09-27 08:00:00 |
| 2012-09-28 11:30:00 |
| 2012-09-28 09:30:00 |
| 2012-09-28 13:00:00 |
| 2012-09-29 16:00:00 |
| 2012-09-29 10:30:00 |
| 2012-09-29 13:30:00 |
| 2012-09-29 14:30:00 |
+---------------------+
*/

-- Work out the start times of bookings for tennis courts
-- How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'?
-- Return a list of start time and facility name pairings, ordered by the time.
SELECT starttime, f.name
FROM cd.bookings AS b
JOIN cd.facilities AS f
ON b.facid = f.facid
WHERE UPPER(f.name) LIKE 'TENNIS COURT%' AND
      starttime BETWEEN '2012-09-21 00:00:00' AND
                        '2012-09-21 23:50:50'
ORDER BY starttime;

/*
+---------------------+----------------+
| starttime           | name           |
+---------------------+----------------+
| 2012-09-21 08:00:00 | Tennis Court 1 |
| 2012-09-21 08:00:00 | Tennis Court 2 |
| 2012-09-21 09:30:00 | Tennis Court 1 |
| 2012-09-21 10:00:00 | Tennis Court 2 |
| 2012-09-21 11:30:00 | Tennis Court 2 |
| 2012-09-21 12:00:00 | Tennis Court 1 |
| 2012-09-21 13:30:00 | Tennis Court 1 |
| 2012-09-21 14:00:00 | Tennis Court 2 |
| 2012-09-21 15:30:00 | Tennis Court 1 |
| 2012-09-21 16:00:00 | Tennis Court 2 |
| 2012-09-21 17:00:00 | Tennis Court 1 |
| 2012-09-21 18:00:00 | Tennis Court 2 |
+---------------------+----------------+
*/

-- Produce a list of all members who have recommended another member
-- How can you output a list of all members who have recommended another member?
-- Ensure that there are no duplicates in the list, and that results are ordered by (surname, firstname).
SELECT DISTINCT m2.firstname, m2.surname
FROM cd.members AS m1
JOIN cd.members AS m2
ON m1.recommendedby = m2.memid
ORDER BY m2.surname, m2.firstname;

/*
+-----------+----------+
| firstname | surname  |
+-----------+----------+
| Florence  | Bader    |
| Timothy   | Baker    |
| Gerald    | Butters  |
| Jemima    | Farrell  |
| Matthew   | Genting  |
| David     | Jones    |
| Janice    | Joplette |
| Millicent | Purview  |
| Tim       | Rownam   |
| Darren    | Smith    |
| Tracy     | Smith    |
| Ponder    | Stibbons |
| Burton    | Tracy    |
+-----------+----------+
*/

-- Produce a list of all members, along with their recommender
-- How can you output a list of all members, including the individual who recommended them (if any)?
-- Ensure that results are ordered by (surname, firstname).
SELECT m1.firstname AS firstname_member, m1.surname AS surname_member,
       m2.firstname AS firstname_recommender, m2.surname AS surname_recommender
FROM cd.members AS m1
LEFT JOIN cd.members AS m2
ON m1.recommendedby = m2.memid
ORDER BY surname_member, firstname_member;

/*
+------------------+-------------------+-----------------------+---------------------+
| firstname_member | surname_member    | firstname_recommender | surname_recommender |
+------------------+-------------------+-----------------------+---------------------+
| Florence         | Bader             | Ponder                | Stibbons            |
| Anne             | Baker             | Ponder                | Stibbons            |
| Timothy          | Baker             | Jemima                | Farrell             |
| Tim              | Boothe            | Tim                   | Rownam              |
| Gerald           | Butters           | Darren                | Smith               |
| Joan             | Coplin            | Timothy               | Baker               |
| Erica            | Crumpet           | Tracy                 | Smith               |
| Nancy            | Dare              | Janice                | Joplette            |
| David            | Farrell           |                       |                     |
| Jemima           | Farrell           |                       |                     |
| GUEST            | GUEST             |                       |                     |
| Matthew          | Genting           | Gerald                | Butters             |
| John             | Hunt              | Millicent             | Purview             |
| David            | Jones             | Janice                | Joplette            |
| Douglas          | Jones             | David                 | Jones               |
| Janice           | Joplette          | Darren                | Smith               |
| Anna             | Mackenzie         | Darren                | Smith               |
| Charles          | Owen              | Darren                | Smith               |
| David            | Pinker            | Jemima                | Farrell             |
| Millicent        | Purview           | Tracy                 | Smith               |
| Tim              | Rownam            |                       |                     |
| Henrietta        | Rumney            | Matthew               | Genting             |
| Ramnaresh        | Sarwin            | Florence              | Bader               |
| Darren           | Smith             |                       |                     |
| Darren           | Smith             |                       |                     |
| Jack             | Smith             | Darren                | Smith               |
| Tracy            | Smith             |                       |                     |
| Ponder           | Stibbons          | Burton                | Tracy               |
| Burton           | Tracy             |                       |                     |
| Hyacinth         | Tupperware        |                       |                     |
| Henry            | Worthington-Smyth | Tracy                 | Smith               |
+------------------+-------------------+-----------------------+---------------------+
*/

-- Produce a list of all members who have used a tennis court
-- How can you produce a list of all members who have used a tennis court? Include in your output the name of
-- the court, and the name of the member formatted as a single column. Ensure no duplicate data, and order by the member name.
SELECT DISTINCT CONCAT(firstname, ' ', surname) AS membername, f.name AS facility
FROM cd.members AS m
JOIN cd.bookings AS b
ON m.memid = b.memid
JOIN cd.facilities AS f
ON b.facid = f.facid
WHERE UPPER(f.name) LIKE 'TENNIS COURT%'
ORDER BY membername;

/*
+-------------------+----------------+
| membername        | facility       |
+-------------------+----------------+
| Anne Baker        | Tennis Court 1 |
| Anne Baker        | Tennis Court 2 |
| Burton Tracy      | Tennis Court 2 |
| Burton Tracy      | Tennis Court 1 |
| Charles Owen      | Tennis Court 2 |
| Charles Owen      | Tennis Court 1 |
| Darren Smith      | Tennis Court 2 |
| David Farrell     | Tennis Court 1 |
| David Farrell     | Tennis Court 2 |
| David Jones       | Tennis Court 2 |
| David Jones       | Tennis Court 1 |
| David Pinker      | Tennis Court 1 |
| Douglas Jones     | Tennis Court 1 |
| Erica Crumpet     | Tennis Court 1 |
| Florence Bader    | Tennis Court 2 |
| Florence Bader    | Tennis Court 1 |
| GUEST GUEST       | Tennis Court 2 |
| GUEST GUEST       | Tennis Court 1 |
| Gerald Butters    | Tennis Court 2 |
| Gerald Butters    | Tennis Court 1 |
| Henrietta Rumney  | Tennis Court 2 |
| Jack Smith        | Tennis Court 1 |
| Jack Smith        | Tennis Court 2 |
| Janice Joplette   | Tennis Court 2 |
| Janice Joplette   | Tennis Court 1 |
| Jemima Farrell    | Tennis Court 1 |
| Jemima Farrell    | Tennis Court 2 |
| Joan Coplin       | Tennis Court 1 |
| John Hunt         | Tennis Court 1 |
| John Hunt         | Tennis Court 2 |
| Matthew Genting   | Tennis Court 1 |
| Millicent Purview | Tennis Court 2 |
| Nancy Dare        | Tennis Court 1 |
| Nancy Dare        | Tennis Court 2 |
| Ponder Stibbons   | Tennis Court 1 |
| Ponder Stibbons   | Tennis Court 2 |
| Ramnaresh Sarwin  | Tennis Court 1 |
| Ramnaresh Sarwin  | Tennis Court 2 |
| Tim Boothe        | Tennis Court 2 |
| Tim Boothe        | Tennis Court 1 |
| Tim Rownam        | Tennis Court 1 |
| Tim Rownam        | Tennis Court 2 |
| Timothy Baker     | Tennis Court 2 |
| Timothy Baker     | Tennis Court 1 |
| Tracy Smith       | Tennis Court 1 |
| Tracy Smith       | Tennis Court 2 |
+-------------------+----------------+
*/

-- Produce a list of costly bookings
-- How can you produce a list of bookings on the day of 2012-09-14 which will cost the member (or guest) more than $30?
-- Remember that guests have different costs to members (the listed costs are per half-hour 'slot'), and the guest user is
-- always ID 0. Include in your output the name of the facility, the name of the member formatted as a single column, and the cost.
-- Order by descending cost, and do not use any subqueries.
SELECT CONCAT(firstname, ' ', surname) AS membername, f.name AS facility,
  CASE WHEN m.memid = 0
    THEN guestcost * slots
    ELSE membercost * slots
  END AS cost
FROM cd.bookings AS b
JOIN cd.facilities AS f
ON b.facid = f.facid
JOIN cd.members AS m
ON b.memid = m.memid
WHERE ((m.memid = 0 AND guestcost * slots > 30) OR (m.memid <> 0 AND membercost * slots > 30)) AND
      starttime BETWEEN '2012-09-14 00:00:00' AND
                        '2012-09-14 23:59:59'
ORDER BY cost DESC;

/*
+-----------------+----------------+------+
| membername      | facility       | cost |
+-----------------+----------------+------+
| GUEST GUEST     | Massage Room 2 | 320  |
| GUEST GUEST     | Massage Room 1 | 160  |
| GUEST GUEST     | Massage Room 1 | 160  |
| GUEST GUEST     | Massage Room 1 | 160  |
| GUEST GUEST     | Tennis Court 2 | 150  |
| Jemima Farrell  | Massage Room 1 | 140  |
| GUEST GUEST     | Tennis Court 1 | 75   |
| GUEST GUEST     | Tennis Court 2 | 75   |
| GUEST GUEST     | Tennis Court 1 | 75   |
| Matthew Genting | Massage Room 1 | 70   |
| Florence Bader  | Massage Room 2 | 70   |
| GUEST GUEST     | Squash Court   | 70.0 |
| Jemima Farrell  | Massage Room 1 | 70   |
| Ponder Stibbons | Massage Room 1 | 70   |
| Burton Tracy    | Massage Room 1 | 70   |
| Jack Smith      | Massage Room 1 | 70   |
+-----------------+----------------+------+
*/

-- Produce a list of all members, along with their recommender, using no joins.
-- How can you output a list of all members, including the individual who recommended them (if any),
-- without using any joins? Ensure that there are no duplicates in the list, and that each firstname + surname
-- pairing is formatted as a column and ordered.
SELECT DISTINCT CONCAT(firstname, ' ', surname) AS membername,
(
  SELECT CONCAT(m_inner.firstname, ' ', m_inner.surname)
  FROM cd.members AS m_inner
  WHERE m_outer.recommendedby = m_inner.memid
) AS recommender
FROM cd.members AS m_outer
ORDER BY membername;

/*
+-------------------------+-------------------+
| membername              | recommender       |
+-------------------------+-------------------+
| Anna Mackenzie          | Darren Smith      |
| Anne Baker              | Ponder Stibbons   |
| Burton Tracy            |                   |
| Charles Owen            | Darren Smith      |
| Darren Smith            |                   |
| David Farrell           |                   |
| David Jones             | Janice Joplette   |
| David Pinker            | Jemima Farrell    |
| Douglas Jones           | David Jones       |
| Erica Crumpet           | Tracy Smith       |
| Florence Bader          | Ponder Stibbons   |
| GUEST GUEST             |                   |
| Gerald Butters          | Darren Smith      |
| Henrietta Rumney        | Matthew Genting   |
| Henry Worthington-Smyth | Tracy Smith       |
| Hyacinth Tupperware     |                   |
| Jack Smith              | Darren Smith      |
| Janice Joplette         | Darren Smith      |
| Jemima Farrell          |                   |
| Joan Coplin             | Timothy Baker     |
| John Hunt               | Millicent Purview |
| Matthew Genting         | Gerald Butters    |
| Millicent Purview       | Tracy Smith       |
| Nancy Dare              | Janice Joplette   |
| Ponder Stibbons         | Burton Tracy      |
| Ramnaresh Sarwin        | Florence Bader    |
| Tim Boothe              | Tim Rownam        |
| Tim Rownam              |                   |
| Timothy Baker           | Jemima Farrell    |
| Tracy Smith             |                   |
+-------------------------+-------------------+
*/

-- Produce a list of costly bookings, using a subquery
-- The Produce a list of costly bookings exercise contained some messy logic: we had to calculate the
-- booking cost in both the WHERE clause and the CASE statement. Try to simplify this calculation using subqueries.
SELECT membername, facility, cost
FROM
(
  SELECT CONCAT(firstname, ' ', surname) AS membername, f.name AS facility,
    CASE WHEN m.memid = 0
      THEN guestcost * slots
      ELSE membercost * slots
    END AS cost
  FROM cd.bookings AS b
  JOIN cd.facilities AS f
  ON b.facid = f.facid
  JOIN cd.members AS m
  ON b.memid = m.memid
  WHERE starttime BETWEEN '2012-09-14 00:00:00' AND
                          '2012-09-14 23:59:59'
) AS x
WHERE cost > 30
ORDER BY cost DESC;

/*
+-----------------+----------------+------+
| membername      | facility       | cost |
+-----------------+----------------+------+
| GUEST GUEST     | Massage Room 2 | 320  |
| GUEST GUEST     | Massage Room 1 | 160  |
| GUEST GUEST     | Massage Room 1 | 160  |
| GUEST GUEST     | Massage Room 1 | 160  |
| GUEST GUEST     | Tennis Court 2 | 150  |
| Jemima Farrell  | Massage Room 1 | 140  |
| GUEST GUEST     | Tennis Court 1 | 75   |
| GUEST GUEST     | Tennis Court 2 | 75   |
| GUEST GUEST     | Tennis Court 1 | 75   |
| Matthew Genting | Massage Room 1 | 70   |
| Florence Bader  | Massage Room 2 | 70   |
| GUEST GUEST     | Squash Court   | 70.0 |
| Jemima Farrell  | Massage Room 1 | 70   |
| Ponder Stibbons | Massage Room 1 | 70   |
| Burton Tracy    | Massage Room 1 | 70   |
| Jack Smith      | Massage Room 1 | 70   |
| GUEST GUEST     | Squash Court   | 35.0 |
| GUEST GUEST     | Squash Court   | 35.0 |
+-----------------+----------------+------+
*/

