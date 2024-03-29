-- String Operations
-- https://pgexercises.com/questions/string/

-- Format the names of members
-- Output the names of all members, formatted as 'Surname, Firstname'
SELECT CONCAT(surname, ', ', firstname) AS name
FROM cd.members;

/*
+--------------------------+
| name                     |
+--------------------------+
| GUEST, GUEST             |
| Smith, Darren            |
| Smith, Tracy             |
| Rownam, Tim              |
| Joplette, Janice         |
| Butters, Gerald          |
| Tracy, Burton            |
| Dare, Nancy              |
| Boothe, Tim              |
| Stibbons, Ponder         |
| Owen, Charles            |
| Jones, David             |
| Baker, Anne              |
| Farrell, Jemima          |
| Smith, Jack              |
| Bader, Florence          |
| Baker, Timothy           |
| Pinker, David            |
| Genting, Matthew         |
| Mackenzie, Anna          |
| Coplin, Joan             |
| Sarwin, Ramnaresh        |
| Jones, Douglas           |
| Rumney, Henrietta        |
| Farrell, David           |
| Worthington-Smyth, Henry |
| Purview, Millicent       |
| Tupperware, Hyacinth     |
| Hunt, John               |
| Crumpet, Erica           |
| Smith, Darren            |
+--------------------------+
*/

-- Find facilities by a name prefix
-- Find all facilities whose name begins with 'Tennis'. Retrieve all columns.
SELECT *
FROM cd.facilities
WHERE name LIKE 'Tennis%';

/*
+-------+----------------+------------+-----------+---------------+--------------------+
| facid | name           | membercost | guestcost | initialoutlay | monthlymaintenance |
+-------+----------------+------------+-----------+---------------+--------------------+
| 0     | Tennis Court 1 | 5          | 25        | 10000         | 200                |
| 1     | Tennis Court 2 | 5          | 25        | 8000          | 200                |
+-------+----------------+------------+-----------+---------------+--------------------+
*/

-- Perform a case-insensitive search
-- Perform a case-insensitive search to find all facilities whose name begins with 'tennis'. Retrieve all columns.
SELECT *
FROM cd.facilities
WHERE name ILIKE 'Tennis%';

/*
+-------+----------------+------------+-----------+---------------+--------------------+
| facid | name           | membercost | guestcost | initialoutlay | monthlymaintenance |
+-------+----------------+------------+-----------+---------------+--------------------+
| 0     | Tennis Court 1 | 5          | 25        | 10000         | 200                |
| 1     | Tennis Court 2 | 5          | 25        | 8000          | 200                |
+-------+----------------+------------+-----------+---------------+--------------------+
*/

-- Find telephone numbers with parentheses
-- You've noticed that the club's member table has telephone numbers with very inconsistent formatting. You'd like to
-- find all the telephone numbers that contain parentheses, returning the member ID and telephone number sorted by member ID.
SELECT memid, telephone
FROM cd.members
WHERE telephone SIMILAR TO '\([0-9]{3}\) [0-9]{3}-[0-9]{4}'
ORDER BY memid;

/*
+-------+----------------+
| memid | telephone      |
+-------+----------------+
| 0     | (000) 000-0000 |
| 3     | (844) 693-0723 |
| 4     | (833) 942-4710 |
| 5     | (844) 078-4130 |
| 6     | (822) 354-9973 |
| 7     | (833) 776-4001 |
| 8     | (811) 433-2547 |
| 9     | (833) 160-3900 |
| 10    | (855) 542-5251 |
| 11    | (844) 536-8036 |
| 13    | (855) 016-0163 |
| 14    | (822) 163-3254 |
| 15    | (833) 499-3527 |
| 20    | (811) 972-1377 |
| 21    | (822) 661-2898 |
| 22    | (822) 499-2232 |
| 24    | (822) 413-1470 |
| 27    | (822) 989-8876 |
| 28    | (855) 755-9876 |
| 29    | (855) 894-3758 |
| 30    | (855) 941-9786 |
| 33    | (822) 665-5327 |
| 35    | (899) 720-6978 |
| 36    | (811) 732-4816 |
| 37    | (822) 577-3541 |
+-------+----------------+
*/

-- Pad zip codes with leading zeroes
-- The zip codes in our example dataset have had leading zeroes removed from them by virtue of being stored as a numeric type.
-- Retrieve all zip codes from the members table, padding any zip codes less than 5 characters long with leading zeroes. Order by the new zip code.
SELECT LPAD(zipcode::VARCHAR, 5, '0') AS zipcode
FROM cd.members
ORDER BY zipcode;

/*
+---------+
| zipcode |
+---------+
| 00000   |
| 00234   |
| 00234   |
| 04321   |
| 04321   |
| 10383   |
| 11986   |
| 23423   |
| 28563   |
| 33862   |
| 34232   |
| 43532   |
| 43533   |
| 45678   |
| 52365   |
| 54333   |
| 56754   |
| 57392   |
| 58393   |
| 64577   |
| 65332   |
| 65464   |
| 66796   |
| 68666   |
| 69302   |
| 75655   |
| 78533   |
| 80743   |
| 84923   |
| 87630   |
| 97676   |
+---------+
*/

-- Count the number of members whose surname starts with each letter of the alphabet
-- You'd like to produce a count of how many members you have whose surname starts with each letter of the alphabet.
-- Sort by the letter, and don't worry about printing out a letter if the count is 0.
SELECT UPPER(LEFT(surname, 1)) AS letter, COUNT(*)
FROM cd.members
GROUP BY letter
ORDER BY letter;

/*
+--------+-------+
| letter | count |
+--------+-------+
| B      | 5     |
| C      | 2     |
| D      | 1     |
| F      | 2     |
| G      | 2     |
| H      | 1     |
| J      | 3     |
| M      | 1     |
| O      | 1     |
| P      | 2     |
| R      | 2     |
| S      | 6     |
| T      | 2     |
| W      | 1     |
+--------+-------+
*/

-- Clean up telephone numbers
-- The telephone numbers in the database are very inconsistently formatted. You'd like to print a list of member ids and numbers
-- that have had '-','(',')', and ' ' characters removed. Order by member id.
SELECT memid, REGEXP_REPLACE(telephone, '[^0-9]', '', 'g') AS telephone
FROM cd.members
ORDER BY memid;

/*
+-------+------------+
| memid | telephone  |
+-------+------------+
| 0     | 0000000000 |
| 1     | 5555555555 |
| 2     | 5555555555 |
| 3     | 8446930723 |
| 4     | 8339424710 |
| 5     | 8440784130 |
| 6     | 8223549973 |
| 7     | 8337764001 |
| 8     | 8114332547 |
| 9     | 8331603900 |
| 10    | 8555425251 |
| 11    | 8445368036 |
| 12    | 8440765141 |
| 13    | 8550160163 |
| 14    | 8221633254 |
| 15    | 8334993527 |
| 16    | 8339410824 |
| 17    | 8114096734 |
| 20    | 8119721377 |
| 21    | 8226612898 |
| 22    | 8224992232 |
| 24    | 8224131470 |
| 26    | 8445368036 |
| 27    | 8229898876 |
| 28    | 8557559876 |
| 29    | 8558943758 |
| 30    | 8559419786 |
| 33    | 8226655327 |
| 35    | 8997206978 |
| 36    | 8117324816 |
| 37    | 8225773541 |
+-------+------------+
*/

