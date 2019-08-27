-- Modifying Data
-- https://pgexercises.com/questions/updates/

-- Insert some data into a table
-- The club is adding a new facility - a spa. We need to add it into the facilities table. Use the following values:
--  * facid: 9, Name: 'Spa', membercost: 20, guestcost: 30, initialoutlay: 100000, monthlymaintenance: 800.
INSERT INTO cd.facilities
  (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
VALUES
  (9, 'Spa', 20, 30, 100000, 800);

/*
+-------+-----------------+------------+-----------+---------------+--------------------+
| facid | name            | membercost | guestcost | initialoutlay | monthlymaintenance |
+-------+-----------------+------------+-----------+---------------+--------------------+
| 0     | Tennis Court 1  | 5          | 25        | 10000         | 200                |
| 1     | Tennis Court 2  | 5          | 25        | 8000          | 200                |
| 2     | Badminton Court | 0          | 15.5      | 4000          | 50                 |
| 3     | Table Tennis    | 0          | 5         | 320           | 10                 |
| 4     | Massage Room 1  | 35         | 80        | 4000          | 3000               |
| 5     | Massage Room 2  | 35         | 80        | 4000          | 3000               |
| 6     | Squash Court    | 3.5        | 17.5      | 5000          | 80                 |
| 7     | Snooker Table   | 0          | 5         | 450           | 15                 |
| 8     | Pool Table      | 0          | 5         | 400           | 15                 |
| 9     | Spa             | 20         | 30        | 100000        | 800                |
+-------+-----------------+------------+-----------+---------------+--------------------+
*/

-- Insert multiple rows of data into a table
-- In the previous exercise, you learned how to add a facility. Now you're going to add multiple facilities in one command.
-- Use the following values:
--  * facid: 9, Name: 'Spa', membercost: 20, guestcost: 30, initialoutlay: 100000, monthlymaintenance: 800.
--  * facid: 10, Name: 'Squash Court 2', membercost: 3.5, guestcost: 17.5, initialoutlay: 5000, monthlymaintenance: 80.
INSERT INTO cd.facilities
  (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
VALUES
  (9, 'Spa', 20, 30, 100000, 800),
  (10, 'Squash Court 2', 3.5, 17.5, 5000, 80);

/*
+-------+-----------------+------------+-----------+---------------+--------------------+
| facid | name            | membercost | guestcost | initialoutlay | monthlymaintenance |
+-------+-----------------+------------+-----------+---------------+--------------------+
| 0     | Tennis Court 1  | 5          | 25        | 10000         | 200                |
| 1     | Tennis Court 2  | 5          | 25        | 8000          | 200                |
| 2     | Badminton Court | 0          | 15.5      | 4000          | 50                 |
| 3     | Table Tennis    | 0          | 5         | 320           | 10                 |
| 4     | Massage Room 1  | 35         | 80        | 4000          | 3000               |
| 5     | Massage Room 2  | 35         | 80        | 4000          | 3000               |
| 6     | Squash Court    | 3.5        | 17.5      | 5000          | 80                 |
| 7     | Snooker Table   | 0          | 5         | 450           | 15                 |
| 8     | Pool Table      | 0          | 5         | 400           | 15                 |
| 9     | Spa             | 20         | 30        | 100000        | 800                |
| 10    | Squash Court 2  | 3.5        | 17.5      | 5000          | 80                 |
+-------+-----------------+------------+-----------+---------------+--------------------+
*/

-- Insert calculated data into a table
-- Let's try adding the spa to the facilities table again. This time, though, we want to
-- automatically generate the value for the next facid, rather than specifying it as a constant.
-- Use the following values for everything else:
--  * Name: 'Spa', membercost: 20, guestcost: 30, initialoutlay: 100000, monthlymaintenance: 800.
INSERT INTO cd.facilities
  (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
VALUES
  ((SELECT MAX(facid) + 1 FROM cd.facilities), 'Spa', 20, 30, 100000, 800);

/*
+-------+-----------------+------------+-----------+---------------+--------------------+
| facid | name            | membercost | guestcost | initialoutlay | monthlymaintenance |
+-------+-----------------+------------+-----------+---------------+--------------------+
| 0     | Tennis Court 1  | 5          | 25        | 10000         | 200                |
| 1     | Tennis Court 2  | 5          | 25        | 8000          | 200                |
| 2     | Badminton Court | 0          | 15.5      | 4000          | 50                 |
| 3     | Table Tennis    | 0          | 5         | 320           | 10                 |
| 4     | Massage Room 1  | 35         | 80        | 4000          | 3000               |
| 5     | Massage Room 2  | 35         | 80        | 4000          | 3000               |
| 6     | Squash Court    | 3.5        | 17.5      | 5000          | 80                 |
| 7     | Snooker Table   | 0          | 5         | 450           | 15                 |
| 8     | Pool Table      | 0          | 5         | 400           | 15                 |
| 9     | Spa             | 20         | 30        | 100000        | 800                |
+-------+-----------------+------------+-----------+---------------+--------------------+
*/

-- Update some existing data
-- We made a mistake when entering the data for the second tennis court. The initial outlay was
-- 10000 rather than 8000: you need to alter the data to fix the error.
UPDATE cd.facilities
SET initialoutlay = 10000
WHERE facid = 1;

/*
+-------+-----------------+------------+-----------+---------------+--------------------+
| facid | name            | membercost | guestcost | initialoutlay | monthlymaintenance |
+-------+-----------------+------------+-----------+---------------+--------------------+
| 0     | Tennis Court 1  | 5          | 25        | 10000         | 200                |
| 1     | Tennis Court 2  | 5          | 25        | 10000         | 200                |
| 2     | Badminton Court | 0          | 15.5      | 4000          | 50                 |
| 3     | Table Tennis    | 0          | 5         | 320           | 10                 |
| 4     | Massage Room 1  | 35         | 80        | 4000          | 3000               |
| 5     | Massage Room 2  | 35         | 80        | 4000          | 3000               |
| 6     | Squash Court    | 3.5        | 17.5      | 5000          | 80                 |
| 7     | Snooker Table   | 0          | 5         | 450           | 15                 |
| 8     | Pool Table      | 0          | 5         | 400           | 15                 |
+-------+-----------------+------------+-----------+---------------+--------------------+
*/

-- Update multiple rows and columns at the same time
-- We want to increase the price of the tennis courts for both members and guests.
-- Update the costs to be 6 for members, and 30 for guests.
UPDATE cd.facilities
SET membercost = 6,
    guestcost = 30
WHERE facid IN (0, 1);

/*
+-------+-----------------+------------+-----------+---------------+--------------------+
| facid | name            | membercost | guestcost | initialoutlay | monthlymaintenance |
+-------+-----------------+------------+-----------+---------------+--------------------+
| 0     | Tennis Court 1  | 6          | 30        | 10000         | 200                |
| 1     | Tennis Court 2  | 6          | 30        | 8000          | 200                |
| 2     | Badminton Court | 0          | 15.5      | 4000          | 50                 |
| 3     | Table Tennis    | 0          | 5         | 320           | 10                 |
| 4     | Massage Room 1  | 35         | 80        | 4000          | 3000               |
| 5     | Massage Room 2  | 35         | 80        | 4000          | 3000               |
| 6     | Squash Court    | 3.5        | 17.5      | 5000          | 80                 |
| 7     | Snooker Table   | 0          | 5         | 450           | 15                 |
| 8     | Pool Table      | 0          | 5         | 400           | 15                 |
+-------+-----------------+------------+-----------+---------------+--------------------+
*/

-- Update a row based on the contents of another row
-- We want to alter the price of the second tennis court so that it costs 10% more than the first one.
-- Try to do this without using constant values for the prices, so that we can reuse the statement if we want to.
UPDATE cd.facilities
SET
  membercost = (
    SELECT membercost * 1.1
    FROM cd.facilities
    WHERE facid = 0
  ),
  guestcost = (
    SELECT guestcost * 1.1
    FROM cd.facilities
    WHERE facid = 0
  )
WHERE facid = 1;

/*
+-------+-----------------+------------+-----------+---------------+--------------------+
| facid | name            | membercost | guestcost | initialoutlay | monthlymaintenance |
+-------+-----------------+------------+-----------+---------------+--------------------+
| 0     | Tennis Court 1  | 5          | 25        | 10000         | 200                |
| 1     | Tennis Court 2  | 5.5        | 27.5      | 8000          | 200                |
| 2     | Badminton Court | 0          | 15.5      | 4000          | 50                 |
| 3     | Table Tennis    | 0          | 5         | 320           | 10                 |
| 4     | Massage Room 1  | 35         | 80        | 4000          | 3000               |
| 5     | Massage Room 2  | 35         | 80        | 4000          | 3000               |
| 6     | Squash Court    | 3.5        | 17.5      | 5000          | 80                 |
| 7     | Snooker Table   | 0          | 5         | 450           | 15                 |
| 8     | Pool Table      | 0          | 5         | 400           | 15                 |
+-------+-----------------+------------+-----------+---------------+--------------------+
*/

-- Delete all bookings
-- As part of a clearout of our database, we want to delete all bookings
-- from the cd.bookings table. How can we accomplish this?
TRUNCATE cd.bookings;

/*
+--------+-------+-------+-----------+-------+
| bookid | facid | memid | starttime | slots |
+--------+-------+-------+-----------+-------+
+--------+-------+-------+-----------+-------+
*/

-- Delete a member from the cd.members table
-- We want to remove member 37, who has never made a booking, from our database. How can we achieve that?
DELETE FROM cd.members
WHERE memid = 37;

/*
+--------+--------------------+------------+------------------------------------------+----------+-----------------+----------------+---------------------+
| memid  | surname            | firstname  | address                                  | zipcode  | telephone       | recommendedby  | joindate            |
+--------+--------------------+------------+------------------------------------------+----------+-----------------+----------------+---------------------+
| 0      | GUEST              | GUEST      | GUEST                                    | 0        | (000) 000-0000  |                | 2012-07-01 00:00:00 |
| 1      | Smith              | Darren     | 8 Bloomsbury Close, Boston               | 4321     | 555-555-5555    |                | 2012-07-02 12:02:05 |
| 2      | Smith              | Tracy      | 8 Bloomsbury Close, New York             | 4321     | 555-555-5555    |                | 2012-07-02 12:08:23 |
| 3      | Rownam             | Tim        | 23 Highway Way, Boston                   | 23423    | (844) 693-0723  |                | 2012-07-03 09:32:15 |
| 4      | Joplette           | Janice     | 20 Crossing Road, New York               | 234      | (833) 942-4710  | 1              | 2012-07-03 10:25:05 |
| 5      | Butters            | Gerald     | 1065 Huntingdon Avenue, Boston           | 56754    | (844) 078-4130  | 1              | 2012-07-09 10:44:09 |
| 6      | Tracy              | Burton     | 3 Tunisia Drive, Boston                  | 45678    | (822) 354-9973  |                | 2012-07-15 08:52:55 |
| 7      | Dare               | Nancy      | 6 Hunting Lodge Way, Boston              | 10383    | (833) 776-4001  | 4              | 2012-07-25 08:59:12 |
| 8      | Boothe             | Tim        | 3 Bloomsbury Close, Reading, 00234       | 234      | (811) 433-2547  | 3              | 2012-07-25 16:02:35 |
| 9      | Stibbons           | Ponder     | 5 Dragons Way, Winchester                | 87630    | (833) 160-3900  | 6              | 2012-07-25 17:09:05 |
| 10     | Owen               | Charles    | 52 Cheshire Grove, Winchester, 28563     | 28563    | (855) 542-5251  | 1              | 2012-08-03 19:42:37 |
| 11     | Jones              | David      | 976 Gnats Close, Reading                 | 33862    | (844) 536-8036  | 4              | 2012-08-06 16:32:55 |
| 12     | Baker              | Anne       | 55 Powdery Street, Boston                | 80743    | 844-076-5141    | 9              | 2012-08-10 14:23:22 |
| 13     | Farrell            | Jemima     | 103 Firth Avenue, North Reading          | 57392    | (855) 016-0163  |                | 2012-08-10 14:28:01 |
| 14     | Smith              | Jack       | 252 Binkington Way, Boston               | 69302    | (822) 163-3254  | 1              | 2012-08-10 16:22:05 |
| 15     | Bader              | Florence   | 264 Ursula Drive, Westford               | 84923    | (833) 499-3527  | 9              | 2012-08-10 17:52:03 |
| 16     | Baker              | Timothy    | 329 James Street, Reading                | 58393    | 833-941-0824    | 13             | 2012-08-15 10:34:25 |
| 17     | Pinker             | David      | 5 Impreza Road, Boston                   | 65332    | 811 409-6734    | 13             | 2012-08-16 11:32:47 |
| 20     | Genting            | Matthew    | 4 Nunnington Place, Wingfield, Boston    | 52365    | (811) 972-1377  | 5              | 2012-08-19 14:55:55 |
| 21     | Mackenzie          | Anna       | 64 Perkington Lane, Reading              | 64577    | (822) 661-2898  | 1              | 2012-08-26 09:32:05 |
| 22     | Coplin             | Joan       | 85 Bard Street, Bloomington, Boston      | 43533    | (822) 499-2232  | 16             | 2012-08-29 08:32:41 |
| 24     | Sarwin             | Ramnaresh  | 12 Bullington Lane, Boston               | 65464    | (822) 413-1470  | 15             | 2012-09-01 08:44:42 |
| 26     | Jones              | Douglas    | 976 Gnats Close, Reading                 | 11986    | 844 536-8036    | 11             | 2012-09-02 18:43:05 |
| 27     | Rumney             | Henrietta  | 3 Burkington Plaza, Boston               | 78533    | (822) 989-8876  | 20             | 2012-09-05 08:42:35 |
| 28     | Farrell            | David      | 437 Granite Farm Road, Westford          | 43532    | (855) 755-9876  |                | 2012-09-15 08:22:05 |
| 29     | Worthington-Smyth  | Henry      | 55 Jagbi Way, North Reading              | 97676    | (855) 894-3758  | 2              | 2012-09-17 12:27:15 |
| 30     | Purview            | Millicent  | 641 Drudgery Close, Burnington, Boston   | 34232    | (855) 941-9786  | 2              | 2012-09-18 19:04:01 |
| 33     | Tupperware         | Hyacinth   | 33 Cheerful Plaza, Drake Road, Westford  | 68666    | (822) 665-5327  |                | 2012-09-18 19:32:05 |
| 35     | Hunt               | John       | 5 Bullington Lane, Boston                | 54333    | (899) 720-6978  | 30             | 2012-09-19 11:32:45 |
| 36     | Crumpet            | Erica      | Crimson Road, North Reading              | 75655    | (811) 732-4816  | 2              | 2012-09-22 08:36:38 |
+--------+--------------------+------------+------------------------------------------+----------+-----------------+----------------+---------------------+
*/

-- Delete based on a subquery
-- In our previous exercises, we deleted a specific member who had never made a booking.
-- How can we make that more general, to delete all members who have never made a booking?
DELETE FROM cd.members AS m
WHERE NOT EXISTS (
  SELECT *
  FROM cd.bookings AS b
  WHERE m.memid = b.memid
);

/*
+--------+--------------------+------------+------------------------------------------+----------+-----------------+----------------+---------------------+
| memid  | surname            | firstname  | address                                  | zipcode  | telephone       | recommendedby  | joindate            |
+--------+--------------------+------------+------------------------------------------+----------+-----------------+----------------+---------------------+
| 0      | GUEST              | GUEST      | GUEST                                    | 0        | (000) 000-0000  |                | 2012-07-01 00:00:00 |
| 1      | Smith              | Darren     | 8 Bloomsbury Close, Boston               | 4321     | 555-555-5555    |                | 2012-07-02 12:02:05 |
| 2      | Smith              | Tracy      | 8 Bloomsbury Close, New York             | 4321     | 555-555-5555    |                | 2012-07-02 12:08:23 |
| 3      | Rownam             | Tim        | 23 Highway Way, Boston                   | 23423    | (844) 693-0723  |                | 2012-07-03 09:32:15 |
| 4      | Joplette           | Janice     | 20 Crossing Road, New York               | 234      | (833) 942-4710  | 1              | 2012-07-03 10:25:05 |
| 5      | Butters            | Gerald     | 1065 Huntingdon Avenue, Boston           | 56754    | (844) 078-4130  | 1              | 2012-07-09 10:44:09 |
| 6      | Tracy              | Burton     | 3 Tunisia Drive, Boston                  | 45678    | (822) 354-9973  |                | 2012-07-15 08:52:55 |
| 7      | Dare               | Nancy      | 6 Hunting Lodge Way, Boston              | 10383    | (833) 776-4001  | 4              | 2012-07-25 08:59:12 |
| 8      | Boothe             | Tim        | 3 Bloomsbury Close, Reading, 00234       | 234      | (811) 433-2547  | 3              | 2012-07-25 16:02:35 |
| 9      | Stibbons           | Ponder     | 5 Dragons Way, Winchester                | 87630    | (833) 160-3900  | 6              | 2012-07-25 17:09:05 |
| 10     | Owen               | Charles    | 52 Cheshire Grove, Winchester, 28563     | 28563    | (855) 542-5251  | 1              | 2012-08-03 19:42:37 |
| 11     | Jones              | David      | 976 Gnats Close, Reading                 | 33862    | (844) 536-8036  | 4              | 2012-08-06 16:32:55 |
| 12     | Baker              | Anne       | 55 Powdery Street, Boston                | 80743    | 844-076-5141    | 9              | 2012-08-10 14:23:22 |
| 13     | Farrell            | Jemima     | 103 Firth Avenue, North Reading          | 57392    | (855) 016-0163  |                | 2012-08-10 14:28:01 |
| 14     | Smith              | Jack       | 252 Binkington Way, Boston               | 69302    | (822) 163-3254  | 1              | 2012-08-10 16:22:05 |
| 15     | Bader              | Florence   | 264 Ursula Drive, Westford               | 84923    | (833) 499-3527  | 9              | 2012-08-10 17:52:03 |
| 16     | Baker              | Timothy    | 329 James Street, Reading                | 58393    | 833-941-0824    | 13             | 2012-08-15 10:34:25 |
| 17     | Pinker             | David      | 5 Impreza Road, Boston                   | 65332    | 811 409-6734    | 13             | 2012-08-16 11:32:47 |
| 20     | Genting            | Matthew    | 4 Nunnington Place, Wingfield, Boston    | 52365    | (811) 972-1377  | 5              | 2012-08-19 14:55:55 |
| 21     | Mackenzie          | Anna       | 64 Perkington Lane, Reading              | 64577    | (822) 661-2898  | 1              | 2012-08-26 09:32:05 |
| 22     | Coplin             | Joan       | 85 Bard Street, Bloomington, Boston      | 43533    | (822) 499-2232  | 16             | 2012-08-29 08:32:41 |
| 24     | Sarwin             | Ramnaresh  | 12 Bullington Lane, Boston               | 65464    | (822) 413-1470  | 15             | 2012-09-01 08:44:42 |
| 26     | Jones              | Douglas    | 976 Gnats Close, Reading                 | 11986    | 844 536-8036    | 11             | 2012-09-02 18:43:05 |
| 27     | Rumney             | Henrietta  | 3 Burkington Plaza, Boston               | 78533    | (822) 989-8876  | 20             | 2012-09-05 08:42:35 |
| 28     | Farrell            | David      | 437 Granite Farm Road, Westford          | 43532    | (855) 755-9876  |                | 2012-09-15 08:22:05 |
| 29     | Worthington-Smyth  | Henry      | 55 Jagbi Way, North Reading              | 97676    | (855) 894-3758  | 2              | 2012-09-17 12:27:15 |
| 30     | Purview            | Millicent  | 641 Drudgery Close, Burnington, Boston   | 34232    | (855) 941-9786  | 2              | 2012-09-18 19:04:01 |
| 33     | Tupperware         | Hyacinth   | 33 Cheerful Plaza, Drake Road, Westford  | 68666    | (822) 665-5327  |                | 2012-09-18 19:32:05 |
| 35     | Hunt               | John       | 5 Bullington Lane, Boston                | 54333    | (899) 720-6978  | 30             | 2012-09-19 11:32:45 |
| 36     | Crumpet            | Erica      | Crimson Road, North Reading              | 75655    | (811) 732-4816  | 2              | 2012-09-22 08:36:38 |
+--------+--------------------+------------+------------------------------------------+----------+-----------------+----------------+---------------------+
*/

