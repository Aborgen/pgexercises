-- Simple SQL Queries
-- https://pgexercises.com/questions/basic/

-- Retrieve everything from a table
-- How can you retrieve all the information from the cd.facilities table?
SELECT *
FROM cd.facilities;

/*
+-------+------------------+------------+-----------+---------------+--------------------+
| facid | name             | membercost | guestcost | initialoutlay | monthlymaintenance |
+-------+------------------+------------+-----------+---------------+--------------------+
| 0     | Tennis Court 1   | 5          | 25        | 10000         | 200                |
| 1     | Tennis Court 2   | 5          | 25        | 8000          | 200                |
| 2     | Badminton Court  | 0          | 15.5      | 4000          | 50                 |
| 3     | Table Tennis     | 0          | 5         | 320           | 10                 |
| 4     | Massage Room 1   | 35         | 80        | 4000          | 3000               |
| 5     | Massage Room 2   | 35         | 80        | 4000          | 3000               |
| 6     | Squash Court     | 3.5        | 17.5      | 5000          | 80                 | 
| 7     | Snooker Table    | 0          | 5         | 450           | 15                 |
| 8     | Pool Table       | 0          | 5         | 400           | 15                 |
+-------+------------------+------------+-----------+---------------+--------------------+
*/

-- Retrieve specific columns from a table
-- You want to print out a list of all of the facilities and their cost to members.
-- How would you retrieve a list of only facility names and costs?
SELECT name, membercost
FROM cd.facilities;

/*
+-----------------+------------+
| name            | membercost |
+-----------------+------------+
| Tennis Court 1  | 5          |
| Tennis Court 2  | 5          |
| Badminton Court | 0          |
| Table Tennis    | 0          |
| Massage Room 1  | 35         |
| Massage Room 2  | 35         |
| Squash Court    | 3.5        |
| Snooker Table   | 0          |
| Pool Table      | 0          |
+-----------------+------------+
*/

-- Control which rows are retrieved
-- How can you produce a list of facilities that charge a fee to members?
SELECT facid, name, membercost, guestcost, initialoutlay, monthlymaintenance
FROM cd.facilities
WHERE membercost > 0;

/*
+-------+----------------+------------+-----------+---------------+--------------------+
| facid | name           | membercost | guestcost | initialoutlay | monthlymaintenance |
+-------+----------------+------------+-----------+---------------+--------------------+
| 0     | Tennis Court 1 | 5          | 25        | 10000         | 200                |
| 1     | Tennis Court 2 | 5          | 25        | 8000          | 200                |
| 4     | Massage Room 1 | 35         | 80        | 4000          | 3000               |
| 5     | Massage Room 2 | 35         | 80        | 4000          | 3000               |
| 6     | Squash Court   | 3.5        | 17.5      | 5000          | 80                 |
+-------+----------------+------------+-----------+---------------+--------------------+
*/

-- Control which rows are retrieved - part 2
-- How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th
-- of the monthly maintenance cost? Return the facid, facility name, member cost, and monthly maintenance of
-- the facilities in question.
SELECT facid, name, membercost, monthlymaintenance
FROM cd.facilities
WHERE membercost > 0 AND
      membercost < (monthlymaintenance / 50);

/*
+-------+----------------+------------+--------------------+
| facid | name           | membercost | monthlymaintenance |
+-------+----------------+------------+--------------------+
| 4     | Massage Room 1 | 35         | 3000               |
| 5     | Massage Room 2 | 35         | 3000               |
+-------+----------------+------------+--------------------+
*/

-- Basic string searches
-- How can you produce a list of all facilities with the word 'Tennis' in their name?
SELECT facid, name, membercost, guestcost, initialoutlay, monthlymaintenance
FROM cd.facilities
WHERE UPPER(name) LIKE '%TENNIS%';

/*
+-------+----------------+------------+-----------+---------------+--------------------+
| facid | name           | membercost | guestcost | initialoutlay | monthlymaintenance |
+-------+----------------+------------+-----------+---------------+--------------------+
| 0     | Tennis Court 1 | 5          | 25        | 10000         | 200                |
| 1     | Tennis Court 2 | 5          | 25        | 8000          | 200                |
| 3     | Table Tennis   | 0          | 5         | 320           | 10                 |
+-------+----------------+------------+-----------+---------------+--------------------+
*/

-- Matching against multiple possible values
-- How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator.
SELECT facid, name, membercost, guestcost, initialoutlay, monthlymaintenance
FROM cd.facilities
WHERE facid IN (1, 5);

/*
+-------+----------------+------------+-----------+---------------+--------------------+
| facid | name           | membercost | guestcost | initialoutlay | monthlymaintenance |
+-------+----------------+------------+-----------+---------------+--------------------+
| 1     | Tennis Court 2 | 5          | 25        | 8000          | 200                |
| 5     | Massage Room 2 | 35         | 80        | 4000          | 3000               |
+-------+----------------+------------+-----------+---------------+--------------------+
*/

-- Classify results into buckets
-- How can you produce a list of facilities, with each labelled as 'cheap' or 'expensive' depending on if
-- their monthly maintenance cost is more than $100? Return the name and monthly maintenance of the facilities in question.
SELECT name,
  CASE WHEN monthlymaintenance > 100
    THEN 'expensive'
    ELSE 'cheap'
  END AS cost
FROM cd.facilities;

/*
+-----------------+-----------+
| name            | cost      |
+-----------------+-----------+
| Tennis Court 1  | expensive |
| Tennis Court 2  | expensive |
| Badminton Court | cheap     |
| Table Tennis    | cheap     |
| Massage Room 1  | expensive |
| Massage Room 2  | expensive |
| Squash Court    | cheap     |
| Snooker Table   | cheap     |
| Pool Table      | cheap     |
+-----------------+-----------+
*/

-- Working with dates
-- How can you produce a list of members who joined after the start of September 2012?
-- Return the memid, surname, firstname, and joindate of the members in question.
SELECT memid, surname, firstname, joindate
FROM cd.members
WHERE joindate >= '2012-09-01 00:00:00';

/*
+-------+-------------------+-----------+---------------------+
| memid | surname           | firstname | joindate            |
+-------+-------------------+-----------+---------------------+
| 24    | Sarwin            | Ramnaresh | 2012-09-01 08:44:42 |
| 26    | Jones             | Douglas   | 2012-09-02 18:43:05 |
| 27    | Rumney            | Henrietta | 2012-09-05 08:42:35 |
| 28    | Farrell           | David     | 2012-09-15 08:22:05 |
| 29    | Worthington-Smyth | Henry     | 2012-09-17 12:27:15 |
| 30    | Purview           | Millicent | 2012-09-18 19:04:01 |
| 33    | Tupperware        | Hyacinth  | 2012-09-18 19:32:05 |
| 35    | Hunt              | John      | 2012-09-19 11:32:45 |
| 36    | Crumpet           | Erica     | 2012-09-22 08:36:38 |
| 37    | Smith             | Darren    | 2012-09-26 18:08:45 |
+-------+-------------------+-----------+---------------------+
*/

-- Removing duplicates, and ordering results
-- How can you produce an ordered list of the first 10 surnames in the members table? The list must not contain duplicates.
SELECT DISTINCT surname
FROM cd.members
ORDER BY surname
LIMIT 10;

/*
+---------+
| surname |
+---------+
| Bader   |
| Baker   |
| Boothe  |
| Butters |
| Coplin  |
| Crumpet |
| Dare    |
| Farrell |
| GUEST   |
| Genting |
+---------+
*/

-- Combining results from multiple queries
-- You, for some reason, want a combined list of all surnames and all facility names.
-- Yes, this is a contrived example :-). Produce that list!
-- NOTE: I would use UNION ALL in this instance, but it is not accepted by the application.
SELECT surname FROM cd.members
UNION
SELECT name FROM cd.facilities;

/*
+-------------------+
| surname           |
+-------------------+
| Hunt              |
| Farrell           |
| Tennis Court 2    |
| Table Tennis      |
| Dare              |
| Rownam            |
| GUEST             |
| Badminton Court   |
| Smith             |
| Tupperware        |
| Owen              |
| Worthington-Smyth |
| Butters           |
| Rumney            |
| Tracy             |
| Crumpet           |
| Purview           |
| Massage Room 2    |
| Sarwin            |
| Baker             |
| Pool Table        |
| Snooker Table     |
| Jones             |
| Coplin            |
| Mackenzie         |
| Boothe            |
| Joplette          |
| Stibbons          |
| Squash Court      |
| Tennis Court 1    |
| Pinker            |
| Genting           |
| Bader             |
| Massage Room 1    |
+-------------------+
*/


-- Simple aggregation
-- You'd like to get the signup date of your last member. How can you retrieve this information?
SELECT MAX(joindate)
FROM cd.members;

/*
+---------------------+
| max                 |
+---------------------+
| 2012-09-26 18:08:45 |
+---------------------+
*/


-- More aggregation
-- You'd like to get the first and last name of the last member(s) who signed up - not just the date. How can you do that?
SELECT firstname, surname, joindate
FROM cd.members
WHERE joindate = (
  SELECT MAX(joindate)
  FROM cd.members  
);

/*
+------------+----------+---------------------+
| firstname  | surname  | joindate            |
+------------+----------+---------------------+
| Darren     | Smith    | 2012-09-26 18:08:45 |
+------------+----------+---------------------+
*/
